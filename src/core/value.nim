#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: core/value.nim
  *****************************************************************]#

#[----------------------------------------
    Value Object
  ----------------------------------------]#

##---------------------------
## Constructors
##---------------------------

proc SINT(v: string): Value {.inline.} =
    var intValue: int
    try: 
        discard parseInt(v, intValue)
        if intValue>MAX_INT:
            result = BIGINT(v)
        else:
            result = SINT(intValue)
    except: 
        result = BIGINT(v)

proc BIGINT*(v: string): Value {.inline.} =
    bitor(cast[Value](BIREF(newInt(v))),BIV_MASK)
    #Value(kind: BIV, bi: newInt(v))

proc REAL(v: string): Value {.inline.} =
    var floatValue: float
    discard parseFloat(v, floatValue)

    result = REAL(float32(floatValue))

proc STRARR(v: seq[string]): Value {.inline.} =
    result = ARR(v.map((x)=>STR(x)))

proc INTARR(v: seq[int]): Value {.inline.} =
    result = ARR(v.map((x)=>SINT(x)))

proc BIGINTARR(v: seq[Int]): Value {.inline.} =
    result = ARR(v.map((x)=>BIGINT(x)))

proc REALARR(v: seq[float]): Value {.inline.} =
    result = ARR(v.map((x)=>REAL(x)))

proc BOOLARR(v: seq[bool]): Value {.inline.} =
    result = ARR(v.map((x)=>BOOL(x)))

proc DICT(v: seq[(string,Value)]): Value {.inline.} =
    result = DICT(v.map((x)=>(storeOrGetHash(x[0]),x[1])))

proc valueCopy(v: Value): Value {.inline.} =
    {.computedGoto.}
    result = case v.kind
        of SV: STR(S(v))
        of IV: SINT(I(v))
        of RV: REAL(R(v))
        of AV: ARR(A(v).map((x) => valueCopy(x)))
        of DV: DICT(D(v).map((x) => (x[0],valueCopy(x[1]))))
        else: v

##---------------------------
## Methods
##---------------------------

proc findValueInArray(v: Value, lookup: Value): int =
    var i = 0
    while i < A(v).len:
        if A(v)[i].eq(lookup): return i 
        inc(i)
    return -1

proc findValueInArray(v: seq[Value], lookup: Value): int =
    var i = 0
    while i < v.len:
        if v[i].eq(lookup): return i 
        inc(i)
    return -1

##---------------------------
## Operator overloads
##---------------------------

proc `++`(l: Value, r: Value): Value {.inline.} =
    ## Addition

    {.computedGoto.}
    case l.kind
        of SV:
            result = case r.kind
                of SV: STR(S(l) & S(r))
                of IV: STR(S(l) & $(I(r)))
                of BIV: STR(S(l) & $(BI(r)))
                of RV: STR(S(l) & $(R(r)))
                else: STR(S(l) & r.stringify())
        of IV:
            {.computedGoto.}
            result = case r.kind
                of SV: STR($(I(l)) & S(r))
                of IV: 
                    var res: int32
                    if addWillOverflow(I(l),I(r),res):
                        BIGINT(newInt(I(l))+int(I(r)))
                    else:
                        SINT(res)
                of BIV: BIGINT(int(I(l))+BI(r))
                of RV: REAL(float(I(l))+R(r))
                else: InvalidOperationError("+",l.kind,r.kind)
        of BIV:
            result = case r.kind
                of IV: BIGINT(BI(l) + int(I(r)))
                of BIV: BIGINT(BI(l)+BI(r))
                else: InvalidOperationError("+",l.kind,r.kind)
        of RV:
            result = case r.kind
                of SV: STR($(R(l)) & S(r))
                of IV: REAL(R(l) + float(I(r)))
                of RV: REAL(R(l)+R(r))
                else: InvalidOperationError("+",l.kind,r.kind)
        of AV:
            if r.kind!=AV:
                result = ARR(A(l) & r)
            else: 
                result = ARR(A(l) & A(r))
        of DV:
            if r.kind==DV:
                result = valueCopy(l)
                for k in D(r).keys:
                   D(result).updateOrSet(k,D(r).getValueForKey(k))

            else: InvalidOperationError("+",l.kind,r.kind)
        else:
            InvalidOperationError("+",l.kind,r.kind)

proc `--`(l: Value, r: Value): Value {.inline.} =
    ## Subtraction

    {.computedGoto.}
    case l.kind
        of SV:
            result = case r.kind
                of SV: STR(S(l).replace(S(r),""))
                of IV: STR(S(l).replace($(I(r)),""))
                of BIV: STR(S(l).replace($(BI(r)),""))
                of RV: STR(S(l).replace($(R(r)),""))
                else: InvalidOperationError("-",l.kind,r.kind)
        of IV:
            result = case r.kind
                of IV: 
                    var res: int32
                    if subWillOverflow(I(l),I(r),res):
                        BIGINT(newInt(I(l))-int(I(r)))
                    else:
                        SINT(res)
                of BIV: BIGINT(int(I(l)) - BI(r))
                of RV: REAL(float(I(l))-R(r))
                else: InvalidOperationError("-",l.kind,r.kind)
        of BIV:
            result = case r.kind
                of IV: BIGINT(BI(l) - int(I(r)))
                of BIV: BIGINT(BI(l) - BI(r))
                else: InvalidOperationError("-",l.kind,r.kind)
        of RV:
            result = case r.kind
                of IV: REAL(R(l) - float(I(r)))
                of RV: REAL(R(l)-R(r))
                else: InvalidOperationError("-",l.kind,r.kind)
        of AV:
            result = valueCopy(l)
            if r.kind!=AV:
                A(result).delete(l.findValueInArray(r))
            else:
                for item in A(r):
                    A(result).delete(result.findValueInArray(item))

        of DV:
            result = valueCopy(l)
            var i = 0
            while i < D(l).len:
                if D(l)[i][1].eq(r):
                    D(result).del(i)
                inc(i)

        else:
            InvalidOperationError("-",l.kind,r.kind)

proc `**`(l: Value, r: Value): Value {.inline.} = 
    ## Multiplication

    {.computedGoto.}
    case l.kind
        of SV:
            result = case r.kind
                of IV: STR(S(l).repeat(I(r)))
                of RV: STR(S(l).repeat(int(R(r))))
                else: InvalidOperationError("*",l.kind,r.kind)
        of IV:
            result = case r.kind
                of SV: STR(S(r).repeat(I(l)))
                of IV: 
                    var res: int32
                    if mulWillOverflow(I(l),I(r),res):
                        BIGINT(newInt(I(l))*int(I(r)))
                    else:
                        SINT(res)
                of BIV: BIGINT(int(I(l)) * BI(r))
                of RV: REAL(float(I(l))*R(r))
                else: InvalidOperationError("*",l.kind,r.kind)
        of BIV:
            result = case r.kind
                of IV: BIGINT(BI(l) * int(I(r)))
                of BIV: BIGINT(BI(l) * BI(r))
                else: InvalidOperationError("*",l.kind,r.kind)
        of RV:
            result = case r.kind
                of SV: STR(S(r).repeat(int(R(l))))
                of IV: REAL(R(l) * float(I(r)))
                of RV: REAL(R(l)*R(r))
                else: InvalidOperationError("*",l.kind,r.kind)
        of AV:
            result = ARR(@[])
            if r.kind==IV or r.kind==RV:
                var limit:int
                if r.kind==IV: limit = I(r)
                else: limit = int(R(r))

                var i = 0
                while i<limit:
                    for item in A(l):
                        A(result).add(valueCopy(item))
                    inc(i)
            else: InvalidOperationError("*",l.kind,r.kind)
        else:
            InvalidOperationError("*",l.kind,r.kind)

proc `//`(l: Value, r: Value): Value {.inline.} = 
    ## (Integer) division

    {.computedGoto.}
    case l.kind
        of SV: discard
            # case r.kind
            #     of IV: 
            #         var k=0
            #         var resp=""
            #         result = ARR(@[])
            #         while k<S(l).len:
            #             resp &= S(l)[k]
            #             if ((k+1) mod I(r))==0: 
            #                 result.a.add(STR(resp))
            #                 resp = ""
            #             inc(k)
                
            #     of RV: 
            #         var k=0
            #         var resp=""
            #         result = ARR(@[])
            #         while k<S(l).len:
            #             resp &= S(l)[k]
            #             if ((k+1) mod int(R(r)))==0: 
            #                 result.a.add(STR(resp))
            #                 resp = ""
            #             inc(k)

            #     else: InvalidOperationError("/",l.kind,r.kind))
        of IV:
            result = case r.kind
                of IV: SINT(I(l) div I(r))
                #of BIV: BIGINT(I(l) div BI(r))
                of RV: REAL(float(I(l)) / R(r))
                else: InvalidOperationError("/",l.kind,r.kind)
        of BIV:
            result = case r.kind
                of IV: BIGINT(BI(l) div int(I(r)))
                of BIV: BIGINT(BI(l) div BI(r))
                else: InvalidOperationError("/",l.kind,r.kind)
        of RV:
            result = case r.kind
                of IV: REAL(R(l) / float(I(r)))
                of RV: REAL(R(l) / R(r))
                else: InvalidOperationError("/",l.kind,r.kind)
        of AV:
            result = ARR(@[])
            if r.kind==IV or r.kind==RV:
                var limit:int
                if r.kind==IV: limit = I(r)
                else: limit = int(R(r))

                var k = 0
                var resp = ARR(@[])
                while k<A(l).len:
                    A(resp).add(valueCopy(A(l)[k]))
                    if ((k+1) mod limit)==0: 
                        A(result).add(resp)
                        resp = ARR(@[])
                    inc(k)

            else: InvalidOperationError("/",l.kind,r.kind)
        else:
            InvalidOperationError("/",l.kind,r.kind)

proc `%%`(l: Value, r: Value): Value {.inline.} =
    ## Modulo

    {.computedGoto.}
    case l.kind
        of SV:
            case r.kind
                of IV: 
                    let le = (S(l).len mod I(r))
                    result = STR(S(l)[S(l).len-le..^1])
                
                of RV: 
                    let le = (S(l).len mod int(R(r)))
                    result = STR(S(l)[S(l).len-le..^1])

                else: InvalidOperationError("%",l.kind,r.kind)
        of IV:
            result = case r.kind
                of IV: SINT(cast[int32](I(l) mod I(r)))
                of BIV: BIGINT(int(I(l)) mod BI(r))
                of RV: SINT(I(l) mod int(R(r)))
                else: InvalidOperationError("%",l.kind,r.kind)
        of BIV:
            result = case r.kind
                of IV: BIGINT(BI(l) mod int(I(r)))
                of BIV: BIGINT(BI(l) mod BI(r))
                else: InvalidOperationError("%",l.kind,r.kind)
        of RV:
            result = case r.kind
                of IV: SINT(int(R(l)) mod I(r))
                of RV: SINT(int(R(l)) mod int(R(r)))
                else: InvalidOperationError("%",l.kind,r.kind)
        of AV:
            result = ARR(@[])
            if r.kind==IV or r.kind==RV:
                var limit:int
                if r.kind==IV: limit = I(r)
                else: limit = int(R(r))

                let le = (A(l).len mod limit)
                result = ARR(A(l)[A(l).len-le..^1])
            else: InvalidOperationError("%",l.kind,r.kind)
        else:
            InvalidOperationError("%",l.kind,r.kind)

proc `^^`(l: Value, r: Value): Value {.inline.} =
    ## Powers

    {.computedGoto.}
    case l.kind
        of IV:
            result = case r.kind
                of IV: 
                    try: SINT(I(l) ^ I(r))
                    except Exception: BIGINT(pow(newInt(I(l)),culong(I(r))))
                of RV: SINT(I(l) ^ int(R(r)))
                else: InvalidOperationError("^",l.kind,r.kind)
        # of BIV:
        #     result = case r.kind
        #         of IV: BIGINT(BI(l) ^ culong(I(r)))
        #         else: InvalidOperationError("^",l.kind,r.kind))
        of RV:
            result = case r.kind
                of IV: SINT(int(R(l)) ^ I(r))
                of RV: REAL(pow(R(l),R(r)))
                else: InvalidOperationError("^",l.kind,r.kind)
        else:
            InvalidOperationError("^",l.kind,r.kind)

proc eq(l: Value, r: Value): bool {.inline.} =
    ## The `==` operator

    {.computedGoto.}
    case l.kind
        of SV:
            result = case r.kind
                of SV: S(l)==S(r)
                else: NotComparableError(l.kind,r.kind)
        of IV:
            result = case r.kind
                of IV: I(l)==I(r)
                of BIV: int(I(l))==BI(r)
                of RV: I(l)==int(R(r))
                else: NotComparableError(l.kind,r.kind)
        of BIV:
            result = case r.kind
                of IV: BI(l)==int(I(r))
                of BIV: BI(l)==BI(r)
                of RV: BI(l)==int(R(r))
                else: NotComparableError(l.kind,r.kind)
        of RV:
            result = case r.kind
                of IV: int(R(l))==I(r)
                of BIV: int(R(l))==BI(r)
                of RV: R(l)==R(r)
                else: NotComparableError(l.kind,r.kind)
        of BV:
            result = case r.kind
                of BV: l==r
                else: NotComparableError(l.kind,r.kind)
        of AV:
            case r.kind
                of AV:
                    if A(l).len!=A(r).len: result = false
                    else:
                        var i=0
                        while i<A(l).len:
                            if not (A(l)[i].eq(A(r)[i])): return false
                            inc(i)
                        result = true
                else: NotComparableError(l.kind,r.kind)
        of DV:
            case r.kind
                of DV:
                    if D(l).keys!=D(r).keys: result = false
                    else:
                        # var i = 0
                        # while i < D(l).list.len:
                        #     if not D(r).hasKey(D(l).list[i][0]): return false
                        #     else:
                        #         if not (D(l).list[i][1].eq(D(r).getValueForKey(D(l).list[i][0]))): return false
                        #     inc(i)

                        result = true 
                else: NotComparableError(l.kind,r.kind)

        else: NotComparableError(l.kind,r.kind)

proc lt(l: Value, r: Value): bool {.inline.} =
    ## The `<` operator

    {.computedGoto.}
    case l.kind
        of SV:
            result = case r.kind
                of SV: S(l)<S(r)
                else: NotComparableError(l.kind,r.kind)
                    
        of IV:
            result = case r.kind
                of IV: I(l)<I(r)
                of BIV: int(I(l))<BI(r)
                of RV: I(l)<int(R(r))
                else: NotComparableError(l.kind,r.kind)
        of BIV:
            result = case r.kind
                of IV: BI(l)<int(I(r))
                of BIV: BI(l)<BI(r)
                of RV: BI(l)<int(R(r))
                else: NotComparableError(l.kind,r.kind)
        of RV:
            result = case r.kind
                of IV: int(R(l))<I(r)
                of BIV: int(R(l))<BI(r)
                of RV: R(l)<R(r)
                else: NotComparableError(l.kind,r.kind)
        of AV:
            result = case r.kind
                of AV: A(l).len < A(r).len
                else: NotComparableError(l.kind,r.kind)
        of DV:
            result = case r.kind
                of DV: D(l).keys.len < D(r).keys.len
                else: NotComparableError(l.kind,r.kind)

        else: NotComparableError(l.kind,r.kind)

proc gt(l: Value, r: Value): bool {.inline.} =
    ## The `>` operator

    {.computedGoto.}
    case l.kind
        of SV:
            result = case r.kind
                of SV: S(l)>S(r)
                else: NotComparableError(l.kind,r.kind)   
        of IV:
            result = case r.kind
                of IV: I(l)>I(r)
                of BIV: int(I(l))>BI(r)
                of RV: I(l)>int(R(r))
                else: NotComparableError(l.kind,r.kind)
        of BIV:
            result = case r.kind
                of IV: BI(l)>int(I(r))
                of BIV: BI(l)>BI(r)
                of RV: BI(l)>int(R(r))
                else: NotComparableError(l.kind,r.kind)
        of RV:
            result = case r.kind
                of IV: int(R(l))>I(r)
                of BIV: int(R(l))>BI(r)
                of RV: R(l)>R(r)
                else: NotComparableError(l.kind,r.kind)
        of AV:
            result = case r.kind
                of AV: A(l).len > A(r).len
                else: NotComparableError(l.kind,r.kind)
        of DV:
            result = case r.kind
                of DV: D(l).keys.len > D(r).keys.len
                else: NotComparableError(l.kind,r.kind)

        else: NotComparableError(l.kind,r.kind)

##---------------------------
## Inspection
##---------------------------

proc valueKindToPrintable*(vk: int): string = 
    ## Convert ValueKind string representation to sth shorter and more readable
    ## ! Requires better rewriting

    result = {
        0   :"null",
        1   :"int",
        2   :"int+",
        4   :"real",
        8   :"bool",
        16  :"string",
        32  :"array",
        64  :"dict",
        128 :"func",
        255 :"any"
    }.toTable[vk]

proc valueKindsToPrintable*(vk: int): string = 
    ## Convert ValueKind string representation to sth shorter and more readable
    ## ! Requires better rewriting

    let vks = {
        0   :"null",
        1   :"int",
        2   :"int+",
        4   :"real",
        8   :"bool",
        16  :"string",
        32  :"array",
        64  :"dict",
        128 :"func"
    }.toTable

    var ret: seq[string]
    if vk==ANY:
        return "any"
    else:
        for k,v in vks.pairs:
            if bitand(vk,k) != 0 :
                ret.add(v)

        result = ret.join(", ")

proc stringify*(v: Value, quoted: bool = true): string {.inline.} =
    {.computedGoto.}
    case v.kind
        of SV   :   ( if quoted: result = escape(S(v)) else: result = S(v) )
        of IV   :   result = $(I(v))
        of BIV  :   result = $(BI(v))
        of RV   :   result = $(R(v))
        of BV   :   result = $(B(v))
        of AV   :
            result = "#("

            let items = A(v).map((x) => x.stringify())

            result &= items.join(" ")
            result &= ")"
        of DV   :
            result = "#{ "
            
            let items = sorted(D(v).keys).map((x) => x & ": " & D(v).getValueForKey(x).stringify())

            result &= items.join(", ")
            result &= " }"

            if result=="#{  }": result = "#{}"
        of FV   :   result = "<function> "# & fmt"{cast[int](unsafeAddr(FN(v))):#x}" & ">"
        of NV   :   result = "null"
        else    : discard
        #of ANY  :   result = ""

proc inspect*(v: Value, prepend: int = 0, isKeyVal: bool = false): string =
    const 
        RESTORE_COLOR   = "\x1B[0;37m"
        STR_COLOR       = "\x1B[0;33m"
        NUM_COLOR       = "\x1B[0;35m"
        KEY_COLOR       = "\x1B[1;37m"
        INSPECT_PADDING = 16

    let padding = 
        if isKeyVal: INSPECT_PADDING
        else: 0

    {.computedGoto.}
    case v.kind
        of SV   :   result = STR_COLOR & escape(S(v)) & RESTORE_COLOR
        of IV   :   result = NUM_COLOR & $(I(v)) & RESTORE_COLOR
        #of BIV  :   result = NUM_COLOR & $(v.bi) & RESTORE_COLOR
        of RV   :   result = NUM_COLOR & $(R(v)) & RESTORE_COLOR
        of BV   :   result = NUM_COLOR & $(B(v)) & RESTORE_COLOR
        of AV   :
            result = "#(\n"

            if A(v).len==0: return "#()"
            let items = A(v).map((x) => repeat("\t",prepend) & repeat(" ",padding) & "\t" & x.inspect(prepend+1,isKeyVal) & "\n")

            result &= items.join("")
            result &= repeat("\t",prepend) & repeat(" ",padding) & ")"
        of DV   :
            result = "#{\n"
            
            if D(v).keys.len==0: return "#{}"
            let items = sorted(D(v).keys).map((x) => repeat("\t",prepend) & repeat(" ",padding) & "\t" & KEY_COLOR & strutils.alignLeft(x,INSPECT_PADDING) & RESTORE_COLOR & ": " & D(v).getValueForKey(x).inspect(prepend+1,true) & "\n")

            result &= items.join("")
            result &= repeat("\t",prepend) & repeat(" ",padding) & "}"
        of FV   :   result = "<function> "# & fmt"{cast[int](addr(v.f)):#x}" & ">"
        of NV   :   result = "null"
        #of ANY  :   result = ""
        else : discard
        