#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: helpers/net.nim
#=======================================================

## Client-side HTTP helpers shared by sync `request` and
## the in-process `request.async` path.
## (Server-side helpers live in `helpers/servers.nim`.)

#=======================================
# Libraries
#=======================================

when not defined(WEB):
    import httpcore, strutils, tables, times

    import vm/values/value
    import vm/values/types

#=======================================
# Methods
#=======================================

when not defined(WEB):
    # build the `:dictionary` Value the `request` builtin returns from the
    # raw fields of an HTTP response. shared by sync `request` and the
    # in-process `request.async` path so the two stay byte-for-byte identical.
    proc httpResponseToValue*(version, body, status: string,
                              headers: HttpHeaders, raw: bool): Value =
        var ret: ValueDict = initOrderedTable[string, Value]()
        ret["version"] = newString(version)
        ret["body"] = newString(body)
        ret["headers"] = newDictionary()

        if raw:
            ret["status"] = newString(status)
            for k, v in headers.table:
                ret["headers"].d[k] = newStringBlock(v)
        else:
            try:
                let respStatus = (status.splitWhitespace())[0]
                ret["status"] = newInteger(respStatus)
            except CatchableError:
                ret["status"] = newString(status)

            for k, v in headers.table:
                var val: Value
                if v.len == 1:
                    case k
                        of "age", "content-length":
                            try:
                                val = newInteger(v[0])
                            except CatchableError:
                                val = newString(v[0])
                        of "access-control-allow-credentials":
                            val = newLogical(v[0])
                        of "date", "expires", "last-modified":
                            let dateParts = v[0].splitWhitespace()
                            let cleanDate = (dateParts[0..(dateParts.len-2)]).join(" ")
                            var dateFormat = "ddd, dd MMM YYYY HH:mm:ss"
                            let timeFormat = initTimeFormat(dateFormat)
                            try:
                                val = newDate(parse(cleanDate, timeFormat))
                            except CatchableError:
                                val = newString(v[0])
                        else:
                            val = newString(v[0])
                else:
                    val = newStringBlock(v)
                ret["headers"].d[k] = val

        result = newDictionary(ret)
