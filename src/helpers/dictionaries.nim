#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: helpers/dictionaries.nim
#=======================================================

#=======================================
# Libraries
#=======================================

import tables, algorithm, sugar

import vm/values/value
import helpers/unisort

#=======================================
# Methods
#=======================================

proc flattenedDictionary*(vd: ValueDict): ValueArray =
    for k,v in vd.pairs:
        result.add(newString(k))
        result.add(v)
        
proc getValuesinDeep*(dict: ValueDict): ValueArray =
    for key, value in dict.pairs:
        if value.kind == Dictionary:
            result.add getValuesinDeep(value.d)
        else:
            result.add value


# `collections\sort` related functions for dictionaries

proc all(s: ValueDict, pred: (Value) -> bool): bool =
  ## Iterates through a ValueDict and checks if every value fulfills the
  ## predicate.
  for i in values(s):
    if not pred(i):
      return false
  true

type SortParams = tuple
    descending: bool
    sensitive:  bool
    ascii:      bool
    language:   string
    key:        string

proc sortDictionary*(
    dictionary: ValueDict, 
    params: SortParams,
    byValue: bool = false
    ): ValueDict =
    
    let order: SortOrder =
        if params.descending: SortOrder.Descending
        else:  SortOrder.Ascending
        
    if dictionary.all((x) => x.kind == String):
        return dictionary.unisorted(
            lang = params.language,
            order = order,
            byValue = byValue,
            ascii = params.ascii,
        )
    else:
        result = newOrderedTable[string, Value]()
        for key, value in dictionary.pairs:
            result[key] = value
            
        if byValue:
            result.sort((x, y) => cmp(x[1], y[1]), order = order)
        else:
            result.sort((x, y) => cmp(x[0], y[0]), order = order)
        

proc sortDictionary*(
    dictionary: var ValueDict, 
    params: SortParams,
    byValue: bool
    ) =
    
    let order: SortOrder =
        if params.descending: SortOrder.Descending
        else:  SortOrder.Ascending
        
    if dictionary.all((x) => x.kind == String):
        dictionary.unisort(
            lang = params.language,
            order = order,
            byValue = byValue,
            ascii = params.ascii,
        )
    else:           
        if byValue:
            dictionary.sort((x, y) => cmp(x[1], y[1]), order = order)
        else:
            dictionary.sort((x, y) => cmp(x[0], y[0]), order = order)