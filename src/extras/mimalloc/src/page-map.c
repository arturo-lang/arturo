/*----------------------------------------------------------------------------
Copyright (c) 2023-2024, Microsoft Research, Daan Leijen
This is free software; you can redistribute it and/or modify it under the
terms of the MIT license. A copy of the license can be found in the file
"LICENSE" at the root of this distribution.
-----------------------------------------------------------------------------*/

#include "mimalloc.h"
#include "mimalloc/internal.h"
#include "bitmap.h"

static void mi_page_map_cannot_commit(void) {
  _mi_warning_message("unable to commit the allocation page-map on-demand\n" );  
}

#if MI_PAGE_MAP_FLAT 

// The page-map contains a byte for each 64kb slice in the address space.
// For an address `a` where `ofs = _mi_page_map[a >> 16]`:
// 0 = unused
// 1 = the slice at `a & ~0xFFFF` is a mimalloc page.
// 1 < ofs <= 127 = the slice is part of a page, starting at `(((a>>16) - ofs - 1) << 16)`.
//
// 1 byte per slice => 1 TiB address space needs a 2^14 * 2^16 = 16 MiB page map.
// A full 256 TiB address space (48 bit) needs a 4 GiB page map.
// A full 4 GiB address space (32 bit) needs only a 64 KiB page map.

mi_decl_cache_align uint8_t* _mi_page_map = NULL;
static void*        mi_page_map_max_address = NULL;
static mi_memid_t   mi_page_map_memid;

#define MI_PAGE_MAP_ENTRIES_PER_COMMIT_BIT   MI_ARENA_SLICE_SIZE
static mi_bitmap_t* mi_page_map_commit; // one bit per committed 64 KiB entries

mi_decl_nodiscard static bool mi_page_map_ensure_committed(size_t idx, size_t slice_count);

bool _mi_page_map_init(void) {
  size_t vbits = (size_t)mi_option_get_clamp(mi_option_max_vabits, 0, MI_SIZE_BITS);
  if (vbits == 0) {
    vbits = _mi_os_virtual_address_bits();
    #if MI_ARCH_X64  // canonical address is limited to the first 128 TiB
    if (vbits >= 48) { vbits = 47; }
    #endif
  }

  // Allocate the page map and commit bits
  mi_page_map_max_address = (void*)(vbits >= MI_SIZE_BITS ? (SIZE_MAX - MI_ARENA_SLICE_SIZE + 1) : (MI_PU(1) << vbits));
  const size_t page_map_size = (MI_ZU(1) << (vbits - MI_ARENA_SLICE_SHIFT));
  const bool commit = (page_map_size <= 1*MI_MiB || mi_option_is_enabled(mi_option_pagemap_commit)); // _mi_os_has_overcommit(); // commit on-access on Linux systems?
  const size_t commit_bits = _mi_divide_up(page_map_size, MI_PAGE_MAP_ENTRIES_PER_COMMIT_BIT);
  const size_t bitmap_size = (commit ? 0 : mi_bitmap_size(commit_bits, NULL));
  const size_t reserve_size = bitmap_size + page_map_size;
  uint8_t* const base = (uint8_t*)_mi_os_alloc_aligned(reserve_size, 1, commit, true /* allow large */, &mi_page_map_memid);
  if (base==NULL) {
    _mi_error_message(ENOMEM, "unable to reserve virtual memory for the page map (%zu KiB)\n", page_map_size / MI_KiB);
    return false;
  }
  if (mi_page_map_memid.initially_committed && !mi_page_map_memid.initially_zero) {
    _mi_warning_message("internal: the page map was committed but not zero initialized!\n");
    _mi_memzero_aligned(base, reserve_size);
  }
  if (bitmap_size > 0) {
    mi_page_map_commit = (mi_bitmap_t*)base;
    if (!_mi_os_commit(mi_page_map_commit, bitmap_size, NULL)) {
      mi_page_map_cannot_commit();
      return false;
    }
    mi_bitmap_init(mi_page_map_commit, commit_bits, true);
  }
  _mi_page_map = base + bitmap_size;

  // commit the first part so NULL pointers get resolved without an access violation
  if (!commit) {
    if (!mi_page_map_ensure_committed(0, 1)) {
      mi_page_map_cannot_commit();
      return false;
    }
  }
  _mi_page_map[0] = 1; // so _mi_ptr_page(NULL) == NULL
  mi_assert_internal(_mi_ptr_page(NULL)==NULL);
  return true;
}

static bool mi_page_map_ensure_committed(size_t idx, size_t slice_count) {
  // is the page map area that contains the page address committed?
  // we always set the commit bits so we can track what ranges are in-use.
  // we only actually commit if the map wasn't committed fully already.
  if (mi_page_map_commit != NULL) {
    const size_t commit_idx = idx / MI_PAGE_MAP_ENTRIES_PER_COMMIT_BIT;
    const size_t commit_idx_hi = (idx + slice_count - 1) / MI_PAGE_MAP_ENTRIES_PER_COMMIT_BIT;
    for (size_t i = commit_idx; i <= commit_idx_hi; i++) {  // per bit to avoid crossing over bitmap chunks
      if (mi_bitmap_is_clear(mi_page_map_commit, i)) {
        // this may race, in which case we do multiple commits (which is ok)        
        bool is_zero;
        uint8_t* const start = _mi_page_map + (i * MI_PAGE_MAP_ENTRIES_PER_COMMIT_BIT);
        const size_t   size  = MI_PAGE_MAP_ENTRIES_PER_COMMIT_BIT;
        if (!_mi_os_commit(start, size, &is_zero)) {
          mi_page_map_cannot_commit();
          return false;
        }
        if (!is_zero && !mi_page_map_memid.initially_zero) { _mi_memzero(start, size); }        
        mi_bitmap_set(mi_page_map_commit, i);
      }
    }
  }
  #if MI_DEBUG > 0
  _mi_page_map[idx] = 0;
  _mi_page_map[idx+slice_count-1] = 0;
  #endif
  return true;
}


static size_t mi_page_map_get_idx(mi_page_t* page, uint8_t** page_start, size_t* slice_count) {
  size_t page_size;
  *page_start = mi_page_area(page, &page_size);
  if (page_size > MI_LARGE_PAGE_SIZE) { page_size = MI_LARGE_PAGE_SIZE - MI_ARENA_SLICE_SIZE; }  // furthest interior pointer
  *slice_count = mi_slice_count_of_size(page_size) + (((uint8_t*)*page_start - (uint8_t*)page)/MI_ARENA_SLICE_SIZE); // add for large aligned blocks
  return _mi_page_map_index(page);
}

bool _mi_page_map_register(mi_page_t* page) {
  mi_assert_internal(page != NULL);
  mi_assert_internal(_mi_is_aligned(page, MI_PAGE_ALIGN));
  mi_assert_internal(_mi_page_map != NULL);  // should be initialized before multi-thread access!
  if mi_unlikely(_mi_page_map == NULL) {
    if (!_mi_page_map_init()) return false;
  }
  mi_assert(_mi_page_map!=NULL);
  uint8_t* page_start;
  size_t   slice_count;
  const size_t idx = mi_page_map_get_idx(page, &page_start, &slice_count);

  if (!mi_page_map_ensure_committed(idx, slice_count)) {
    return false;
  }

  // set the offsets
  for (size_t i = 0; i < slice_count; i++) {
    mi_assert_internal(i < 128);
    _mi_page_map[idx + i] = (uint8_t)(i+1);
  }
  return true;
}

void _mi_page_map_unregister(mi_page_t* page) {
  mi_assert_internal(_mi_page_map != NULL);
  // get index and count
  uint8_t* page_start;
  size_t   slice_count;
  const size_t idx = mi_page_map_get_idx(page, &page_start, &slice_count);
  // unset the offsets
  _mi_memzero(_mi_page_map + idx, slice_count);
}

void _mi_page_map_unregister_range(void* start, size_t size) {
  const size_t slice_count = _mi_divide_up(size, MI_ARENA_SLICE_SIZE);
  const uintptr_t index = _mi_page_map_index(start);
  // todo: scan the commit bits and clear only those ranges?
  if (!mi_page_map_ensure_committed(index, slice_count)) { // we commit the range in total; 
    return;
  }        
  _mi_memzero(&_mi_page_map[index], slice_count);
}


mi_page_t* _mi_safe_ptr_page(const void* p) {
  if mi_unlikely(p >= mi_page_map_max_address) return NULL;
  const uintptr_t idx = _mi_page_map_index(p);
  if mi_unlikely(mi_page_map_commit != NULL && !mi_bitmap_is_set(mi_page_map_commit, idx/MI_PAGE_MAP_ENTRIES_PER_COMMIT_BIT)) return NULL;
  const uintptr_t ofs = _mi_page_map[idx];
  if mi_unlikely(ofs == 0) return NULL;
  return (mi_page_t*)((((uintptr_t)p >> MI_ARENA_SLICE_SHIFT) - ofs + 1) << MI_ARENA_SLICE_SHIFT);
}

mi_decl_nodiscard mi_decl_export bool mi_is_in_heap_region(const void* p) mi_attr_noexcept {
  return (_mi_safe_ptr_page(p) != NULL);
}

#else

// A 2-level page map
#define MI_PAGE_MAP_SUB_SIZE    (MI_PAGE_MAP_SUB_COUNT * sizeof(mi_page_t*))

mi_decl_cache_align mi_submap_t* _mi_page_map;
static void*        mi_page_map_max_address;
static mi_memid_t   mi_page_map_memid;

static _Atomic(mi_bfield_t)  mi_page_map_commit; 

mi_decl_nodiscard static bool mi_page_map_ensure_committed(size_t idx, mi_submap_t* submap);
mi_decl_nodiscard static bool mi_page_map_ensure_at(size_t idx, mi_submap_t* submap);
static bool mi_page_map_set_range(mi_page_t* page, size_t idx, size_t sub_idx, size_t slice_count);

bool _mi_page_map_init(void) {
  size_t vbits = (size_t)mi_option_get_clamp(mi_option_max_vabits, 0, MI_SIZE_BITS);
  if (vbits == 0) {
    vbits = _mi_os_virtual_address_bits();
    #if MI_ARCH_X64  // canonical address is limited to the first 128 TiB
    if (vbits >= 48) { vbits = 47; }
    #endif
  }

  // Allocate the page map and commit bits
  mi_assert(MI_MAX_VABITS >= vbits);
  mi_page_map_max_address = (void*)(vbits >= MI_SIZE_BITS ? (SIZE_MAX - MI_ARENA_SLICE_SIZE + 1) : (MI_PU(1) << vbits));
  const size_t page_map_count = (MI_ZU(1) << (vbits - MI_PAGE_MAP_SUB_SHIFT - MI_ARENA_SLICE_SHIFT));
  mi_assert(page_map_count <= MI_PAGE_MAP_COUNT);
  const size_t os_page_size = _mi_os_page_size();
  const size_t page_map_size = _mi_align_up( page_map_count * sizeof(mi_page_t**), os_page_size);
  const size_t reserve_size = page_map_size + os_page_size;
  const bool commit = page_map_size <= 64*MI_KiB || 
                      mi_option_is_enabled(mi_option_pagemap_commit) || _mi_os_has_overcommit(); 
  _mi_page_map = (mi_page_t***)_mi_os_alloc_aligned(reserve_size, 1, commit, true /* allow large */, &mi_page_map_memid);
  if (_mi_page_map==NULL) {
    _mi_error_message(ENOMEM, "unable to reserve virtual memory for the page map (%zu KiB)\n", page_map_size / MI_KiB);
    return false;
  }
  if (mi_page_map_memid.initially_committed && !mi_page_map_memid.initially_zero) {
    _mi_warning_message("internal: the page map was committed but not zero initialized!\n");
    _mi_memzero_aligned(_mi_page_map, page_map_size);
  }
  mi_atomic_store_release(&mi_page_map_commit, (commit ? ~MI_ZU(0) : MI_ZU(0)));

  // note: for the NULL range we only commit one OS page (in the map and sub)
  if (!mi_page_map_memid.initially_committed) {
    if (!_mi_os_commit(&_mi_page_map[0], os_page_size, NULL)) {  // commit first part of the map
      mi_page_map_cannot_commit();
      return false;
    }
  }
  _mi_page_map[0] = (mi_page_t**)((uint8_t*)_mi_page_map + page_map_size);  // we reserved 2 sub maps at the end already
  if (!mi_page_map_memid.initially_committed) {
    if (!_mi_os_commit(_mi_page_map[0], os_page_size, NULL)) {   // only first OS page
      mi_page_map_cannot_commit();
      return false;
    }
  }
  _mi_page_map[0][0] = (mi_page_t*)&_mi_page_empty;       // caught in `mi_free`
  
  mi_assert_internal(_mi_ptr_page(NULL)==&_mi_page_empty);
  return true;
}


#define MI_PAGE_MAP_ENTRIES_PER_CBIT  (MI_PAGE_MAP_COUNT / MI_BFIELD_BITS)

static inline bool mi_page_map_is_committed(size_t idx, size_t* pbit_idx) {
  mi_bfield_t commit = mi_atomic_load_relaxed(&mi_page_map_commit);
  const size_t bit_idx = idx/MI_PAGE_MAP_ENTRIES_PER_CBIT; 
  mi_assert_internal(bit_idx < MI_BFIELD_BITS);
  if (pbit_idx != NULL) { *pbit_idx = bit_idx; }
  return ((commit & (MI_ZU(1) << bit_idx)) != 0);
}

static bool mi_page_map_ensure_committed(size_t idx, mi_submap_t* submap) {
  mi_assert_internal(submap!=NULL && *submap==NULL);
  size_t bit_idx;
  if mi_unlikely(!mi_page_map_is_committed(idx, &bit_idx)) {
    uint8_t* start = (uint8_t*)&_mi_page_map[bit_idx * MI_PAGE_MAP_ENTRIES_PER_CBIT];
    if (!_mi_os_commit(start, MI_PAGE_MAP_ENTRIES_PER_CBIT * sizeof(mi_submap_t), NULL)) {
      mi_page_map_cannot_commit();
      return false;
    }
    mi_atomic_or_acq_rel(&mi_page_map_commit, MI_ZU(1) << bit_idx);
  }
  *submap = _mi_page_map[idx];
  return true;
}

static bool mi_page_map_ensure_at(size_t idx, mi_submap_t* submap) {
  mi_assert_internal(submap!=NULL && *submap==NULL);
  mi_submap_t sub = NULL;
  if (!mi_page_map_ensure_committed(idx,&sub)) {
    return false;
  }
  if mi_unlikely(sub==NULL) {
    // sub map not yet allocated, allocate it now
    mi_memid_t memid;
    sub = (mi_submap_t)_mi_os_zalloc(MI_PAGE_MAP_SUB_SIZE, &memid);
    if (sub==NULL) {
       _mi_warning_message("unable to extend the page map\n");
       return false;
    }
    mi_page_t** expect = NULL;
    if (!mi_atomic_cas_strong_acq_rel(((_Atomic(mi_submap_t)*)&_mi_page_map[idx]), &expect, sub)) {
      // another thread already allocated it.. free and continue
      _mi_os_free(sub, MI_PAGE_MAP_SUB_SIZE, memid);
      sub = expect;
    }   
  }
  mi_assert_internal(sub!=NULL);
  *submap = sub;
  return true;
}

static bool mi_page_map_set_range_prim(mi_page_t* page, size_t idx, size_t sub_idx, size_t slice_count) {
  // is the page map area that contains the page address committed?
  while (slice_count > 0) {
    mi_submap_t sub = NULL;
    if (!mi_page_map_ensure_at(idx, &sub)) {
      return false;
    };
    mi_assert_internal(sub!=NULL);
    // set the offsets for the page
    while (slice_count > 0 && sub_idx < MI_PAGE_MAP_SUB_COUNT) {
      sub[sub_idx] = page;
      slice_count--;
      sub_idx++;      
    }
    idx++; // potentially wrap around to the next idx
    sub_idx = 0; 
  }
  return true;
}

static bool mi_page_map_set_range(mi_page_t* page, size_t idx, size_t sub_idx, size_t slice_count) {
  if mi_unlikely(!mi_page_map_set_range_prim(page,idx,sub_idx,slice_count)) {
    // failed to commit, call again to reset the page pointer (if needed)
    if (page!=NULL) {
      mi_page_map_set_range_prim(NULL,idx,sub_idx,slice_count);
    }
    return false;
  }
  return true;
}

static size_t mi_page_map_get_idx(mi_page_t* page, size_t* sub_idx, size_t* slice_count) {
  size_t page_size;
  uint8_t* page_start = mi_page_area(page, &page_size);
  if (page_size > MI_LARGE_PAGE_SIZE) { page_size = MI_LARGE_PAGE_SIZE - MI_ARENA_SLICE_SIZE; }  // furthest interior pointer
  *slice_count = mi_slice_count_of_size(page_size) + ((page_start - (uint8_t*)page)/MI_ARENA_SLICE_SIZE); // add for large aligned blocks
  return _mi_page_map_index(page, sub_idx);
}

bool _mi_page_map_register(mi_page_t* page) {
  mi_assert_internal(page != NULL);
  mi_assert_internal(_mi_is_aligned(page, MI_PAGE_ALIGN));
  mi_assert_internal(_mi_page_map != NULL);  // should be initialized before multi-thread access!
  if mi_unlikely(_mi_page_map == NULL) {
    if (!_mi_page_map_init()) return false;
  }
  mi_assert(_mi_page_map!=NULL);
  size_t   slice_count;
  size_t   sub_idx;
  const size_t idx = mi_page_map_get_idx(page, &sub_idx, &slice_count);
  return mi_page_map_set_range(page, idx, sub_idx, slice_count);
}

void _mi_page_map_unregister(mi_page_t* page) {
  mi_assert_internal(_mi_page_map != NULL);
  mi_assert_internal(page != NULL);
  mi_assert_internal(_mi_is_aligned(page, MI_PAGE_ALIGN));
  if mi_unlikely(_mi_page_map == NULL) return;
  // get index and count
  size_t slice_count;
  size_t sub_idx;
  const size_t idx = mi_page_map_get_idx(page, &sub_idx, &slice_count);
  // unset the offsets
  mi_page_map_set_range(NULL, idx, sub_idx, slice_count);
}

void _mi_page_map_unregister_range(void* start, size_t size) {
  if mi_unlikely(_mi_page_map == NULL) return;
  const size_t slice_count = _mi_divide_up(size, MI_ARENA_SLICE_SIZE);
  size_t sub_idx;
  const uintptr_t idx = _mi_page_map_index(start, &sub_idx);
  mi_page_map_set_range(NULL, idx, sub_idx, slice_count);  // todo: avoid committing if not already committed?
}

// Return NULL for invalid pointers
mi_page_t* _mi_safe_ptr_page(const void* p) {
  if (p==NULL) return NULL;
  if mi_unlikely(p >= mi_page_map_max_address) return NULL;
  size_t sub_idx;
  const size_t idx = _mi_page_map_index(p,&sub_idx);
  if mi_unlikely(!mi_page_map_is_committed(idx,NULL)) return NULL;
  mi_page_t** const sub = _mi_page_map[idx];
  if mi_unlikely(sub==NULL) return NULL;
  return sub[sub_idx];
}

mi_decl_nodiscard mi_decl_export bool mi_is_in_heap_region(const void* p) mi_attr_noexcept {
  return (_mi_safe_ptr_page(p) != NULL);
}

#endif
