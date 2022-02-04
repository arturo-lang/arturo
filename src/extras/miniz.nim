# Original Nim port
# Copyright (c) 2017 Fabio Cevasco 

{.compile: "libminiz.c".}

import strutils

when defined(i386) or defined(ia64):
    const 
      MINIZ_X86_OR_X64_CPU* = 1
  # when little endian...
  #const 
  #  MINIZ_LITTLE_ENDIAN* = 1
when defined(MINIZ_X86_OR_X64_CPU): 
  # Set MINIZ_USE_UNALIGNED_LOADS_AND_STORES to 1 on CPU's that permit efficient integer loads and stores from unaligned addresses.
  const 
    MINIZ_USE_UNALIGNED_LOADS_AND_STORES* = 1
when defined(ia64): 
  # Set MINIZ_HAS_64BIT_REGISTERS to 1 if operations on 64-bit integers are reasonably fast (and don't involve compiler generated calls to helper functions).
  const 
    MINIZ_HAS_64BIT_REGISTERS* = 1
# ------------------- zlib-style API Definitions.
# For more compatibility with zlib, miniz.c uses unsigned long for some parameters/struct members. Beware: mz_ulong can be either 32 or 64-bits!

type 
  mz_ulong* = culong

# mz_free() internally uses the MZ_FREE() macro (which by default calls free() unless you've modified the MZ_MALLOC macro) to release a block allocated from the heap.

func mz_free*(p: pointer) {.importc.}
const 
  MZ_ADLER32_INIT* = (1)

# mz_adler32() returns the initial adler-32 value to use when called with ptr==NULL.

func mz_adler32*(adler: mz_ulong, pointr: ptr uint8, buf_len: csize_t): mz_ulong {.importc.}
const 
  MZ_CRC32_INIT* = (0)

# mz_crc32() returns the initial CRC-32 value to use when called with ptr==NULL.

func mz_crc32*(crc: mz_ulong; pointr: ptr uint8; buf_len: csize_t): mz_ulong {.importc.}
# Compression strategies.

const 
  MZ_DEFAULT_STRATEGY* = 0
  MZ_FILTERED* = 1
  MZ_HUFFMAN_ONLY* = 2
  MZ_RLE* = 3
  MZ_FIXED* = 4

# Method

const 
  MZ_DEFLATED* = 8

when not(defined(MINIZ_NO_ZLIB_APIS)): 
  # Heap allocation callbacks.
  # Note that mz_alloc_func parameter types purpsosely differ from zlib's: items/size is size_t, not unsigned long.
  type 
    mz_alloc_func* = proc (opaque: pointer; items: csize_t; size: csize_t): pointer {.noconv.}
    mz_free_func* = proc (opaque: pointer; address: pointer)  {.noconv.}
    mz_realloc_func* = proc (opaque: pointer; address: pointer; items: csize_t; 
                             size: csize_t): pointer {.noconv.}
  const 
    MZ_VERSION* = "9.1.15"
    MZ_VERNUM* = 0x000091F0
    MZ_VER_MAJOR* = 9
    MZ_VER_MINOR* = 1
    MZ_VER_REVISION* = 15
    MZ_VER_SUBREVISION* = 0
  # Flush values. For typical usage you only need MZ_NO_FLUSH and MZ_FINISH. The other values are for advanced use (refer to the zlib docs).
  const 
    MZ_NO_FLUSH* = 0
    MZ_PARTIAL_FLUSH* = 1
    MZ_SYNC_FLUSH* = 2
    MZ_FULL_FLUSH* = 3
    MZ_FINISH* = 4
    MZ_BLOCK* = 5
  # Return status codes. MZ_PARAM_ERROR is non-standard.
  const 
    MZ_OK* = 0
    MZ_STREAM_END* = 1
    MZ_NEED_DICT* = 2
    MZ_ERRNO* = - 1
    MZ_STREAM_ERROR* = - 2
    MZ_DATA_ERROR* = - 3
    MZ_MEM_ERROR* = - 4
    MZ_BUF_ERROR* = - 5
    MZ_VERSION_ERROR* = - 6
    MZ_PARAM_ERROR* = - 10000
  # Compression levels: 0-9 are the standard zlib-style levels, 10 is best possible compression (not zlib compatible, and may be very slow), MZ_DEFAULT_COMPRESSION=MZ_DEFAULT_LEVEL.
  const 
    MZ_NO_COMPRESSION* = 0
    MZ_BEST_SPEED* = 1
    MZ_BEST_COMPRESSION* = 9
    MZ_UBER_COMPRESSION* = 10
    MZ_DEFAULT_LEVEL* = 6
    MZ_DEFAULT_COMPRESSION* = - 1
  # Window bits
  const 
    MZ_DEFAULT_WINDOW_BITS* = 15
  type 
    mz_internal_state* = object 
    
  # Compression/decompression stream struct.
  type 
    mz_stream* = object 
      next_in*: ptr uint8    # pointer to next byte to read
      avail_in*: cuint        # number of bytes available at next_in
      total_in*: mz_ulong     # total number of bytes consumed so far
      next_out*: ptr uint8   # pointer to next byte to write
      avail_out*: cuint       # number of bytes that can be written to next_out
      total_out*: mz_ulong    # total number of bytes produced so far
      msg*: cstring           # error msg (unused)
      state*: ptr mz_internal_state # internal state, allocated by zalloc/zfree
      zalloc*: mz_alloc_func  # optional heap allocation function (defaults to malloc)
      zfree*: mz_free_func    # optional heap free function (defaults to free)
      opaque*: pointer        # heap alloc function user pointer
      data_type*: cint        # data_type (unused)
      adler*: mz_ulong        # adler32 of the source or uncompressed data
      reserved*: mz_ulong     # not used
    
    mz_streamp* = ptr mz_stream
  # Returns the version string of miniz.c.
  func mz_version*(): cstring {.importc.}
  # mz_deflateInit() initializes a compressor with default options:
  # Parameters:
  #  pStream must point to an initialized mz_stream struct.
  #  level must be between [MZ_NO_COMPRESSION, MZ_BEST_COMPRESSION].
  #  level 1 enables a specially optimized compression function that's been optimized purely for performance, not ratio.
  #  (This special func. is currently only enabled when MINIZ_USE_UNALIGNED_LOADS_AND_STORES and MINIZ_LITTLE_ENDIAN are defined.)
  # Return values:
  #  MZ_OK on success.
  #  MZ_STREAM_ERROR if the stream is bogus.
  #  MZ_PARAM_ERROR if the input parameters are bogus.
  #  MZ_MEM_ERROR on out of memory.
  func mz_deflateInit*(pStream: mz_streamp; level: cint): cint {.importc.}
  # mz_deflateInit2() is like mz_deflate(), except with more control:
  # Additional parameters:
  #   method must be MZ_DEFLATED
  #   window_bits must be MZ_DEFAULT_WINDOW_BITS (to wrap the deflate stream with zlib header/adler-32 footer) or -MZ_DEFAULT_WINDOW_BITS (raw deflate/no header or footer)
  #   mem_level must be between [1, 9] (it's checked but ignored by miniz.c)
  func mz_deflateInit2*(pStream: mz_streamp; level: cint; meth: cint; 
                        window_bits: cint; mem_level: cint; strategy: cint): cint {.importc.}
  # Quickly resets a compressor without having to reallocate anything. Same as calling mz_deflateEnd() followed by mz_deflateInit()/mz_deflateInit2().
  func mz_deflateReset*(pStream: mz_streamp): cint {.importc.}
  # mz_deflate() compresses the input to output, consuming as much of the input and producing as much output as possible.
  # Parameters:
  #   pStream is the stream to read from and write to. You must initialize/update the next_in, avail_in, next_out, and avail_out members.
  #   flush may be MZ_NO_FLUSH, MZ_PARTIAL_FLUSH/MZ_SYNC_FLUSH, MZ_FULL_FLUSH, or MZ_FINISH.
  # Return values:
  #   MZ_OK on success (when flushing, or if more input is needed but not available, and/or there's more output to be written but the output buffer is full).
  #   MZ_STREAM_END if all input has been consumed and all output bytes have been written. Don't call mz_deflate() on the stream anymore.
  #   MZ_STREAM_ERROR if the stream is bogus.
  #   MZ_PARAM_ERROR if one of the parameters is invalid.
  #   MZ_BUF_ERROR if no forward progress is possible because the input and/or output buffers are empty. (Fill up the input buffer or free up some output space and try again.)
  func mz_deflate*(pStream: mz_streamp; flush: cint): cint {.importc.}
  # mz_deflateEnd() deinitializes a compressor:
  # Return values:
  #  MZ_OK on success.
  #  MZ_STREAM_ERROR if the stream is bogus.
  func mz_deflateEnd*(pStream: mz_streamp): cint {.importc.}
  # mz_deflateBound() returns a (very) conservative upper bound on the amount of data that could be generated by deflate(), assuming flush is set to only MZ_NO_FLUSH or MZ_FINISH.
  func mz_deflateBound*(pStream: mz_streamp; source_len: mz_ulong): mz_ulong {.importc.}
  # Single-call compression functions mz_compress() and mz_compress2():
  # Returns MZ_OK on success, or one of the error codes from mz_deflate() on failure.
  func mz_compress*(pDest: ptr uint8; pDest_len: ptr mz_ulong; 
                    pSource: ptr uint8; source_len: mz_ulong): cint {.importc.}
  func mz_compress2*(pDest: ptr uint8; pDest_len: ptr mz_ulong; 
                     pSource: ptr uint8; source_len: mz_ulong; level: cint): cint {.importc.}
  # mz_compressBound() returns a (very) conservative upper bound on the amount of data that could be generated by calling mz_compress().
  func mz_compressBound*(source_len: mz_ulong): mz_ulong {.importc.}
  # Initializes a decompressor.
  func mz_inflateInit*(pStream: mz_streamp): cint {.importc.}
  # mz_inflateInit2() is like mz_inflateInit() with an additional option that controls the window size and whether or not the stream has been wrapped with a zlib header/footer:
  # window_bits must be MZ_DEFAULT_WINDOW_BITS (to parse zlib header/footer) or -MZ_DEFAULT_WINDOW_BITS (raw deflate).
  func mz_inflateInit2*(pStream: mz_streamp; window_bits: cint): cint {.importc.}
  # Decompresses the input stream to the output, consuming only as much of the input as needed, and writing as much to the output as possible.
  # Parameters:
  #   pStream is the stream to read from and write to. You must initialize/update the next_in, avail_in, next_out, and avail_out members.
  #   flush may be MZ_NO_FLUSH, MZ_SYNC_FLUSH, or MZ_FINISH.
  #   On the first call, if flush is MZ_FINISH it's assumed the input and output buffers are both sized large enough to decompress the entire stream in a single call (this is slightly faster).
  #   MZ_FINISH implies that there are no more source bytes available beside what's already in the input buffer, and that the output buffer is large enough to hold the rest of the decompressed data.
  # Return values:
  #   MZ_OK on success. Either more input is needed but not available, and/or there's more output to be written but the output buffer is full.
  #   MZ_STREAM_END if all needed input has been consumed and all output bytes have been written. For zlib streams, the adler-32 of the decompressed data has also been verified.
  #   MZ_STREAM_ERROR if the stream is bogus.
  #   MZ_DATA_ERROR if the deflate stream is invalid.
  #   MZ_PARAM_ERROR if one of the parameters is invalid.
  #   MZ_BUF_ERROR if no forward progress is possible because the input buffer is empty but the inflater needs more input to continue, or if the output buffer is not large enough. Call mz_inflate() again
  #   with more input data, or with more room in the output buffer (except when using single call decompression, described above).
  func mz_inflate*(pStream: mz_streamp; flush: cint): cint {.importc.}
  # Deinitializes a decompressor.
  func mz_inflateEnd*(pStream: mz_streamp): cint {.importc.}
  # Single-call decompression.
  # Returns MZ_OK on success, or one of the error codes from mz_inflate() on failure.
  func mz_uncompress*(pDest: ptr uint8; pDest_len: ptr mz_ulong; 
                      pSource: ptr uint8; source_len: mz_ulong): cint {.importc.}
  # Returns a string description of the specified error code, or NULL if the error code is invalid.
  func mz_error*(err: cint): cstring {.importc.}
  # Redefine zlib-compatible names to miniz equivalents, so miniz.c can be used as a drop-in replacement for the subset of zlib that miniz.c supports.
  # Define MINIZ_NO_ZLIB_COMPATIBLE_NAMES to disable zlib-compatibility if you use zlib in the same project.
  when not(defined(MINIZ_NO_ZLIB_COMPATIBLE_NAMES)): 
    type 
      Byte* = uint8
      uInt* = cuint
      uLong* = mz_ulong
      Bytef* = Byte
      uIntf* = uInt
      charf* = char
      intf* = cint
      voidpf* = pointer
      uLongf* = uLong
      voidp* = pointer
      voidpc* = pointer
    const 
      Z_NULL* = 0
      Z_NO_FLUSH* = MZ_NO_FLUSH
      Z_PARTIAL_FLUSH* = MZ_PARTIAL_FLUSH
      Z_SYNC_FLUSH* = MZ_SYNC_FLUSH
      Z_FULL_FLUSH* = MZ_FULL_FLUSH
      Z_FINISH* = MZ_FINISH
      Z_BLOCK* = MZ_BLOCK
      Z_OK* = MZ_OK
      Z_STREAM_END* = MZ_STREAM_END
      Z_NEED_DICT* = MZ_NEED_DICT
      Z_ERRNO* = MZ_ERRNO
      Z_STREAM_ERROR* = MZ_STREAM_ERROR
      Z_DATA_ERROR* = MZ_DATA_ERROR
      Z_MEM_ERROR* = MZ_MEM_ERROR
      Z_BUF_ERROR* = MZ_BUF_ERROR
      Z_VERSION_ERROR* = MZ_VERSION_ERROR
      Z_PARAM_ERROR* = MZ_PARAM_ERROR
      Z_NO_COMPRESSION* = MZ_NO_COMPRESSION
      Z_BEST_SPEED* = MZ_BEST_SPEED
      Z_BEST_COMPRESSION* = MZ_BEST_COMPRESSION
      Z_DEFAULT_COMPRESSION* = MZ_DEFAULT_COMPRESSION
      Z_DEFAULT_STRATEGY* = MZ_DEFAULT_STRATEGY
      Z_FILTERED* = MZ_FILTERED
      Z_HUFFMAN_ONLY* = MZ_HUFFMAN_ONLY
      Z_RLE* = MZ_RLE
      Z_FIXED* = MZ_FIXED
      Z_DEFLATED* = MZ_DEFLATED
      Z_DEFAULT_WINDOW_BITS* = MZ_DEFAULT_WINDOW_BITS
    type
      alloc_func* = mz_alloc_func
      free_func* = mz_free_func
      internal_state* = mz_internal_state
      z_stream* = mz_stream
    const
      deflateInit* = mz_deflateInit
      deflateInit2* = mz_deflateInit2
      deflateReset* = mz_deflateReset
      deflate* = mz_deflate
      deflateEnd* = mz_deflateEnd
      deflateBound* = mz_deflateBound
      compress* = mz_compress
      compress2* = mz_compress2
      compressBound* = mz_compressBound
      inflateInit* = mz_inflateInit
      inflateInit2* = mz_inflateInit2
      inflate* = mz_inflate
      inflateEnd* = mz_inflateEnd
      uncompress* = mz_uncompress
      crc32* = mz_crc32
      adler32* = mz_adler32
      MAX_WBITS* = 15
      MAX_MEM_LEVEL* = 9
      zError* = mz_error
      ZLIB_VERSION* = MZ_VERSION
      ZLIB_VERNUM* = MZ_VERNUM
      ZLIB_VER_MAJOR* = MZ_VER_MAJOR
      ZLIB_VER_MINOR* = MZ_VER_MINOR
      ZLIB_VER_REVISION* = MZ_VER_REVISION
      ZLIB_VER_SUBREVISION* = MZ_VER_SUBREVISION
      zlibVersion* = mz_version
      #zlib_version* = mz_version()
# ------------------- Types and macros

type 
  mz_uint8* = uint8
  mz_int16* = cshort
  mz_uint16* = cushort
  mz_uint32* = cuint
  mz_uint* = cuint
  mz_int64* = clonglong
  mz_uint64* = culonglong
  mz_bool* = cint

const 
  MZ_FALSE* = (0)
  MZ_TRUE* = (1)

# An attempt to work around MSVC's spammy "warning C4127: conditional expression is constant" message.

#when defined(_MSC_VER): 
#  const 
#    MZ_MACRO_END* = while(0, 0)
#else: 
#  const 
#    MZ_MACRO_END* = while(0)
# ------------------- ZIP archive reading/writing

type #FC defininf missing types
  time_t = cint
  size_t = cint

when not(defined(MINIZ_NO_ARCHIVE_APIS)): 
  const 
    MZ_ZIP_MAX_IO_BUF_SIZE* = 64 * 1024
    MZ_ZIP_MAX_ARCHIVE_FILENAME_SIZE* = 260
    MZ_ZIP_MAX_ARCHIVE_FILE_COMMENT_SIZE* = 256
  type 
    mz_zip_archive_file_stat* {.bycopy.} = object
      m_file_index*: mz_uint32
      m_central_dir_ofs*: mz_uint32
      m_version_made_by*: mz_uint16
      m_version_needed*: mz_uint16
      m_bit_flag*: mz_uint16
      m_method*: mz_uint16    ##ifndef MINIZ_NO_TIME
      m_time*: time_t         ##endif
      m_crc32*: mz_uint32
      m_comp_size*: mz_uint64
      m_uncomp_size*: mz_uint64
      m_internal_attr*: mz_uint16
      m_external_attr*: mz_uint32
      m_local_header_ofs*: mz_uint64
      m_comment_size*: mz_uint32
      m_filename*: array[MZ_ZIP_MAX_ARCHIVE_FILENAME_SIZE, char]
      m_comment*: array[MZ_ZIP_MAX_ARCHIVE_FILE_COMMENT_SIZE, char]

    mz_file_read_func* = proc (pOpaque: pointer; file_ofs: mz_uint64; 
                               pBuf: pointer; n: csize_t): csize_t {.noconv.}
    mz_file_write_func* = proc (pOpaque: pointer; file_ofs: mz_uint64; 
                                pBuf: pointer; n: csize_t): csize_t {.noconv.}
  type 
    mz_zip_internal_state_tag* = object 
    
  type 
    mz_zip_internal_state* = mz_zip_internal_state_tag
    mz_zip_mode* = enum 
      MZ_ZIP_MODE_INVALID = 0, MZ_ZIP_MODE_READING = 1, MZ_ZIP_MODE_WRITING = 2, 
      MZ_ZIP_MODE_WRITING_HAS_BEEN_FINALIZED = 3
    mz_zip_archive* = object 
      m_archive_size*: mz_uint64
      m_central_directory_file_ofs*: mz_uint64
      m_total_files*: mz_uint
      m_zip_mode*: mz_zip_mode
      m_file_offset_alignment*: mz_uint
      m_pAlloc*: mz_alloc_func
      m_pFree*: mz_free_func
      m_pRealloc*: mz_realloc_func
      m_pAlloc_opaque*: pointer
      m_pRead*: mz_file_read_func
      m_pWrite*: mz_file_write_func
      m_pIO_opaque*: pointer
      m_pState*: ptr mz_zip_internal_state

    mz_zip_flags* {.size: sizeof(cint).} = enum 
      MZ_ZIP_FLAG_CASE_SENSITIVE = 0x00000100, 
      MZ_ZIP_FLAG_IGNORE_PATH = 0x00000200, 
      MZ_ZIP_FLAG_COMPRESSED_DATA = 0x00000400, 
      MZ_ZIP_FLAG_DO_NOT_SORT_CENTRAL_DIRECTORY = 0x00000800
  # ZIP archive reading
  # Inits a ZIP archive reader.
  # These functions read and validate the archive's central directory.
  func mz_zip_reader_init*(pZip: ptr mz_zip_archive; size: mz_uint64; 
                           flags: mz_uint32): mz_bool {.importc.}
  func mz_zip_reader_init_mem*(pZip: ptr mz_zip_archive; pMem: pointer; 
                               size: csize_t; flags: mz_uint32): mz_bool {.importc.}
  when not(defined(MINIZ_NO_STDIO)): 
    proc mz_zip_reader_init_file*(pZip: ptr mz_zip_archive; pFilename: cstring; 
                                  flags: mz_uint32): mz_bool {.importc, cdecl.}
  # Returns the total number of files in the archive.
  func mz_zip_reader_get_num_files*(pZip: ptr mz_zip_archive): mz_uint {.importc, cdecl.}
  # Returns detailed information about an archive file entry.
  func mz_zip_reader_file_stat*(pZip: ptr mz_zip_archive; file_index: mz_uint; 
                                pStat: ptr mz_zip_archive_file_stat): mz_bool {.importc.}
  # Determines if an archive file entry is a directory entry.
  func mz_zip_reader_is_file_a_directory*(pZip: ptr mz_zip_archive; 
      file_index: mz_uint): mz_bool {.importc, cdecl.}
  func mz_zip_reader_is_file_encrypted*(pZip: ptr mz_zip_archive; 
                                        file_index: mz_uint): mz_bool {.importc.}
  # Retrieves the filename of an archive file entry.
  # Returns the number of bytes written to pFilename, or if filename_buf_size is 0 this function returns the number of bytes needed to fully store the filename.
  func mz_zip_reader_get_filename*(pZip: ptr mz_zip_archive; 
                                   file_index: mz_uint; pFilename: cstring; 
                                   filename_buf_size: mz_uint): mz_uint {.importc, cdecl.}
  # Attempts to locates a file in the archive's central directory.
  # Valid flags: MZ_ZIP_FLAG_CASE_SENSITIVE, MZ_ZIP_FLAG_IGNORE_PATH
  # Returns -1 if the file cannot be found.
  func mz_zip_reader_locate_file*(pZip: ptr mz_zip_archive; pName: cstring; 
                                  pComment: cstring; flags: mz_uint): cint {.importc, cdecl.}
  # Extracts a archive file to a memory buffer using no memory allocation.
  func mz_zip_reader_extract_to_mem_no_alloc*(pZip: ptr mz_zip_archive; 
      file_index: mz_uint; pBuf: pointer; buf_size: csize_t; flags: mz_uint; 
      pUser_read_buf: pointer; user_read_buf_size: csize_t): mz_bool {.importc.}
  func mz_zip_reader_extract_file_to_mem_no_alloc*(pZip: ptr mz_zip_archive; 
      pFilename: cstring; pBuf: pointer; buf_size: csize_t; flags: mz_uint; 
      pUser_read_buf: pointer; user_read_buf_size: csize_t): mz_bool {.importc.}
  # Extracts a archive file to a memory buffer.
  func mz_zip_reader_extract_to_mem*(pZip: ptr mz_zip_archive; 
                                     file_index: mz_uint; pBuf: pointer; 
                                     buf_size: csize_t; flags: mz_uint): mz_bool {.importc.}
  func mz_zip_reader_extract_file_to_mem*(pZip: ptr mz_zip_archive; 
      pFilename: cstring; pBuf: pointer; buf_size: csize_t; flags: mz_uint): mz_bool {.importc.}
  # Extracts a archive file to a dynamically allocated heap buffer.
  func mz_zip_reader_extract_to_heap*(pZip: ptr mz_zip_archive; 
                                      file_index: mz_uint; pSize: ptr csize_t; 
                                      flags: mz_uint): pointer {.importc.}
  func mz_zip_reader_extract_file_to_heap*(pZip: ptr mz_zip_archive; 
      pFilename: cstring; pSize: ptr csize_t; flags: mz_uint): pointer {.importc.}
  # Extracts a archive file using a callback function to output the file's data.
  func mz_zip_reader_extract_to_callback*(pZip: ptr mz_zip_archive; 
      file_index: mz_uint; pCallback: mz_file_write_func; pOpaque: pointer; 
      flags: mz_uint): mz_bool {.importc.}
  func mz_zip_reader_extract_file_to_callback*(pZip: ptr mz_zip_archive; 
      pFilename: cstring; pCallback: mz_file_write_func; pOpaque: pointer; 
      flags: mz_uint): mz_bool {.importc.}
  when not(defined(MINIZ_NO_STDIO)): 
    # Extracts a archive file to a disk file and sets its last accessed and modified times.
    # This function only extracts files, not archive directory records.
    proc mz_zip_reader_extract_to_file*(pZip: ptr mz_zip_archive; 
                                        file_index: mz_uint; 
                                        pDst_filename: cstring; flags: mz_uint): mz_bool {.importc, cdecl.}
    proc mz_zip_reader_extract_file_to_file*(pZip: ptr mz_zip_archive; 
        pArchive_filename: cstring; pDst_filename: cstring; flags: mz_uint): mz_bool {.importc.}
  # Ends archive reading, freeing all allocations, and closing the input archive file if mz_zip_reader_init_file() was used.
  func mz_zip_reader_end*(pZip: ptr mz_zip_archive): mz_bool {.importc, cdecl.}
  # ZIP archive writing
  when not(defined(MINIZ_NO_ARCHIVE_WRITING_APIS)): 
    # Inits a ZIP archive writer.
    proc mz_zip_writer_init*(pZip: ptr mz_zip_archive; existing_size: mz_uint64): mz_bool  {.importc.}
    proc mz_zip_writer_init_heap*(pZip: ptr mz_zip_archive; 
                                  size_to_reserve_at_beginning: csize_t; 
                                  initial_allocation_size: csize_t): mz_bool {.importc.}
    when not(defined(MINIZ_NO_STDIO)): 
      proc mz_zip_writer_init_file*(pZip: ptr mz_zip_archive; 
                                    pFilename: cstring; 
                                    size_to_reserve_at_beginning: mz_uint64): mz_bool {.importc, cdecl.}
    # Converts a ZIP archive reader object into a writer object, to allow efficient in-place file appends to occur on an existing archive.
    # For archives opened using mz_zip_reader_init_file, pFilename must be the archive's filename so it can be reopened for writing. If the file can't be reopened, mz_zip_reader_end() will be called.
    # For archives opened using mz_zip_reader_init_mem, the memory block must be growable using the realloc callback (which defaults to realloc unless you've overridden it).
    # Finally, for archives opened using mz_zip_reader_init, the mz_zip_archive's user provided m_pWrite function cannot be NULL.
    # Note: In-place archive modification is not recommended unless you know what you're doing, because if execution stops or something goes wrong before
    # the archive is finalized the file's central directory will be hosed.
    proc mz_zip_writer_init_from_reader*(pZip: ptr mz_zip_archive; 
        pFilename: cstring): mz_bool {.importc, cdecl.}
    # Adds the contents of a memory buffer to an archive. These functions record the current local time into the archive.
    # To add a directory entry, call this method with an archive name ending in a forwardslash with empty buffer.
    # level_and_flags - compression level (0-10, see MZ_BEST_SPEED, MZ_BEST_COMPRESSION, etc.) logically OR'd with zero or more mz_zip_flags, or just set to MZ_DEFAULT_COMPRESSION.
    proc mz_zip_writer_add_mem*(pZip: ptr mz_zip_archive; 
                                pArchive_name: cstring; pBuf: pointer; 
                                buf_size: csize_t; level_and_flags: mz_uint): mz_bool {.importc.}
    proc mz_zip_writer_add_mem_ex*(pZip: ptr mz_zip_archive; 
                                   pArchive_name: cstring; pBuf: pointer; 
                                   buf_size: csize_t; pComment: pointer; 
                                   comment_size: mz_uint16; 
                                   level_and_flags: mz_uint; 
                                   uncomp_size: mz_uint64; 
                                   uncomp_crc32: mz_uint32): mz_bool {.importc.}
    when not(defined(MINIZ_NO_STDIO)): 
      # Adds the contents of a disk file to an archive. This function also records the disk file's modified time into the archive.
      # level_and_flags - compression level (0-10, see MZ_BEST_SPEED, MZ_BEST_COMPRESSION, etc.) logically OR'd with zero or more mz_zip_flags, or just set to MZ_DEFAULT_COMPRESSION.
      proc mz_zip_writer_add_file*(pZip: ptr mz_zip_archive; 
                                   pArchive_name: cstring; 
                                   pSrc_filename: cstring; pComment: pointer; 
                                   comment_size: mz_uint16; 
                                   level_and_flags: mz_uint): mz_bool {.importc, cdecl.}
    # Adds a file to an archive by fully cloning the data from another archive.
    # This function fully clones the source file's compressed data (no recompression), along with its full filename, extra data, and comment fields.
    proc mz_zip_writer_add_from_zip_reader*(pZip: ptr mz_zip_archive; 
        pSource_zip: ptr mz_zip_archive; file_index: mz_uint): mz_bool {.importc.}
    # Finalizes the archive by writing the central directory records followed by the end of central directory record.
    # After an archive is finalized, the only valid call on the mz_zip_archive struct is mz_zip_writer_end().
    # An archive must be manually finalized by calling this function for it to be valid.
    proc mz_zip_writer_finalize_archive*(pZip: ptr mz_zip_archive): mz_bool {.importc, cdecl.}
    proc mz_zip_writer_finalize_heap_archive*(pZip: ptr mz_zip_archive; 
        pBuf: ptr pointer; pSize: ptr csize_t): mz_bool {.importc, cdecl.}
    # Ends archive writing, freeing all allocations, and closing the output file if mz_zip_writer_init_file() was used.
    # Note for the archive to be valid, it must have been finalized before ending.
    proc mz_zip_writer_end*(pZip: ptr mz_zip_archive): mz_bool {.importc, cdecl.}
    # Misc. high-level helper functions:
    # mz_zip_add_mem_to_archive_file_in_place() efficiently (but not atomically) appends a memory blob to a ZIP archive.
    # level_and_flags - compression level (0-10, see MZ_BEST_SPEED, MZ_BEST_COMPRESSION, etc.) logically OR'd with zero or more mz_zip_flags, or just set to MZ_DEFAULT_COMPRESSION.
    proc mz_zip_add_mem_to_archive_file_in_place*(pZip_filename: cstring; 
        pArchive_name: cstring; pBuf: pointer; buf_size: csize_t; 
        pComment: pointer; comment_size: mz_uint16; level_and_flags: mz_uint): mz_bool {.importc.}
    # Reads a single file from an archive into a heap block.
    # Returns NULL on failure.
    proc mz_zip_extract_archive_file_to_heap*(pZip_filename: cstring; 
        pArchive_name: cstring; pSize: ptr csize_t; zip_flags: mz_uint): pointer {.importc.}
# ------------------- Low-level Decompression API Definitions
# Decompression flags used by tinfl_decompress().
# TINFL_FLAG_PARSE_ZLIB_HEADER: If set, the input has a valid zlib header and ends with an adler32 checksum (it's a valid zlib stream). Otherwise, the input is a raw deflate stream.
# TINFL_FLAG_HAS_MORE_INPUT: If set, there are more input bytes available beyond the end of the supplied input buffer. If clear, the input buffer contains all remaining input.
# TINFL_FLAG_USING_NON_WRAPPING_OUTPUT_BUF: If set, the output buffer is large enough to hold the entire decompressed stream. If clear, the output buffer is at least the size of the dictionary (typically 32KB).
# TINFL_FLAG_COMPUTE_ADLER32: Force adler-32 checksum computation of the decompressed bytes.

const 
  TINFL_FLAG_PARSE_ZLIB_HEADER* = 1
  TINFL_FLAG_HAS_MORE_INPUT* = 2
  TINFL_FLAG_USING_NON_WRAPPING_OUTPUT_BUF* = 4
  TINFL_FLAG_COMPUTE_ADLER32* = 8

# High level decompression functions:
# tinfl_decompress_mem_to_heap() decompresses a block in memory to a heap block allocated via malloc().
# On entry:
#  pSrc_buf, src_buf_len: Pointer and size of the Deflate or zlib source data to decompress.
# On return:
#  Function returns a pointer to the decompressed data, or NULL on failure.
#  *pOut_len will be set to the decompressed data's size, which could be larger than src_buf_len on uncompressible data.
#  The caller must call mz_free() on the returned block when it's no longer needed.

func tinfl_decompress_mem_to_heap*(pSrc_buf: pointer; src_buf_len: csize_t; 
                                   pOut_len: ptr csize_t; flags: cint): pointer {.importc.}
# tinfl_decompress_mem_to_mem() decompresses a block in memory to another block in memory.
# Returns TINFL_DECOMPRESS_MEM_TO_MEM_FAILED on failure, or the number of bytes written on success.

const 
  TINFL_DECOMPRESS_MEM_TO_MEM_FAILED* = ((size_t)(- 1))

func tinfl_decompress_mem_to_mem*(pOut_buf: pointer; out_buf_len: csize_t; 
                                  pSrc_buf: pointer; src_buf_len: csize_t; 
                                  flags: cint): csize_t {.importc.}
# tinfl_decompress_mem_to_callback() decompresses a block in memory to an internal 32KB buffer, and a user provided callback function will be called to flush the buffer.
# Returns 1 on success or 0 on failure.

type 
  tinfl_put_buf_func_ptr* = proc (pBuf: pointer; len: cint; pUser: pointer): cint {.noconv.}

func tinfl_decompress_mem_to_callback*(pIn_buf: pointer; 
                                       pIn_buf_size: ptr csize_t; 
                                       pPut_buf_func: tinfl_put_buf_func_ptr; 
                                       pPut_buf_user: pointer; flags: cint): cint {.importc.}
type 
  tinfl_decompressor_tag* = object 
  
  tinfl_decompressor* = tinfl_decompressor_tag

# Max size of LZ dictionary.

const 
  TINFL_LZ_DICT_SIZE* = 32768

# Return status.

type 
  tinfl_status* {.size: sizeof(cint).} = enum 
    TINFL_STATUS_BAD_PARAM = - 3, TINFL_STATUS_ADLER32_MISMATCH = - 2, 
    TINFL_STATUS_FAILED = - 1, TINFL_STATUS_DONE = 0, 
    TINFL_STATUS_NEEDS_MORE_INPUT = 1, TINFL_STATUS_HAS_MORE_OUTPUT = 2


# Initializes the decompressor to its initial state.
##define tinfl_init(r) do { (r)->m_state = 0; } MZ_MACRO_END
template tinfl_init*(r: typed): void=
  r.m_state = 0

template tinfl_get_adler32*(r: typed): void= 
  (r).m_check_adler32

# Main low-level decompressor coroutine function. This is the only function actually needed for decompression. All the other functions are just high-level helpers for improved usability.
# This is a universal API, i.e. it can be used as a building block to build any desired higher level decompression API. In the limit case, it can be called once per every byte input or output.

func tinfl_decompress*(r: ptr tinfl_decompressor; pIn_buf_next: ptr mz_uint8; 
                       pIn_buf_size: ptr csize_t; pOut_buf_start: ptr mz_uint8; 
                       pOut_buf_next: ptr mz_uint8; pOut_buf_size: ptr csize_t; 
                       decomp_flags: mz_uint32): tinfl_status {.importc.}
# Internal/private bits follow.

const 
  TINFL_MAX_HUFF_TABLES* = 3
  TINFL_MAX_HUFF_SYMBOLS_0* = 288
  TINFL_MAX_HUFF_SYMBOLS_1* = 32
  TINFL_MAX_HUFF_SYMBOLS_2* = 19
  TINFL_FAST_LOOKUP_BITS* = 10
  TINFL_FAST_LOOKUP_SIZE* = 1 shl TINFL_FAST_LOOKUP_BITS

type 
  tinfl_huff_table* = object 
    m_code_size*: array[TINFL_MAX_HUFF_SYMBOLS_0, mz_uint8]
    m_look_up*: array[TINFL_FAST_LOOKUP_SIZE, mz_int16]
    m_tree*: array[TINFL_MAX_HUFF_SYMBOLS_0 * 2, mz_int16]


when defined(MINIZ_HAS_64BIT_REGISTERS): 
  const 
    TINFL_USE_64BIT_BITBUF* = 1
when defined(TINFL_USE_64BIT_BITBUF): 
  type 
    tinfl_bit_buf_t* = mz_uint64
  const 
    TINFL_BITBUF_SIZE* = (64)
else: 
  type 
    tinfl_bit_buf_t* = mz_uint32
  const 
    TINFL_BITBUF_SIZE* = (32)
type 
  tinfl_decompressor_tag_obj* = object 
    m_state*: mz_uint32
    m_num_bits*: mz_uint32
    m_zhdr0*: mz_uint32
    m_zhdr1*: mz_uint32
    m_z_adler32*: mz_uint32
    m_final*: mz_uint32
    m_type*: mz_uint32
    m_check_adler32*: mz_uint32
    m_dist*: mz_uint32
    m_counter*: mz_uint32
    m_num_extra*: mz_uint32
    m_table_sizes*: array[TINFL_MAX_HUFF_TABLES, mz_uint32]
    m_bit_buf*: tinfl_bit_buf_t
    m_dist_from_out_buf_start*: csize_t
    m_tables*: array[TINFL_MAX_HUFF_TABLES, tinfl_huff_table]
    m_raw_header*: array[4, mz_uint8]
    m_len_codes*: array[TINFL_MAX_HUFF_SYMBOLS_0 + TINFL_MAX_HUFF_SYMBOLS_1 +
        137, mz_uint8]


# ------------------- Low-level Compression API Definitions
# Set TDEFL_LESS_MEMORY to 1 to use less memory (compression will be slightly slower, and raw/dynamic blocks will be output more frequently).

const 
  TDEFL_LESS_MEMORY* = 0

# tdefl_init() compression flags logically OR'd together (low 12 bits contain the max. number of probes per dictionary search):
# TDEFL_DEFAULT_MAX_PROBES: The compressor defaults to 128 dictionary probes per dictionary search. 0=Huffman only, 1=Huffman+LZ (fastest/crap compression), 4095=Huffman+LZ (slowest/best compression).

const 
  TDEFL_HUFFMAN_ONLY* = 0
  TDEFL_DEFAULT_MAX_PROBES* = 128
  TDEFL_MAX_PROBES_MASK* = 0x00000FFF

# TDEFL_WRITE_ZLIB_HEADER: If set, the compressor outputs a zlib header before the deflate data, and the Adler-32 of the source data at the end. Otherwise, you'll get raw deflate data.
# TDEFL_COMPUTE_ADLER32: Always compute the adler-32 of the input data (even when not writing zlib headers).
# TDEFL_GREEDY_PARSING_FLAG: Set to use faster greedy parsing, instead of more efficient lazy parsing.
# TDEFL_NONDETERMINISTIC_PARSING_FLAG: Enable to decrease the compressor's initialization time to the minimum, but the output may vary from run to run given the same input (depending on the contents of memory).
# TDEFL_RLE_MATCHES: Only look for RLE matches (matches with a distance of 1)
# TDEFL_FILTER_MATCHES: Discards matches <= 5 chars if enabled.
# TDEFL_FORCE_ALL_STATIC_BLOCKS: Disable usage of optimized Huffman tables.
# TDEFL_FORCE_ALL_RAW_BLOCKS: Only use raw (uncompressed) deflate blocks.
# The low 12 bits are reserved to control the max # of hash probes per dictionary lookup (see TDEFL_MAX_PROBES_MASK).

const 
  TDEFL_WRITE_ZLIB_HEADER* = 0x00001000
  TDEFL_COMPUTE_ADLER32* = 0x00002000
  TDEFL_GREEDY_PARSING_FLAG* = 0x00004000
  TDEFL_NONDETERMINISTIC_PARSING_FLAG* = 0x00008000
  TDEFL_RLE_MATCHES* = 0x00010000
  TDEFL_FILTER_MATCHES* = 0x00020000
  TDEFL_FORCE_ALL_STATIC_BLOCKS* = 0x00040000
  TDEFL_FORCE_ALL_RAW_BLOCKS* = 0x00080000

# High level compression functions:
# tdefl_compress_mem_to_heap() compresses a block in memory to a heap block allocated via malloc().
# On entry:
#  pSrc_buf, src_buf_len: Pointer and size of source block to compress.
#  flags: The max match finder probes (default is 128) logically OR'd against the above flags. Higher probes are slower but improve compression.
# On return:
#  Function returns a pointer to the compressed data, or NULL on failure.
#  *pOut_len will be set to the compressed data's size, which could be larger than src_buf_len on uncompressible data.
#  The caller must free() the returned block when it's no longer needed.

func tdefl_compress_mem_to_heap*(pSrc_buf: pointer; src_buf_len: csize_t; 
                                 pOut_len: ptr csize_t; flags: cint): pointer {.importc.}
# tdefl_compress_mem_to_mem() compresses a block in memory to another block in memory.
# Returns 0 on failure.

func tdefl_compress_mem_to_mem*(pOut_buf: pointer; out_buf_len: csize_t; 
                                pSrc_buf: pointer; src_buf_len: csize_t; 
                                flags: cint): csize_t {.importc.}
# Compresses an image to a compressed PNG file in memory.
# On entry:
#  pImage, w, h, and num_chans describe the image to compress. num_chans may be 1, 2, 3, or 4. 
#  The image pitch in bytes per scanline will be w*num_chans. The leftmost pixel on the top scanline is stored first in memory.
#  level may range from [0,10], use MZ_NO_COMPRESSION, MZ_BEST_SPEED, MZ_BEST_COMPRESSION, etc. or a decent default is MZ_DEFAULT_LEVEL
#  If flip is true, the image will be flipped on the Y axis (useful for OpenGL apps).
# On return:
#  Function returns a pointer to the compressed data, or NULL on failure.
#  *pLen_out will be set to the size of the PNG image file.
#  The caller must mz_free() the returned heap block (which will typically be larger than *pLen_out) when it's no longer needed.

func tdefl_write_image_to_png_file_in_memory_ex*(pImage: pointer; w: cint; 
    h: cint; num_chans: cint; pLen_out: ptr csize_t; level: mz_uint; flip: mz_bool): pointer {.importc.}
func tdefl_write_image_to_png_file_in_memory*(pImage: pointer; w: cint; h: cint; 
    num_chans: cint; pLen_out: ptr csize_t): pointer {.importc.}
# Output stream interface. The compressor uses this interface to write compressed data. It'll typically be called TDEFL_OUT_BUF_SIZE at a time.

type 
  tdefl_put_buf_func_ptr* = proc (pBuf: pointer; len: cint; pUser: pointer): mz_bool {.noconv.}

# tdefl_compress_mem_to_output() compresses a block to an output stream. The above helpers use this function internally.

func tdefl_compress_mem_to_output*(pBuf: pointer; buf_len: csize_t; 
                                   pPut_buf_func: tdefl_put_buf_func_ptr; 
                                   pPut_buf_user: pointer; flags: cint): mz_bool {.importc.}
const 
  TDEFL_MAX_HUFF_TABLES* = 3
  TDEFL_MAX_HUFF_SYMBOLS_0* = 288
  TDEFL_MAX_HUFF_SYMBOLS_1* = 32
  TDEFL_MAX_HUFF_SYMBOLS_2* = 19
  TDEFL_LZ_DICT_SIZE* = 32768
  TDEFL_LZ_DICT_SIZE_MASK* = TDEFL_LZ_DICT_SIZE - 1
  TDEFL_MIN_MATCH_LEN* = 3
  TDEFL_MAX_MATCH_LEN* = 258

# TDEFL_OUT_BUF_SIZE MUST be large enough to hold a single entire compressed output block (using static/fixed Huffman codes).

when TDEFL_LESS_MEMORY > 0: 
  const 
    TDEFL_LZ_CODE_BUF_SIZE* = 24 * 1024
    TDEFL_OUT_BUF_SIZE* = (TDEFL_LZ_CODE_BUF_SIZE * 13) div 10
    TDEFL_MAX_HUFF_SYMBOLS* = 288
    TDEFL_LZ_HASH_BITS* = 12
    TDEFL_LEVEL1_HASH_SIZE_MASK* = 4095
    TDEFL_LZ_HASH_SHIFT* = (TDEFL_LZ_HASH_BITS + 2) div 3
    TDEFL_LZ_HASH_SIZE* = 1 shl TDEFL_LZ_HASH_BITS
else: 
  const 
    TDEFL_LZ_CODE_BUF_SIZE* = 64 * 1024
    TDEFL_OUT_BUF_SIZE* = (TDEFL_LZ_CODE_BUF_SIZE * 13) div 10
    TDEFL_MAX_HUFF_SYMBOLS* = 288
    TDEFL_LZ_HASH_BITS* = 15
    TDEFL_LEVEL1_HASH_SIZE_MASK* = 4095
    TDEFL_LZ_HASH_SHIFT* = (TDEFL_LZ_HASH_BITS + 2) div 3
    TDEFL_LZ_HASH_SIZE* = 1 shl TDEFL_LZ_HASH_BITS
# The low-level tdefl functions below may be used directly if the above helper functions aren't flexible enough. The low-level functions don't make any heap allocations, unlike the above helper functions.

type 
  tdefl_status* {.size: sizeof(cint).} = enum 
    TDEFL_STATUS_BAD_PARAM = - 2, TDEFL_STATUS_PUT_BUF_FAILED = - 1, 
    TDEFL_STATUS_OKAY = 0, TDEFL_STATUS_DONE = 1


# Must map to MZ_NO_FLUSH, MZ_SYNC_FLUSH, etc. enums

type 
  tdefl_flush* {.size: sizeof(cint).} = enum 
    TDEFL_NO_FLUSH = 0, TDEFL_SYNC_FLUSH = 2, TDEFL_FULL_FLUSH = 3, 
    TDEFL_FINISH = 4


# tdefl's compression state structure.

type 
  tdefl_compressor* = object 
    m_pPut_buf_func*: tdefl_put_buf_func_ptr
    m_pPut_buf_user*: pointer
    m_flags*: mz_uint
    m_max_probes*: array[2, mz_uint]
    m_greedy_parsing*: cint
    m_adler32*: mz_uint
    m_lookahead_pos*: mz_uint
    m_lookahead_size*: mz_uint
    m_dict_size*: mz_uint
    m_pLZ_code_buf*: ptr mz_uint8
    m_pLZ_flags*: ptr mz_uint8
    m_pOutput_buf*: ptr mz_uint8
    m_pOutput_buf_end*: ptr mz_uint8
    m_num_flags_left*: mz_uint
    m_total_lz_bytes*: mz_uint
    m_lz_code_buf_dict_pos*: mz_uint
    m_bits_in*: mz_uint
    m_bit_buffer*: mz_uint
    m_saved_match_dist*: mz_uint
    m_saved_match_len*: mz_uint
    m_saved_lit*: mz_uint
    m_output_flush_ofs*: mz_uint
    m_output_flush_remaining*: mz_uint
    m_finished*: mz_uint
    m_block_index*: mz_uint
    m_wants_to_finish*: mz_uint
    m_prev_return_status*: tdefl_status
    m_pIn_buf*: pointer
    m_pOut_buf*: pointer
    m_pIn_buf_size*: ptr csize_t
    m_pOut_buf_size*: ptr csize_t
    m_flush*: tdefl_flush
    m_pSrc*: ptr mz_uint8
    m_src_buf_left*: csize_t
    m_out_buf_ofs*: csize_t
    m_dict*: array[TDEFL_LZ_DICT_SIZE + TDEFL_MAX_MATCH_LEN - 1, mz_uint8]
    m_huff_count*: array[TDEFL_MAX_HUFF_SYMBOLS, 
                         array[TDEFL_MAX_HUFF_TABLES, mz_uint16]]
    m_huff_codes*: array[TDEFL_MAX_HUFF_SYMBOLS, 
                         array[TDEFL_MAX_HUFF_TABLES, mz_uint16]]
    m_huff_code_sizes*: array[TDEFL_MAX_HUFF_SYMBOLS, 
                              array[TDEFL_MAX_HUFF_TABLES, mz_uint8]]
    m_lz_code_buf*: array[TDEFL_LZ_CODE_BUF_SIZE, mz_uint8]
    m_next*: array[TDEFL_LZ_DICT_SIZE, mz_uint16]
    m_hash*: array[TDEFL_LZ_HASH_SIZE, mz_uint16]
    m_output_buf*: array[TDEFL_OUT_BUF_SIZE, mz_uint8]


# Initializes the compressor.
# There is no corresponding deinit() function because the tdefl API's do not dynamically allocate memory.
# pBut_buf_func: If NULL, output data will be supplied to the specified callback. In this case, the user should call the tdefl_compress_buffer() API for compression.
# If pBut_buf_func is NULL the user should always call the tdefl_compress() API.
# flags: See the above enums (TDEFL_HUFFMAN_ONLY, TDEFL_WRITE_ZLIB_HEADER, etc.)

func tdefl_init*(d: ptr tdefl_compressor; pPut_buf_func: tdefl_put_buf_func_ptr; 
                 pPut_buf_user: pointer; flags: cint): tdefl_status {.importc.}
# Compresses a block of data, consuming as much of the specified input buffer as possible, and writing as much compressed data to the specified output buffer as possible.

func tdefl_compress*(d: ptr tdefl_compressor; pIn_buf: pointer; 
                     pIn_buf_size: ptr csize_t; pOut_buf: pointer; 
                     pOut_buf_size: ptr csize_t; flush: tdefl_flush): tdefl_status {.importc.}
# tdefl_compress_buffer() is only usable when the tdefl_init() is called with a non-NULL tdefl_put_buf_func_ptr.
# tdefl_compress_buffer() always consumes the entire input buffer.

func tdefl_compress_buffer*(d: ptr tdefl_compressor; pIn_buf: pointer; 
                            in_buf_size: csize_t; flush: tdefl_flush): tdefl_status {.importc.}
func tdefl_get_prev_return_status*(d: ptr tdefl_compressor): tdefl_status {.importc.}
func tdefl_get_adler32*(d: ptr tdefl_compressor): mz_uint32 {.importc.}
# Can't use tdefl_create_comp_flags_from_zip_params if MINIZ_NO_ZLIB_APIS isn't defined, because it uses some of its macros.

when not(defined(MINIZ_NO_ZLIB_APIS)): 
  # Create tdefl_compress() flags given zlib-style compression parameters.
  # level may range from [0,10] (where 10 is absolute max compression, but may be much slower on some files)
  # window_bits may be -15 (raw deflate) or 15 (zlib)
  # strategy may be either MZ_DEFAULT_STRATEGY, MZ_FILTERED, MZ_HUFFMAN_ONLY, MZ_RLE, or MZ_FIXED
  func tdefl_create_comp_flags_from_zip_params*(level: cint; window_bits: cint; 
      strategy: cint): mz_uint {.importc.}

### Public Library

import
  os

proc zip*(files: seq[string], filepath: string) =
  var pZip: ptr mz_zip_archive = cast[ptr mz_zip_archive](alloc0(sizeof(mz_zip_archive)))
  discard pZip.mz_zip_writer_init_file(filepath.cstring, 0)
  var comment: pointer
  for f in files:
    discard pZip.mz_zip_writer_add_file(f.extractFileName.cstring, f.extractFileName.cstring, comment, 0, cast[mz_uint](MZ_DEFAULT_COMPRESSION))
  discard pZip.mz_zip_writer_finalize_archive()
  discard pZip.mz_zip_writer_end()
  dealloc(pZip)

proc unzip*(src, dst: string) =
  var pZip: ptr mz_zip_archive = cast[ptr mz_zip_archive](alloc0(sizeof(mz_zip_archive)))
  discard pZip.mz_zip_reader_init_file(src.cstring, 0)
  let total = pZip.mz_zip_reader_get_num_files()
  if total == 0:
    return
  for i in 0..total-1:
    let isDir = pZip.mz_zip_reader_is_file_a_directory(i)
    if isDir == 0:
      # Extract file
      let size = pZip.mz_zip_reader_get_filename(i, nil, 0)
      var filename: cstring = cast[cstring](alloc(size))
      discard pZip.mz_zip_reader_get_filename(i, filename, size)
      let dest = dst / $filename
      dest.parentDir.createDir()
      dest.writeFile("")
      discard pZip.mz_zip_reader_extract_to_file(i, (cstring)dest, 0)
  discard pZip.mz_zip_reader_end()
  dealloc(pZip)

type Zip* = object
  c : mz_zip_archive
  mode: FileMode

template check_mode(zip: Zip, mode: mz_zip_mode, operation: string) =
  if zip.c.addr.m_zip_mode != mode:
    raise newException(IOError, "must be opened in another mode to " & operation)

func len*(zip: var Zip): int =
  return zip.c.addr.mz_zip_reader_get_num_files().int

proc open*(zip: var Zip, path: string, mode:FileMode=fmRead): bool {.discardable.} =
  zip.mode = mode
  if mode == fmWrite:
    return zip.c.addr.mz_zip_writer_init_file(path.cstring, 0) == 1
  elif mode == fmRead:
    return zip.c.addr.mz_zip_reader_init_file(path.cstring, 0) == 1
  else:
    quit "unsupported mode for zip"

proc add_file*(zip: var Zip, path: string, archivePath:string="") =
  check_mode(zip, MZ_ZIP_MODE_WRITING, "add_file")
  var comment:pointer
  if not fileExists(path):
    raise newException(ValueError, "no file found at:" & path)
  var arcPath = path.cstring
  if archivePath != "":
    arcPath = archivePath.cstring
  doAssert zip.c.addr.mz_zip_writer_add_file(archivePath, path.cstring, comment, 0, cast[mz_uint](3'u16 or MZ_ZIP_FLAG_CASE_SENSITIVE.uint16)) == MZ_TRUE

proc close*(zip: var Zip) =
  if zip.mode == fmWrite:
    doAssert zip.c.addr.mz_zip_writer_finalize_archive() == MZ_TRUE
    doAssert zip.c.addr.mz_zip_writer_end() == MZ_TRUE
  elif zip.mode == fmRead:
    doAssert zip.c.addr.mz_zip_reader_end() == MZ_TRUE

proc get_file_name(zip: var Zip, i:int): string {.inline.} =
  var size = zip.c.addr.mz_zip_reader_get_filename(i.mz_uint, (cstring)result, 0)
  result.setLen(size.int)
  doAssert zip.c.addr.mz_zip_reader_get_filename(i.mz_uint, (cstring)result, size) > 0.mz_uint
  # drop trailing byte.
  result = result[0..<result.high]

iterator pairs*(zip: var Zip): (int, string) =
  ## yield each path to each file in the archive
  for i in 0..<zip.len:
    if zip.c.addr.mz_zip_reader_is_file_a_directory(i.mz_uint) == MZ_TRUE: continue
    yield (i, zip.get_file_name(i))

func file_index_inexact(zip: var Zip, path: string): int = 
  # returns file index per file path. Tries inexact search if exact search fails.
  # Throws exception if path is ambigous
  result = zip.c.addr.mz_zip_reader_locate_file(path, "", 0)
  if result == -1:
    for i, f in zip:
      if f.endsWith(path):
        if result != -1:
          # if here, we've already found one result that matches. so we have an error.
          raise newException(KeyError, path & "is ambiguous in zip archive")
        result = i
    if result == -1:
      raise newException(KeyError, path & " not found in zip archive")

proc extract_file*(zip: var Zip, path: string, destDir:string=""): string =
  ## extract a single file at the given path from the zip archive and return the path to which it
  ## was extracted.
  let i = file_index_inexact(zip, path)
  result = get_file_name(zip, i)
  if destDir != "":
    result = destDir / zip.get_file_name(i)
  result.parentDir.createDir()
  doAssert zip.c.addr.mz_zip_reader_extract_to_file(i.mz_uint, (cstring)result, 0) == MZ_TRUE

func extract_file_to_string*(zip: var Zip, path: string): string =
  ## extract a single file at the given path from the zip archive and returns its content as string
  let myreader = proc(res: ptr string, file_ofs: mz_uint64, pBuf: pointer; n: csize_t): csize_t {.noconv.} =
    let oldLen = res[].len
    res[].setLen(oldLen + n.int)
    for i in 0..<n.int:
      res[i + oldLen] = (cast[ptr UncheckedArray[char]](pBuf))[i]
    n

  let i = file_index_inexact(zip, path)
  var fileStat: mz_zip_archive_file_stat
  doAssert(mz_zip_reader_file_stat(zip.c.addr, i.mz_uint, fileStat.addr) == MZ_TRUE)
  result = newStringOfCap(fileStat.m_uncomp_size.int)
  doAssert mz_zip_reader_extract_to_callback(zip.c.addr, i.mz_uint, cast[mz_file_write_func](myreader), result.addr, 0) == MZ_TRUE
