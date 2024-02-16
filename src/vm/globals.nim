#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
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

    # dump values (from anywhere!)
    Dumper* {.global.}      : proc (v:Value):string

#=======================================
# Helpers
#=======================================

func suggestAlternative(s: string, reference: SymTable | ValueDict = Syms): seq[string] {.inline.} =
    return s.getSimilar(toSeq(reference.keys()))

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
            Error_KeyNotFound(key, Dumper(newDictionary(dict)), suggestAlternative(key, reference=dict))
    toRet

template GetDictionaryKey*(dict: Value, key: string, withError: static bool = true): untyped =
    ## Checks if a symbol name exists in given dictionary
    ## - if it doesn't, raise a SymbolNotFound error
    ## - otherwise, return its value
    let toRet = dict.d.getOrDefault(key, nil)
    when withError:
        if unlikely(toRet.isNil):
            Error_KeyNotFound(key, Dumper(dict), suggestAlternative(key, reference=dict.d))
    toRet

template GetObjectKey*(obj: Value, key: string, withError: static bool = true): untyped =
    ## Checks if a symbol name exists in given dictionary
    ## - if it doesn't, raise a SymbolNotFound error
    ## - otherwise, return its value
    let toRet = obj.o.getOrDefault(key, nil)
    when withError:
        if unlikely(toRet.isNil):
            Error_KeyNotFound(key, Dumper(obj), suggestAlternative(key, reference=obj.o))
    toRet

template GetArrayIndex*(arr: Value, indx: int): untyped =
    ## Get element by index in given ValueArray
    ## with bounds checking
    if unlikely(indx < 0 or indx > (arr.a.len)-1):
        Error_OutOfBounds(indx, Dumper(arr), arr.a.len-1)
    arr.a[indx]

template SetArrayIndex*(arr: Value, indx: int, v: Value): untyped =
    ## Set element at index in given ValueArray
    ## with bounds checking
    if unlikely(indx < 0 or indx > (arr.a.len)-1):
        Error_OutOfBounds(indx, Dumper(arr), arr.a.len-1)
    arr.a[indx] = v

#---------------------
# Symbol table
#---------------------

template SymExists*(s: string): untyped =
    ## Checks if a symbol name exists in the symbol table
    Syms.hasKey(s)

proc FetchSym*(s: string, unsafe: static bool = false): Value {.inline.} =
    ## Checks if a symbol name exists in the symbol table
    ## - if it doesn't, raise a SymbolNotFound error
    ## - otherwise, return its value
    when not unsafe:
        if (result = Syms.getOrDefault(s, nil); unlikely(result.isNil)):
            Error_SymbolNotFound(s, suggestAlternative(s))
    else:
        Syms[s]

proc CheckCallablePath*(pl: ValueArray): Value =
    result = Syms.getOrDefault(pl[0].s)
    if result.isNil: return

    var pidx = 1

    while pidx < pl.len:
        var p = pl[pidx]
        if p.kind == Block:
            # it contains\[variable]\parts
            return nil
        
        case result.kind:
            of Block:       
                if p.kind != Integer: return nil
                if unlikely(p.i < 0 or p.i > (result.a.len)-1):
                    return nil
                result = result.a[p.i]
            of Dictionary:  
                if p.kind notin {String,Literal,Word}: return nil
                result = result.d.getOrDefault(p.s, nil)
            of Object:      
                if p.kind notin {String,Literal,Word}: return nil
                result = result.o.getOrDefault(p.s, nil)
            else: 
                return nil

        if result.isNil:
            return

        pidx = pidx + 1

proc FetchPathSym*(pl: ValueArray, inplace: static bool = false): Value =
    ## Gets the `.p` field of a Path or PathLiteral value
    ## looks up all subsequent path fields
    ## and returns the value
    result = FetchSym(pl[0].s)
    
    var pidx = 1

    while pidx < pl.len:
        var p = pl[pidx]
        
        case result.kind:
            of Block:
                result = GetArrayIndex(result, p.i)
            of Dictionary:
                result = GetDictionaryKey(result, p.s)
            of Object:
                result = GetKey(result.o, p.s)
            of String:
                when inplace:
                    Error_PathLiteralMofifyingString()
                else:
                    result = newChar(result.s.runeAtPos(p.i))
            else: 
                discard

        pidx = pidx + 1

proc SetPathSym*(pl: ValueArray, val: Value) =
    ## Gets a the `.p` field of a PathLiteral value
    ## looks up all subsequent path fields
    ## and set it to given value
    var current = FetchSym(pl[0].s)
    var pidx = 1
    while pidx < pl.len:
        var p = pl[pidx]
        
        case current.kind:
            of Block:
                if pidx != pl.len - 1:
                    current = GetArrayIndex(current, p.i)
                else:
                    current.a[p.i] = val
            of Dictionary:
                if pidx != pl.len - 1:
                    current = GetDictionaryKey(current, p.s)
                else:
                    current.d[p.s] = val
            of Object:
                if pidx != pl.len - 1:
                    current = GetKey(current.o, p.s)
                else:
                    current.o[p.s] = val
            of String:
                if pidx != pl.len - 1:
                    current = newChar(current.s.runeAtPos(p.i))
                else:
                    Error_PathLiteralMofifyingString()
            else: 
                discard

        pidx = pidx + 1

template GetSym*(s: string): untyped =
    ## Get value for given symbol in table
    ## 
    ## **Hint:** if the key doesn't exist, it will throw an error;
    ## so, we have to make sure we know it exists beforehand
    Syms[s]

template SetSym*(s: string, v: Value, safe: static bool = false, forceReadOnly: static bool = false): untyped =
    ## Sets symbol to given value in the symbol table
    when safe:
        # When doing it safely, also check if the value to be assigned is a read-only value
        # - if it is - we have to copy it first
        # - otherwise, go ahead and just assign it (pointer copy!)
        when forceReadOnly:
            Syms[s] = copyValue(v)
        else:
            if v.readonly:
                Syms[s] = copyValue(v)
            else:
                Syms[s] = v
    else:
        Syms[s] = v

template SetDictSym*(s: string, v: Value, safe: static bool = false): untyped =
    ## Sets symbol to topmost Dictionary symbol table
    when safe:
        # When doing it safely, also check if the value to be assigned is a read-only value
        # - if it is - we have to copy it first
        # - otherwise, go ahead and just assign it (pointer copy!)
        if v.readonly:
            DictSyms[^1][s] = copyValue(v)
        else:
            DictSyms[^1][s] = v
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
        Error_CannotModifyConstant(varname)
    else:
        Error_SymbolNotFound(varname, suggestAlternative(varname))

template ensureInPlace*(): untyped = 
    ## To be used whenever, and always before, 
    ## we want to access an InPlace symbol
    var InPlaceAddr {.inject.}: ptr Value
    try:
        InPlaceAddr = addr Syms[x.s]
        if unlikely(InPlaced.readonly):
            Error_CannotModifyConstant(x.s)
    except CatchableError:
        showInPlaceError(x.s)

template ensureInPlaceAny*(): untyped =
    ## To be used whenever, and always before, 
    ## we want to access an InPlace symbol
    ## In contrast to `ensureInPlace`, this
    ## actually checks whether we have a Literal
    ## or a PathLiteral and treats it accordingly.
    var InPlaceAddr {.inject.}: ptr Value
    var fetchedPathSym {.inject.}: Value
    if likely(xKind==Literal):
        try:
            InPlaceAddr = addr Syms[x.s]
            if unlikely(InPlaced.readonly):
                Error_CannotModifyConstant(x.s)
        except CatchableError:
            showInPlaceError(x.s)
    else:
        fetchedPathSym = FetchPathSym(x.p, inplace=true)
        InPlaceAddr = addr fetchedPathSym

template SetInPlace*(v: Value, safe: static bool = false): untyped =
    ## Sets InPlace symbol to given value in the symbol table
    SetSym(x.s, v, safe)

template SetInPlaceAny*(v: Value, safe: static bool = false): untyped =
    ## Sets InPlace symbol to given value in the symbol table
    if likely(xKind == Literal):
        SetSym(x.s, v, safe)
    else:
        SetPathSym(x.p, v)

#---------------------
# Global config
#---------------------

template retrieveConfig*(globalKey: string, attrKey: string): untyped =
    var config {.inject.}: ValueDict
    var configFound = false

    if (let globalConfig = Config.sto.getStoreKey(globalKey, unsafe=true); not globalConfig.isNil):
        configFound = true
        config = globalConfig.d
    
    if (let attrConfig = getAttr(attrKey); attrConfig != VNULL):
        configFound = true
        config = attrConfig.d

    if not configFound:
        Error_ConfigNotFound(globalKey, attrKey)
