#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: vm/globals.nim
#=======================================================

## VM globals & helpers.

#=======================================
# Libraries
#=======================================

import sequtils, tables, unicode

import helpers/strings

import vm/[errors, symslots, values/value]
export symslots

#=======================================
# Globals
#=======================================

# TODO(VM/globals) Is there any way to actually avoid them altogether?
#  Having all these global variables is practical, but it actually causes problems when we end up wanting to work with multiple threads. An idea would be to add them as fields in a VM object, and pass this object around. But it would still need to be properly benchmark as it would - undoubtedly - add some serious overhead.
#  labels: vm, enhancement, benchmark, open discussion

var
    # symbols
    Syms* {.global.}        : SymSlots                      ## The symbol table: all the variables 
                                                            ## with their associated values

    # symbol aliases
    Aliases* {.global.}     : SymbolDict                    ## The symbol aliases: all the symbols
                                                            ## with all their associated variables
                                                            ## they point to

    # libraries 
    LibraryModules* {.global.}  : Table[string, ModuleDef]  ## The table of all builtin libraries
                                                            ## to be imported at startup
    
    # dictionary symbols stack
    DictSyms* {.global.}        : seq[ValueDict]            ## The stack of dictionaries to be filled
                                                            ## when using `execDictionary`

    # function scope stack
    ScopeStack* {.global.}      : seq[ScopeFrame]               ## Per-call undo log of touched
                                                                ## symbols (nil = didn't exist)

    # scope frame pool
    ScopeFramePool* {.global.}  : seq[ScopeFrame]               ## Recycled frames, to avoid
                                                                ## reallocating on every call
    
    # active stores
    ScopeStamps* {.global.}     : seq[uint64]                   ## Per symbol: the frame that last
                                                                ## recorded it
    ScopeSerial* {.global.}     : uint64

    Stores* {.global.}          : seq[VStore]               ## The list of active stores to be stored
                                                            ## before app termination

    # global configuration
    Config* {.global.}          : Value                     ## The global configuration store

    # dump values (from anywhere!)
    Dumper* {.global.}          : proc (v:Value):string

#=======================================
# Helpers
#=======================================

proc suggestAlternative(s: string, reference: SymSlots | SymTable | ValueDict = Syms): seq[string] {.inline.} =
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
    arr.cachedTrans = nil

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

proc FetchSymById*(v: Value): Value {.inline.} =
    ## Same as `FetchSym`, for a Word/Literal/... value
    if (result = Syms.getById(symIdOf(v)); unlikely(result.isNil)):
        Error_SymbolNotFound(v.s, suggestAlternative(v.s))

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
                    current.cachedTrans = nil
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

proc pushScopeFrame*() {.inline.} =
    ## Push a fresh - or recycled - scope frame
    inc ScopeSerial
    if ScopeFramePool.len > 0:
        ScopeStack.add(ScopeFramePool.pop())
    else:
        ScopeStack.add(ScopeFrame())
    ScopeStack[^1].serial = ScopeSerial

proc popScopeFrame*(): ScopeFrame {.inline.} =
    ## Pop the topmost scope frame
    result = ScopeStack.pop()

const ScopeFramePoolMax = 64

proc releaseScopeFrame*(frame: var ScopeFrame) {.inline.} =
    ## Hand a used frame back to the pool - dropped if pool is full
    if ScopeFramePool.len < ScopeFramePoolMax:
        frame.entries.setLen(0)
        ScopeFramePool.add(move frame)

proc growScopeStamps(id: int32) {.noinline.} =
    ScopeStamps.setLen(max(int(id) + 1, max(1024, ScopeStamps.len * 2)))

proc recordScopeWriteById*(id: int32) {.inline.} =
    ## Record symbol's previous value in the current scope frame,
    ## the first time it's touched - nil if it didn't exist
    if ScopeStack.len > 0:
        if unlikely(id >= ScopeStamps.len): growScopeStamps(id)
        let frame = addr ScopeStack[^1]
        if ScopeStamps[id] != frame.serial:
            frame.entries.add((id, Syms.getById(id), ScopeStamps[id]))
            ScopeStamps[id] = frame.serial

proc recordScopeWrite*(s: string) {.inline.} =
    recordScopeWriteById(symId(s))

proc restoreScopeFrame*(frame: var ScopeFrame, exports: Value = nil) =
    ## Undo everything recorded in given frame - last one first,
    ## as a symbol may have been recorded more than once
    for i in countdown(frame.entries.high, 0):
        let e = addr frame.entries[i]
        ScopeStamps[e.id] = e.stamp
        if not exports.isNil:
            var isExport = false
            for ek in exports.a:
                if symIdOf(ek) == e.id:
                    isExport = true
                    break
            if isExport: continue
        if e.prev.isNil:
            Syms.delById(e.id)
        else:
            Syms.setById(e.id, move e.prev)

proc putSym*(s: string, v: sink Value) {.inline.} =
    ## Write to the symbol table, by name
    Syms[s] = v

template SetSymById*(id: int32, v: Value, safe: static bool = false, forceReadOnly: static bool = false): untyped =
    ## Sets symbol to given value in the symbol table
    recordScopeWriteById(id)
    when safe:
        # When doing it safely, also check if the value to be assigned is a read-only value
        # - if it is - we have to copy it first
        # - otherwise, go ahead and just assign it (pointer copy!)
        when forceReadOnly:
            Syms.setById(id, copyValue(v))
        else:
            if v.readonly:
                Syms.setById(id, copyValue(v))
            else:
                Syms.setById(id, v)
    else:
        Syms.setById(id, v)

template SetSym*(s: string, v: Value, safe: static bool = false, forceReadOnly: static bool = false): untyped =
    ## Sets symbol to given value in the symbol table
    block:
        let symbolId = symId(s)
        SetSymById(symbolId, v, safe, forceReadOnly)

template UnsetSym*(s: string): untyped =
    recordScopeWrite(s)
    Syms.del(s)

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
    var InPlaceAddr {.inject.}: ptr Value = Syms.addrById(symIdOf(x))
    if unlikely(InPlaceAddr.isNil):
        showInPlaceError(x.s)
    if unlikely(InPlaced.readonly):
        Error_CannotModifyConstant(x.s)

template ensureInPlaceAny*(): untyped =
    ## To be used whenever, and always before, 
    ## we want to access an InPlace symbol
    ## In contrast to `ensureInPlace`, this
    ## actually checks whether we have a Literal
    ## or a PathLiteral and treats it accordingly.
    var InPlaceAddr {.inject.}: ptr Value
    var fetchedPathSym {.inject.}: Value
    if likely(xKind==Literal):
        InPlaceAddr = Syms.addrById(symIdOf(x))
        if unlikely(InPlaceAddr.isNil):
            showInPlaceError(x.s)
        if unlikely(InPlaced.readonly):
            Error_CannotModifyConstant(x.s)
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