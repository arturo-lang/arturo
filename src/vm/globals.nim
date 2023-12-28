#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: vm/globals.nim
#=======================================================

## VM globals & helpers.

#=======================================
# Libraries
#=======================================

import sequtils, tables, unicode

import helpers/strings


import vm/[errors, values/value]

#=======================================
# Globals
#=======================================

# TODO(VM/globals) Is there any way to actually avoid them altogether?
#  Having all these global variables is practical, but it actually causes problems when we end up wanting to work with multiple threads. An idea would be to add them as fields in a VM object, and pass this object around. But it would still need to be properly benchmark as it would - undoubtedly - add some serious overhead.
#  labels: vm, enhancement, benchmark, open discussion

var
    # symbols
    Syms* {.global.}        : SymTable          ## The symbol table: all the variables 
                                                ## with their associated values

    # symbol aliases
    Aliases* {.global.}     : SymbolDict        ## The symbol aliases: all the symbols
                                                ## with all their associated variables
                                                ## they point to

    # libraries 
    Libraries* {.global.}   : seq[BuiltinAction]    ## The list of all builtin libraries
                                                    ## to be imported at startup
    
    # dictionary symbols stack
    DictSyms* {.global.}    : seq[ValueDict]        ## The stack of dictionaries to be filled
                                                    ## when using `execDictionary`
    
    # active stores
    Stores* {.global.}      : seq[VStore]           ## The list of active stores to be stored
                                                    ## before app termination

    # global configuration
    Config* {.global.}      : Value                 ## The global configuration store

#=======================================
# Helpers
#=======================================

type FunctionFlag[T: static bool] = bool

template `:=`(a, b: untyped): untyped {.dirty.} =
    let a = b
    a

func suggestAlternative(s: string, reference: SymTable | ValueDict = Syms): seq[string] {.inline.} =
    var levs = initOrderedTable[string,float]()

    for k,v in pairs(reference):
        levs[k] = 1 - jaro(s,k)

    proc cmper (x, y: (string, float)): int {.closure.} = 
        let pts = cmp(x[1], y[1])
        if pts == 0: return cmp(x[0], y[0])
        else: return pts

    levs.sort(cmper)

    if levs.len > 3: result = toSeq(levs.keys)[0..2]
    else: result = toSeq(levs.keys)

#=======================================
# Methods
#=======================================

#---------------------
# Safe access
#---------------------

template GetKey*(dict: ValueDict, key: string, withError: static bool = true): untyped =
    ## Checks if a symbol name exists in given dictionary
    ## - if it doesn't, raise a SymbolNotFound error
    ## - otherwise, return its value
    let toRet = dict.getOrDefault(key, nil)
    when withError:
        if unlikely(toRet.isNil):
            RuntimeError_KeyNotFound(key, suggestAlternative(key, reference=dict))
    toRet

template GetArrayIndex*(arr: ValueArray, indx: int): untyped =
    ## Get element by index in given ValueArray
    ## with bounds checking
    if unlikely(indx < 0 or indx > (arr.len)-1):
        RuntimeError_OutOfBounds(indx, arr.len-1)
    arr[indx]

template SetArrayIndex*(arr: ValueArray, indx: int, v: Value): untyped =
    ## Set element at index in given ValueArray
    ## with bounds checking
    if unlikely(indx < 0 or indx > (arr.len)-1):
        RuntimeError_OutOfBounds(indx, arr.len-1)
    arr[indx] = v

#---------------------
# Symbol table
#---------------------

template SymExists*(s: string): untyped =
    ## Checks if a symbol name exists in the symbol table
    Syms.hasKey(s)

proc FetchSym*(s: string): Value {.inline.} =
    ## Fetches a symbol in the symbol table
    if unlikely (result := Syms.getOrDefault(s, nil)).isNil:
        RuntimeError_SymbolNotFound(s, suggestAlternative(s))

proc FetchSym*(s: string, unsafe: FunctionFlag[true]): Value {.inline.} =
    ## Checks if a symbol name exists in the symbol table
    ## - if it doesn't, raise a SymbolNotFound error
    ## - otherwise, return its value
    Syms[s]

proc FetchPathSym*(pl: ValueArray): Value =
    ## Gets a the `.p` field of a PathLiteral value
    ## looks up all subsequent path fields
    ## and returns the value
    result = FetchSym(pl[0].s)
    var pidx = 1
    while pidx < pl.len:
        var p = pl[pidx]
        let pKind = p.kind
        
        case result.kind:
            of Block:
                result = GetArrayIndex(result.a, p.i)
            of Dictionary:
                case pKind:
                    of String, Word, Literal, Label:
                        result = GetKey(result.d, p.s)
                    else:
                        result = GetKey(result.d, $(p.i))
            of Object:
                case pKind:
                    of String, Word, Literal, Label:
                        result = GetKey(result.o, p.s)
                    else:
                        result = GetKey(result.o, $(p.i))
            of String:
                result = newChar(result.s.runeAtPos(p.i))
            else: 
                discard

        pidx = pidx + 1

template GetSym*(s: string): untyped =
    ## Get value for given symbol in table
    ## 
    ## **Hint:** if the key doesn't exist, it will throw an error;
    ## so, we have to make sure we know it exists beforehand
    Syms[s]

template SetSym*(s: string, v: Value): untyped =
    ## Sets symbol to given value in the symbol table
    Syms[s] = v

template SetSym*(s: string, v: Value, safe: FunctionFlag[true]): untyped =
    ## Sets symbol to given value in the symbol table
    ## 
    ## Also check if the value to be assigned is a read-only value
    ## - if it is - we have to copy it first
    ## - otherwise, go ahead and just assign it (pointer copy!)
    if v.readonly:
        Syms[s] = copyValue(v)
    else:
        Syms[s] = v
        
template SetSym*(s: string, v: Value, safe, forceReadOnly: FunctionFlag[true]): untyped =
    ## Sets symbol to given value in the symbol table
    ## 
    ## When doing it safely forcing a read-only value.
    ## going ahead and just assign it (pointer copy!)
    Syms[s] = copyValue(v)

template SetDictSym*(s: string, v: Value): untyped =
    ## Sets symbol to topmost Dictionary symbol table
    DictSyms[^1][s] = v

template SetDictSym*(s: string, v: Value, safe: FunctionFlag[true]): untyped =
    ## Sets symbol to topmost Dictionary symbol table
    ## 
    ## When doing it safely, also check if the value to be assigned is a read-only value
    ## - if it is - we have to copy it first
    ## - otherwise, go ahead and just assign it (pointer copy!)
    if v.readonly:
        DictSyms[^1][s] = copyValue(v)
    else:
        DictSyms[^1][s] = v

#---------------------
# In-Place symbols
#---------------------

template RawInPlaced*(): untyped =
    ## Get InPlaced symbol without any checks
    ## 
    ## **Hint:** if the key doesn't exist, it will throw an error;
    ## so, we have to make sure we know it exists beforehand
    Syms[x.s]

template InPlaced*(): untyped =
    ## Get access to InPlaced symbol
    ## 
    ## **Hint:** always after having called `ensureInPlace` first!
    InPlaceAddr[]

proc showInPlaceError*(varname: string) =
    ## Show error in case `ensureInPlace` fails
    if SymExists(varname):
        RuntimeError_CannotModifyConstant(varname)
    else:
        RuntimeError_SymbolNotFound(varname, suggestAlternative(varname))

template ensureInPlace*(): untyped = 
    ## To be used whenever, and always before, 
    ## we want to access an InPlace symbol
    var InPlaceAddr {.inject.}: ptr Value
    try:
        InPlaceAddr = addr Syms[x.s]
        if unlikely(InPlaced.readonly):
            RuntimeError_CannotModifyConstant(x.s)
    except CatchableError:
        showInPlaceError(x.s)

template SetInPlace*(v: Value, safe: static bool = false): untyped =
    ## Sets InPlace symbol to given value in the symbol table
    SetSym(x.s, v, safe)

#---------------------
# Global config
#---------------------

template retrieveConfig*(globalKey: string, attrKey: string): untyped =
    var config {.inject.}: ValueDict
    var configFound = false

    if not (globalConfig := Config.sto.getStoreKey(globalKey, unsafe=true)).isNil:
        configFound = true
        config = globalConfig.d
    
    if (attrConfig := getAttr(attrKey)) != VNULL:
        configFound = true
        config = attrConfig.d

    if not configFound:
        RuntimeError_ConfigNotFound(globalKey, attrKey)
