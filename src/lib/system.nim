#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system.nim
  *****************************************************************]#

##---------------------------
## Includes
##---------------------------

include system/array
include system/base
include system/convert
include system/crypto
include system/csv
include system/dictionary
include system/generic
include system/io
include system/json
include system/logical
include system/math
include system/net
include system/path
include system/reflection
include system/set
include system/string
include system/terminal
include system/time
include system/url

##---------------------------
## Function registration
##---------------------------

let 
    SystemFunctions* = @[
        #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        #              Library              Name                        Call                            Args                                                                                Return                  Description                                                                                             
        #----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        SystemFunction(lib:"array",         name:"all",                 call:Array_all),#                 req:@[@[AV],@[AV,FV]],                                                             ret: @[BV],             desc:"check if all elements of array are true or pass the condition of given function",
        SystemFunction(lib:"array",         name:"any",                 call:Array_any),#                 req:@[@[AV],@[AV,FV]],                                                             ret: @[BV],             desc:"check if any elements of array are true or pass the condition of given function",
        SystemFunction(lib:"array",         name:"count",               call:Array_count),#               req:@[@[AV,FV]],                                                                   ret: @[IV],             desc:"get number of elements from array that pass given condition",
        SystemFunction(lib:"array",         name:"filter",              call:Array_filter),#              req:@[@[AV,FV]],                                                                   ret: @[AV],             desc:"get array after filtering each element using given function",
        SystemFunction(lib:"array",         name:"filter!",             call:Array_filterI),#             req:@[@[AV,FV]],                                                                   ret: @[AV],             desc:"get array after filtering each element using given function (in-place)",
        SystemFunction(lib:"array",         name:"first",               call:Array_first),#               req:@[@[AV]],                                                                      ret: @[NV],            desc:"get first element of given array",
        SystemFunction(lib:"array",         name:"fold",                call:Array_fold),#                req:@[@[AV,IV,FV],@[AV,BIV,FV],@[AV,SV,FV],@[AV,AV,FV],@[AV,DV,FV]],               ret: @[IV,BIV,SV,AV,DV],desc:"fold array using seed value and the given function",
        SystemFunction(lib:"array",         name:"last",                call:Array_last),#                req:@[@[AV]],                                                                      ret: @[NV],            desc:"get last element of given array",
        SystemFunction(lib:"array",         name:"map",                 call:Array_map),#                 req:@[@[AV,FV]],                                                                   ret: @[AV],             desc:"get array after executing given function for each element",
        SystemFunction(lib:"array",         name:"map!",                call:Array_mapI),#                req:@[@[AV,FV]],                                                                   ret: @[AV],             desc:"get array after executing given function for each element (in-place)",
        SystemFunction(lib:"array",         name:"permutations",        call:Array_permutations),#        req:@[@[AV]],                                                                      ret: @[AV],             desc:"get all permutations for given array",
        SystemFunction(lib:"array",         name:"pop",                 call:Array_pop),#                 req:@[@[AV]],                                                                      ret: @[NV],            desc:"get last element of given array (same as 'last')",
        SystemFunction(lib:"array",         name:"pop!",                call:Array_popI),#                req:@[@[AV]],                                                                      ret: @[NV],            desc:"get last element of given array and delete it (in-place)",
        SystemFunction(lib:"array",         name:"range",               call:Array_range),#               req:@[@[IV,IV]],                                                                   ret: @[AV],             desc:"get array from given range (from..to)",
        SystemFunction(lib:"array",         name:"rangeBy",             call:Array_rangeBy),#             req:@[@[IV,IV,IV]],                                                                ret: @[AV],             desc:"get array from given range (from..to) with step",
        SystemFunction(lib:"array",         name:"rotate",              call:Array_rotate),#              req:@[@[AV],@[AV,IV]],                                                             ret: @[AV],             desc:"rotate given array, optionally by using step; negative values for left rotation",
        SystemFunction(lib:"array",         name:"rotate!",             call:Array_rotateI),#             req:@[@[AV],@[AV,IV]],                                                             ret: @[AV],             desc:"rotate given array, optionally by using step; negative values for left rotation (in-place)",
        SystemFunction(lib:"array",         name:"sample",              call:Array_sample),#              req:@[@[AV]],                                                                      ret: @[NV],            desc:"get random sample from given array",
        SystemFunction(lib:"array",         name:"shuffle",             call:Array_shuffle),#             req:@[@[AV]],                                                                      ret: @[AV],             desc:"shuffle given array",
        SystemFunction(lib:"array",         name:"shuffle!",            call:Array_shuffleI),#            req:@[@[AV]],                                                                      ret: @[AV],             desc:"shuffle given array (in-place)",
        SystemFunction(lib:"array",         name:"sort",                call:Array_sort),#                req:@[@[AV]],                                                                      ret: @[AV],             desc:"sort given array",
        SystemFunction(lib:"array",         name:"sort!",               call:Array_sortI),#               req:@[@[AV]],                                                                      ret: @[AV],             desc:"sort given array (in-place)",
        SystemFunction(lib:"array",         name:"sortBy",              call:Array_sortBy),#                req:@[@[AV]],                                                                      ret: @[AV],             desc:"sort given array",
        SystemFunction(lib:"array",         name:"sortBy!",             call:Array_sortByI),
        SystemFunction(lib:"array",         name:"swap",                call:Array_swap),#                req:@[@[AV,IV,IV]],                                                                ret: @[AV],             desc:"swap array elements at given indices",
        SystemFunction(lib:"array",         name:"swap!",               call:Array_swapI),#               req:@[@[AV,IV,IV]],                                                                ret: @[AV],             desc:"swap array elements at given indices (in-place)",
        SystemFunction(lib:"array",         name:"unique",              call:Array_unique),#              req:@[@[AV]],                                                                      ret: @[AV],             desc:"remove duplicates from given array",
        SystemFunction(lib:"array",         name:"unique!",             call:Array_uniqueI),#             req:@[@[AV]],                                                                      ret: @[AV],             desc:"remove duplicates from given array (in-place)",
        SystemFunction(lib:"array",         name:"zip",                 call:Array_zip),#                 req:@[@[AV,AV]],                                                                   ret: @[AV],             desc:"get array of element pairs using given arrays",

        SystemFunction(lib:"base",          name:"exec",                call:Base_exec),#                 req:@[@[FV,AV]],                                                                   ret: @[NV],            desc:"execute function using given array of values",
        SystemFunction(lib:"base",          name:"if",                  call:Base_if),#                   req:@[@[BV,FV],@[BV,FV,FV]],                                                       ret: @[NV],            desc:"if condition is true, execute given function; else execute optional alternative function",
        SystemFunction(lib:"base",          name:"import",              call:Base_import),#               req:@[@[SV]],                                                                      ret: @[NV],            desc:"import module or object in given script path",
        SystemFunction(lib:"base",          name:"loop",                call:Base_loop),#                 req:@[@[AV,FV],@[DV,FV],@[BV,FV],@[IV,FV]],                                        ret: @[NV],            desc:"execute given function for each element in collection, or while condition is true",
        SystemFunction(lib:"base",          name:"new",                 call:Base_new),#                  req:@[@[SV],@[IV],@[BIV],@[RV],@[BV],@[AV],@[DV],@[FV]],                           ret: @[NV],            desc:"get new copy of given object",
        SystemFunction(lib:"base",          name:"panic",               call:Base_panic),#                req:@[@[SV]],                                                                      ret: @[SV],             desc:"exit program printing given error message",
        SystemFunction(lib:"base",          name:"return",              call:Base_return),#               req:@[@[SV],@[AV],@[IV],@[BIV],@[FV],@[BV],@[RV]],                                 ret: @[NV],            desc:"break execution and return given value",
        SystemFunction(lib:"base",          name:"syms",                call:Base_syms),#                 req:@[@[NV]],                                                                      ret: @[NV],            desc:"break execution and return given value",

        SystemFunction(lib:"convert",       name:"toBin",               call:Convert_toBin),#             req:@[@[IV]],                                                                      ret: @[SV],             desc:"convert given number to its binary string representation",
        SystemFunction(lib:"convert",       name:"toHex",               call:Convert_toHex),#             req:@[@[IV]],                                                                      ret: @[SV],             desc:"convert given number to its hexadecimal string representation",
        SystemFunction(lib:"convert",       name:"toInt",               call:Convert_toInt),
        SystemFunction(lib:"convert",       name:"toMutable",           call:Convert_toMutable),
        SystemFunction(lib:"convert",       name:"toNumber",            call:Convert_toNumber),#          req:@[@[SV],@[RV],@[BV]],                                                                ret: @[IV],             desc:"convert given string, real or boolean to an integer number",
        SystemFunction(lib:"convert",       name:"toOct",               call:Convert_toOct),#             req:@[@[IV]],                                                                      ret: @[SV],             desc:"convert given number to its octal string representation",
        SystemFunction(lib:"convert",       name:"toReal",              call:Convert_toReal),#            req:@[@[IV]],                                                                      ret: @[SV],             desc:"convert given integer number to real",
        SystemFunction(lib:"convert",       name:"toString",            call:Convert_toString),#          req:@[@[SV],@[IV],@[BIV],@[RV],@[AV],@[DV],@[FV],@[NV]],                           ret: @[SV],             desc:"convert given value to string",

        SystemFunction(lib:"crypto",        name:"decodeBase64",        call:Crypto_decodeBase64),#       req:@[@[SV]],                                                                      ret: @[SV],             desc:"Base64-decode given string",
        SystemFunction(lib:"crypto",        name:"decodeBase64!",       call:Crypto_decodeBase64I),#      req:@[@[SV]],                                                                      ret: @[SV],             desc:"Base64-decode given string (in-place)",
        SystemFunction(lib:"crypto",        name:"encodeBase64",        call:Crypto_encodeBase64),#       req:@[@[SV]],                                                                      ret: @[SV],             desc:"Base64-encode given string",
        SystemFunction(lib:"crypto",        name:"encodeBase64!",       call:Crypto_encodeBase64I),#      req:@[@[SV]],                                                                      ret: @[SV],             desc:"Base64-encode given string (in-place)",
        SystemFunction(lib:"crypto",        name:"md5",                 call:Crypto_md5),#                req:@[@[SV]],                                                                      ret: @[SV],             desc:"MD5-encrypt given string",
        SystemFunction(lib:"crypto",        name:"md5!",                call:Crypto_md5I),#               req:@[@[SV]],                                                                      ret: @[SV],             desc:"MD5-encrypt given string (in-place)",
        SystemFunction(lib:"crypto",        name:"sha1",                call:Crypto_sha1),#               req:@[@[SV]],                                                                      ret: @[SV],             desc:"SHA1-encrypt given string",
        SystemFunction(lib:"crypto",        name:"sha1!",               call:Crypto_sha1I),#              req:@[@[SV]],                                                                      ret: @[SV],             desc:"SHA1-encrypt given string (in-place)",
        SystemFunction(lib:"crypto",        name:"uuid",                call:Crypto_uuid),

        SystemFunction(lib:"csv",           name:"generateCsv",         call:Csv_generateCsv),#           req:@[@[AV]],                                                                      ret: @[SV],             desc:"get CSV string from given array of rows",
        SystemFunction(lib:"csv",           name:"parseCsv",            call:Csv_parseCsv),#              req:@[@[SV],@[SV,BV]],                                                             ret: @[AV],             desc:"get array of rows by parsing given CSV string, optionally using headers",

        SystemFunction(lib:"dictionary",    name:"hasKey",              call:Dictionary_hasKey),#         req:@[@[DV,SV]],                                                                   ret: @[BV],             desc:"check if dictionary contains key",
        SystemFunction(lib:"dictionary",    name:"keys",                call:Dictionary_keys),#           req:@[@[DV]],                                                                      ret: @[AV],             desc:"get array of dictionary keys",
        SystemFunction(lib:"dictionary",    name:"values",              call:Dictionary_values),#         req:@[@[DV]],                                                                      ret: @[AV],             desc:"get array of dictionary values",  

        SystemFunction(lib:"generic",       name:"append",              call:Generic_append),#            req:@[@[AV,SV],@[AV,IV],@[AV,BIV],@[AV,BV],@[AV,AV],@[AV,DV],@[AV,FV],@[SV,SV]],   ret: @[AV,SV],          desc:"append element to given array/string",
        SystemFunction(lib:"generic",       name:"append!",             call:Generic_appendI),#           req:@[@[AV,SV],@[AV,IV],@[AV,BIV],@[AV,BV],@[AV,AV],@[AV,DV],@[AV,FV],@[SV,SV]],   ret: @[AV,SV],          desc:"append element to given array/string (in-place)",
        SystemFunction(lib:"generic",       name:"contains",            call:Generic_contains),#          req:@[@[AV,SV],@[AV,IV],@[AV,BIV],@[AV,BV],@[AV,AV],@[AV,DV],@[AV,FV],
                                                                                                               #@[DV,SV],@[DV,IV],@[DV,BIV],@[DV,BV],@[DV,AV],@[DV,DV],@[DV,FV],@[SV,SV]],   ret: @[BV],             desc:"check if collection contains given element",
        SystemFunction(lib:"generic",       name:"delete",              call:Generic_delete),#            req:@[@[AV,SV],@[AV,IV],@[AV,BIV],@[AV,BV],@[AV,AV],@[AV,DV],@[AV,FV],
                                                                                                               #@[DV,SV],@[DV,IV],@[DV,BIV],@[DV,BV],@[DV,AV],@[DV,DV],@[DV,FV],@[SV,SV]],   ret: @[AV,SV,DV],       desc:"delete value from given array, dictionary or string",
        SystemFunction(lib:"generic",       name:"delete!",             call:Generic_deleteI),#           req:@[@[AV,SV],@[AV,IV],@[AV,BIV],@[AV,BV],@[AV,AV],@[AV,DV],@[AV,FV],
                                                                                                               #@[DV,SV],@[DV,IV],@[DV,BIV],@[DV,BV],@[DV,AV],@[DV,DV],@[DV,FV],@[SV,SV]],   ret: @[AV,SV,DV],       desc:"delete value from given array, dictionary or string (in-place)",
        SystemFunction(lib:"generic",       name:"deleteBy",            call:Generic_deleteBy),#          req:@[@[AV,IV],@[DV,SV],@[SV,IV]],                                                 ret: @[AV,SV,DV],       desc:"delete index from given array, dictionary or string",
        SystemFunction(lib:"generic",       name:"deleteBy!",           call:Generic_deleteByI),#         req:@[@[AV,IV],@[DV,SV],@[SV,IV]],                                                 ret: @[AV,SV,DV],       desc:"delete index from given array, dictionary or string (in-place)",
        SystemFunction(lib:"generic",       name:"get",                 call:Generic_get),#               req:@[@[AV,IV],@[DV,SV],@[SV,IV]],                                                 ret: @[NV],            desc:"get element from array, dictionary or string using given index/key",
        SystemFunction(lib:"generic",       name:"index",               call:Generic_index),#             req:@[@[AV,SV],@[AV,IV],@[AV,BIV],@[AV,BV],@[AV,AV],@[AV,DV],@[AV,FV],@[SV,SV]],   ret: @[IV],             desc:"get index of string/element within string/array or -1 if not found",
        SystemFunction(lib:"generic",       name:"isEmpty",             call:Generic_isEmpty),#           req:@[@[AV],@[SV],@[DV]],                                                          ret: @[BV],             desc:"check if given array, dictionary or string is empty",
        SystemFunction(lib:"generic",       name:"prepend",             call:Generic_prepend),
        SystemFunction(lib:"generic",       name:"prepend!",            call:Generic_prependI),
        SystemFunction(lib:"generic",       name:"reverse",             call:Generic_reverse),#           req:@[@[AV],@[SV]],                                                                ret: @[AV,SV],          desc:"reverse given array or string",
        SystemFunction(lib:"generic",       name:"reverse!",            call:Generic_reverseI),#          req:@[@[AV],@[SV]],                                                                ret: @[AV,SV],          desc:"reverse given array or string (in-place)",
        SystemFunction(lib:"generic",       name:"set",                 call:Generic_set),#               req:@[@[AV,IV,IV],@[AV,IV,RV],@[AV,IV,BV],@[AV,IV,AV],@[AV,IV,DV],@[AV,IV,FV],
                                                                                                               #@[AV,IV,BIV],@[AV,IV,SV],
                                                                                                               #@[DV,SV,IV],@[DV,SV,RV],@[DV,SV,BV],@[DV,SV,AV],@[DV,SV,DV],@[DV,SV,FV],
                                                                                                               #@[DV,SV,BIV],@[DV,SV,SV],
                                                                                                               #@[SV,IV,SV]],                                                                ret: @[NV],            desc:"set element of array, dictionary or string to given value using index/key",
        SystemFunction(lib:"generic",       name:"set!",                call:Generic_setI),#              req:@[@[AV,IV,IV],@[AV,IV,RV],@[AV,IV,BV],@[AV,IV,AV],@[AV,IV,DV],@[AV,IV,FV],
                                                                                                               #@[AV,IV,BIV],@[AV,IV,SV],
                                                                                                               #@[DV,SV,IV],@[DV,SV,RV],@[DV,SV,BV],@[DV,SV,AV],@[DV,SV,DV],@[DV,SV,FV],
                                                                                                               #@[DV,SV,BIV],@[DV,SV,SV],
                                                                                                               #@[SV,IV,SV]],                                                                ret: @[NV],            desc:"set element of array, dictionary or string to given value using index/key (in-place)",
        SystemFunction(lib:"generic",       name:"size",                call:Generic_size),#              req:@[@[AV],@[SV],@[DV]],                                                          ret: @[IV],             desc:"get size of given collection or string",
        SystemFunction(lib:"generic",       name:"slice",               call:Generic_slice),#             req:@[@[AV,IV],@[AV,IV,IV],@[SV,IV],@[SV,IV,IV]],                                  ret: @[AV,SV],          desc:"get slice of array/string given a starting and/or end point",

        SystemFunction(lib:"io",            name:"read",                call:Io_read),#                   req:@[@[SV]],                                                                      ret: @[SV],             desc:"read string from file at given path",
        SystemFunction(lib:"io",            name:"write",               call:Io_write),#                  req:@[@[SV,SV]],                                                                   ret: @[SV],             desc:"write string to file at given path",

        SystemFunction(lib:"json",          name:"generateJson",        call:Json_generateJson),#         req:@[@[SV],@[IV],@[RV],@[BV],@[AV],@[DV]],                                        ret: @[SV],             desc:"get JSON string from given value",
        SystemFunction(lib:"json",          name:"parseJson",           call:Json_parseJson),#            req:@[@[SV]],                                                                      ret: @[SV,IV,RV,AV,DV], desc:"get object by parsing given JSON string",

        SystemFunction(lib:"logical",       name:"and",                 call:Logical_and),#               req:@[@[BV,BV],@[IV,IV]],                                                          ret: @[BV,IV],          desc:"bitwise/logical AND",
        SystemFunction(lib:"logical",       name:"nand",                call:Logical_nand),#              req:@[@[BV,BV],@[IV,IV]],                                                          ret: @[BV,IV],          desc:"bitwise/logical NAND",
        SystemFunction(lib:"logical",       name:"nor",                 call:Logical_nor),#               req:@[@[BV,BV],@[IV,IV]],                                                          ret: @[BV,IV],          desc:"bitwise/logical NOR",
        SystemFunction(lib:"logical",       name:"not",                 call:Logical_not),#               req:@[@[BV],@[IV]],                                                                ret: @[BV,IV],          desc:"bitwise/logical NOT",
        SystemFunction(lib:"logical",       name:"or",                  call:Logical_or),#                req:@[@[BV,BV],@[IV,IV]],                                                          ret: @[BV,IV],          desc:"bitwise/logical OR",
        SystemFunction(lib:"logical",       name:"xnor",                call:Logical_xnor),#              req:@[@[BV,BV],@[IV,IV]],                                                          ret: @[BV,IV],          desc:"bitwise/logical XNOR",   
        SystemFunction(lib:"logical",       name:"xor",                 call:Logical_xor),#               req:@[@[BV,BV],@[IV,IV]],                                                          ret: @[BV,IV],          desc:"bitwise/logical XOR",   

        SystemFunction(lib:"math",          name:"abs",                 call:Math_abs),#                  req:@[@[IV]],                                                                      ret: @[IV],             desc:"get absolute value from given value",
        SystemFunction(lib:"math",          name:"acos",                call:Math_acos),#                 req:@[@[RV]],                                                                      ret: @[RV],             desc:"get the inverse cosine of given value",
        SystemFunction(lib:"math",          name:"acosh",               call:Math_acosh),#                req:@[@[RV]],                                                                      ret: @[RV],             desc:"get the inverse hyperbolic cosine of given value",
        #SystemFunction(lib:"math",          name:"add",                 call:Math_add),
        #SystemFunction(lib:"math",          name:"add!",                call:Math_addI),
        SystemFunction(lib:"math",          name:"asin",                call:Math_asin),#                 req:@[@[RV]],                                                                      ret: @[RV],             desc:"get the inverse sine of given value",
        SystemFunction(lib:"math",          name:"asinh",               call:Math_asinh),#                req:@[@[RV]],                                                                      ret: @[RV],             desc:"get the inverse hyperbolic sine of given value",
        SystemFunction(lib:"math",          name:"atan",                call:Math_atan),#                 req:@[@[RV]],                                                                      ret: @[RV],             desc:"get the inverse tangent of given value",
        SystemFunction(lib:"math",          name:"atanh",               call:Math_atanh),#                req:@[@[RV]],                                                                      ret: @[RV],             desc:"get the inverse hyperbolic tangent of given value",
        SystemFunction(lib:"math",          name:"avg",                 call:Math_avg),#                  req:@[@[AV]],                                                                      ret: @[RV],             desc:"get average value from given array",
        SystemFunction(lib:"math",          name:"ceil",                call:Math_ceil),#                 req:@[@[RV]],                                                                      ret: @[RV],             desc:"get the smallest number greater than or equal to given value",
        SystemFunction(lib:"math",          name:"cos",                 call:Math_cos),#                  req:@[@[RV]],                                                                      ret: @[RV],             desc:"get the cosine of given value",
        SystemFunction(lib:"math",          name:"cosh",                call:Math_cosh),#                 req:@[@[RV]],                                                                      ret: @[RV],             desc:"get the hyperbolic cosine of given value",
        SystemFunction(lib:"math",          name:"csec",                call:Math_csec),#                 req:@[@[RV]],                                                                      ret: @[RV],             desc:"get the cosecant of given value",
        SystemFunction(lib:"math",          name:"csech",               call:Math_csech),#                req:@[@[RV]],                                                                      ret: @[RV],             desc:"get the hyperbolic cosecant of given value",
        SystemFunction(lib:"math",          name:"ctan",                call:Math_ctan),#                 req:@[@[RV]],                                                                      ret: @[RV],             desc:"get the cotangent of given value",
        SystemFunction(lib:"math",          name:"ctanh",               call:Math_ctanh),#                req:@[@[RV]],                                                                      ret: @[RV],             desc:"get the hyperbolic cotangent of given value",
        #SystemFunction(lib:"math",          name:"div",                 call:Math_div),
        #SystemFunction(lib:"math",          name:"div!",                call:Math_divI),
        SystemFunction(lib:"math",          name:"exp",                 call:Math_exp),#                  req:@[@[RV]],                                                                      ret: @[RV],             desc:"get the exponential the given value",
        SystemFunction(lib:"math",          name:"floor",               call:Math_floor),#                req:@[@[RV]],                                                                      ret: @[RV],             desc:"get the largest number greater than or equal to given value",
        SystemFunction(lib:"math",          name:"gcd",                 call:Math_gcd),#                  req:@[@[AV]],                                                                      ret: @[IV],             desc:"get the greatest common divisor of the values in given array",
        SystemFunction(lib:"math",          name:"inc!",                call:Math_incI),#                  req:@[@[IV],@[BIV]],                                                               ret: @[IV,BIV],         desc:"increase given value by 1",
        SystemFunction(lib:"math",          name:"isEven",              call:Math_isEven),#               req:@[@[IV],@[BIV]],                                                               ret: @[BV],             desc:"check if given number is even",
        SystemFunction(lib:"math",          name:"isOdd",               call:Math_isOdd),#                req:@[@[IV],@[BIV]],                                                               ret: @[BV],             desc:"check if given number is odd",
        SystemFunction(lib:"math",          name:"isPrime",             call:Math_isPrime),#              req:@[@[IV],@[BIV]],                                                               ret: @[BV],             desc:"check if given number is prime",
        SystemFunction(lib:"math",          name:"lcm",                 call:Math_lcm),#                  req:@[@[AV]],                                                                      ret: @[IV],             desc:"get the least common multiple of the values in given array",
        SystemFunction(lib:"math",          name:"ln",                  call:Math_ln),#                   req:@[@[RV]],                                                                      ret: @[RV],             desc:"get the natural logarithm of given value",
        SystemFunction(lib:"math",          name:"log",                 call:Math_log),#                  req:@[@[RV,RV]],                                                                   ret: @[RV],             desc:"get the logarithm of value using given base",
        SystemFunction(lib:"math",          name:"log2",                call:Math_log2),#                 req:@[@[RV]],                                                                      ret: @[RV],             desc:"get the binary (base-2) logarithm of given value",
        SystemFunction(lib:"math",          name:"log10",               call:Math_log10),#                req:@[@[RV]],                                                                      ret: @[RV],             desc:"get the common (base-10) logarithm of given value",
        SystemFunction(lib:"math",          name:"max",                 call:Math_max),#                  req:@[@[AV]],                                                                      ret: @[IV],             desc:"get maximum of the values in given array",
        SystemFunction(lib:"math",          name:"min",                 call:Math_min),#                  req:@[@[AV]],                                                                      ret: @[IV],             desc:"get minimum of the values in given array",
        #SystemFunction(lib:"math",          name:"mul",                 call:Math_mul),
        #SystemFunction(lib:"math",          name:"mul!",                call:Math_mulI),
        SystemFunction(lib:"math",          name:"neg",                 call:Math_neg),
        SystemFunction(lib:"math",          name:"pi",                  call:Math_pi),#                   req:@[@[NV]],                                                                      ret: @[RV],             desc:"get the circle constant PI",
        SystemFunction(lib:"math",          name:"primeFactors",        call:Math_primeFactors),#         req:@[@[IV],@[BIV]],                                                               ret: @[AV],             desc:"get array of prime factors of given number",
        SystemFunction(lib:"math",          name:"product",             call:Math_product),#              req:@[@[AV]],                                                                      ret: @[IV,BIV],         desc:"return product of elements of given array",
        SystemFunction(lib:"math",          name:"random",              call:Math_random),#               req:@[@[IV,IV]],                                                                   ret: @[IV],             desc:"generate random number in given range",
        SystemFunction(lib:"math",          name:"round",               call:Math_round),#                req:@[@[RV]],                                                                      ret: @[RV],             desc:"get given value rounded to the nearest value",
        SystemFunction(lib:"math",          name:"sec",                 call:Math_sec),#                  req:@[@[RV]],                                                                      ret: @[RV],             desc:"get the secant of given value",
        SystemFunction(lib:"math",          name:"sech",                call:Math_sech),#                 req:@[@[RV]],                                                                      ret: @[RV],             desc:"get the hyperbolic secant of given value",
        SystemFunction(lib:"math",          name:"shl",                 call:Math_shl),#                  req:@[@[IV,IV],@[BIV,IV]],                                                         ret: @[IV,BIV],         desc:"shift-left number by given amount of bits",
        SystemFunction(lib:"math",          name:"shr",                 call:Math_shr),#                  req:@[@[IV,IV],@[BIV,IV]],                                                         ret: @[IV,BIV],         desc:"shift-right number by given amount of bits",
        SystemFunction(lib:"math",          name:"sin",                 call:Math_sin),#                  req:@[@[RV]],                                                                      ret: @[RV],             desc:"get the sine of given value",
        SystemFunction(lib:"math",          name:"sinh",                call:Math_sinh),#                 req:@[@[RV]],                                                                      ret: @[RV],             desc:"get the hyperbolic sine of given value",
        SystemFunction(lib:"math",          name:"sqrt",                call:Math_sqrt),#                 req:@[@[RV]],                                                                      ret: @[RV],             desc:"calculate the square root of given value",
        #SystemFunction(lib:"math",          name:"sub",                 call:Math_sub),
        #SystemFunction(lib:"math",          name:"sub!",                call:Math_subI),
        SystemFunction(lib:"math",          name:"sum",                 call:Math_sum),#                  req:@[@[AV]],                                                                      ret: @[IV,BIV],         desc:"return sum of elements of given array",
        SystemFunction(lib:"math",          name:"tan",                 call:Math_tan),#                  req:@[@[RV]],                                                                      ret: @[RV],             desc:"get the tangent of given value",
        SystemFunction(lib:"math",          name:"tanh",                call:Math_tanh),#                 req:@[@[RV]],                                                                      ret: @[RV],             desc:"get the hyperbolic tangent of given value",

        SystemFunction(lib:"net",           name:"download",            call:Net_download),#              req:@[@[SV]],                                                                      ret: @[SV],             desc:"retrieve string contents from webpage using given URL",

        SystemFunction(lib:"path",          name:"absolutePath",        call:Path_absolutePath),#         req:@[@[SV]],                                                                      ret: @[SV],             desc:"get absolute path from given path",
        SystemFunction(lib:"path",          name:"absolutePath!",       call:Path_absolutePathI),#        req:@[@[SV]],                                                                      ret: @[SV],             desc:"get absolute path from given path (in-place)",
        SystemFunction(lib:"path",          name:"copyDir",             call:Path_copyDir),#              req:@[@[SV,SV]],                                                                   ret: @[BV],             desc:"copy directory at path to given destination",
        SystemFunction(lib:"path",          name:"copyFile",            call:Path_copyFile),#             req:@[@[SV,SV]],                                                                   ret: @[BV],             desc:"copy file at path to given destination",
        SystemFunction(lib:"path",          name:"createDir",           call:Path_createDir),#            req:@[@[SV]],                                                                      ret: @[BV],             desc:"create directory at given path",
        SystemFunction(lib:"path",          name:"currentDir",          call:Path_currentDir),#           req:@[@[NV],@[SV]],                                                                ret: @[SV],             desc:"get current directory or set it to given path",
        SystemFunction(lib:"path",          name:"deleteDir",           call:Path_deleteDir),#            req:@[@[SV]],                                                                      ret: @[BV],             desc:"delete directory at given path",
        SystemFunction(lib:"path",          name:"deleteFile",          call:Path_deleteFile),#           req:@[@[SV]],                                                                      ret: @[BV],             desc:"delete file at given path",
        SystemFunction(lib:"path",          name:"dirContent",          call:Path_dirContent),#           req:@[@[SV],@[SV,SV]],                                                             ret: @[AV],             desc:"get directory contents from given path; optionally filtering the results",
        SystemFunction(lib:"path",          name:"dirContents",         call:Path_dirContents),#          req:@[@[SV],@[SV,SV]],                                                             ret: @[AV],             desc:"get directory contents from given path, recursively; optionally filtering the results",
        SystemFunction(lib:"path",          name:"fileCreationTime",    call:Path_fileCreationTime),#     req:@[@[SV]],                                                                      ret: @[SV],             desc:"get creation time of file at given path",
        SystemFunction(lib:"path",          name:"fileExists",          call:Path_fileExists),#           req:@[@[SV]],                                                                      ret: @[BV],             desc:"check if file exists at given path",
        SystemFunction(lib:"path",          name:"fileLastAccess",      call:Path_fileLastAccess),#       req:@[@[SV]],                                                                      ret: @[SV],             desc:"get last access time of file at given path",
        SystemFunction(lib:"path",          name:"fileLastModification",call:Path_fileLastModification),# req:@[@[SV]],                                                                      ret: @[SV],             desc:"get last modification time of file at given path",
        SystemFunction(lib:"path",          name:"fileSize",            call:Path_fileSize),#             req:@[@[SV]],                                                                      ret: @[IV],             desc:"get size of file at given path in bytes",
        SystemFunction(lib:"path",          name:"dirExists",           call:Path_dirExists),#            req:@[@[SV]],                                                                      ret: @[BV],             desc:"check if directory exists at given path",
        SystemFunction(lib:"path",          name:"moveDir",             call:Path_moveDir),#              req:@[@[SV,SV]],                                                                   ret: @[BV],             desc:"move directory at path to given destination",
        SystemFunction(lib:"path",          name:"moveFile",            call:Path_moveFile),#             req:@[@[SV,SV]],                                                                   ret: @[BV],             desc:"move file at path to given destination",
        SystemFunction(lib:"path",          name:"normalizePath",       call:Path_normalizePath),#        req:@[@[SV]],                                                                      ret: @[SV],             desc:"normalize given path",
        SystemFunction(lib:"path",          name:"normalizePath!",      call:Path_normalizePathI),#       req:@[@[SV]],                                                                      ret: @[SV],             desc:"normalize given path (in-place)",
        SystemFunction(lib:"path",          name:"pathDir",             call:Path_pathDir),#              req:@[@[SV]],                                                                      ret: @[SV],             desc:"retrieve directory component from given path",
        SystemFunction(lib:"path",          name:"pathExtension",       call:Path_pathExtension),#        req:@[@[SV]],                                                                      ret: @[SV],             desc:"retrieve extension component from given path",
        SystemFunction(lib:"path",          name:"pathFilename",        call:Path_pathFilename),#         req:@[@[SV]],                                                                      ret: @[SV],             desc:"retrieve filename component from given path",
        SystemFunction(lib:"path",          name:"symlinkExists",       call:Path_symlinkExists),#        req:@[@[SV]],                                                                      ret: @[BV],             desc:"check if symlink exists at given path",

        SystemFunction(lib:"reflection",    name:"inspect",             call:Reflection_inspect),#        req:@[@[SV],@[AV],@[IV],@[BIV],@[FV],@[BV],@[RV],@[DV]],                           ret: @[SV],             desc:"print given value to screen in a readable format",
        SystemFunction(lib:"reflection",    name:"isArray",             call:Reflection_isArray),
        SystemFunction(lib:"reflection",    name:"isBigint",            call:Reflection_isBigint),
        SystemFunction(lib:"reflection",    name:"isBool",              call:Reflection_isBool),
        SystemFunction(lib:"reflection",    name:"isDict",              call:Reflection_isDict),
        SystemFunction(lib:"reflection",    name:"isFunc",              call:Reflection_isFunc),
        SystemFunction(lib:"reflection",    name:"isNull",              call:Reflection_isNull),
        SystemFunction(lib:"reflection",    name:"isReal",              call:Reflection_isReal),
        SystemFunction(lib:"reflection",    name:"isString",            call:Reflection_isString),
        SystemFunction(lib:"reflection",    name:"type",                call:Reflection_type),#           req:@[@[SV],@[AV],@[IV],@[BIV],@[FV],@[BV],@[RV],@[DV]],                           ret: @[SV],             desc:"get type of given object as a string",

        SystemFunction(lib:"set",           name:"difference",          call:Set_difference),
        SystemFunction(lib:"set",           name:"intersection",        call:Set_intersection),
        SystemFunction(lib:"set",           name:"symmetricDifference", call:Set_symmetricDifference),
        SystemFunction(lib:"set",           name:"union",               call:Set_union),

        SystemFunction(lib:"string",        name:"capitalize",          call:String_capitalize),#         req:@[@[SV]],                                                                      ret: @[SV],             desc:"capitalize given string",
        SystemFunction(lib:"string",        name:"capitalize!",         call:String_capitalizeI),#        req:@[@[SV]],                                                                      ret: @[SV],             desc:"capitalize given string (in-place)",
        SystemFunction(lib:"string",        name:"char",                call:String_char),#               req:@[@[IV]],                                                                      ret: @[SV],             desc:"get ASCII character from given char code",
        SystemFunction(lib:"string",        name:"chars",               call:String_chars),#              req:@[@[SV]],                                                                      ret: @[AV],             desc:"get string characters as an array",
        SystemFunction(lib:"string",        name:"deletePrefix",        call:String_deletePrefix),#       req:@[@[SV,SV]],                                                                   ret: @[SV],             desc:"get string by deleting given prefix",
        SystemFunction(lib:"string",        name:"deletePrefix!",       call:String_deletePrefixI),#      req:@[@[SV,SV]],                                                                   ret: @[SV],             desc:"get string by deleting given prefix (in-place)",
        SystemFunction(lib:"string",        name:"deleteSuffix",        call:String_deleteSuffix),#       req:@[@[SV,SV]],                                                                   ret: @[SV],             desc:"get string by deleting given suffix",
        SystemFunction(lib:"string",        name:"deleteSuffix!",       call:String_deleteSuffixI),#      req:@[@[SV,SV]],                                                                   ret: @[SV],             desc:"get string by deleting given suffix (in-place)",
        SystemFunction(lib:"string",        name:"distance",            call:String_distance),#           req:@[@[SV,SV]],                                                                   ret: @[IV],             desc:"get Levenshtein distance between given strings",
        SystemFunction(lib:"string",        name:"endsWith",            call:String_endsWith),#           req:@[@[SV,SV]],                                                                   ret: @[BV],             desc:"check if string ends with given string/regex",
        SystemFunction(lib:"string",        name:"isAlpha",             call:String_isAlpha),#            req:@[@[SV]],                                                                      ret: @[BV],             desc:"check if all characters in given string are ASCII letters",
        SystemFunction(lib:"string",        name:"isAlphaNumeric",      call:String_isAlphaNumeric),#     req:@[@[SV]],                                                                      ret: @[BV],             desc:"check if all characters in given string are ASCII letters or digits",
        SystemFunction(lib:"string",        name:"isLowercase",         call:String_isLowercase),#        req:@[@[SV]],                                                                      ret: @[BV],             desc:"check if all characters in given string are lowercase",
        SystemFunction(lib:"string",        name:"isNumber",            call:String_isNumber),#           req:@[@[SV]],                                                                      ret: @[BV],             desc:"check if given string is a number",
        SystemFunction(lib:"string",        name:"isUppercase",         call:String_isUppercase),#        req:@[@[SV]],                                                                      ret: @[BV],             desc:"check if all characters in given string are uppercase",
        SystemFunction(lib:"string",        name:"isWhitespace",        call:String_isWhitespace),#       req:@[@[SV]],                                                                      ret: @[BV],             desc:"check if all characters in given string are whitespace",
        SystemFunction(lib:"string",        name:"join",                call:String_join),#               req:@[@[AV],@[AV,SV]],                                                             ret: @[SV],             desc:"join strings in given array, optionally using separator",
        SystemFunction(lib:"string",        name:"lines",               call:String_lines),#              req:@[@[SV]],                                                                      ret: @[AV],             desc:"get lines from string as an array",
        SystemFunction(lib:"string",        name:"lowercase",           call:String_lowercase),#          req:@[@[SV]],                                                                      ret: @[SV],             desc:"lowercase given string",
        SystemFunction(lib:"string",        name:"lowercase!",          call:String_lowercaseI),#         req:@[@[SV]],                                                                      ret: @[SV],             desc:"lowercase given string (in-place)",
        SystemFunction(lib:"string",        name:"matches",             call:String_matches),#            req:@[@[SV,SV]],                                                                   ret: @[AV],             desc:"get array of matches from string using given string/regex",
        SystemFunction(lib:"string",        name:"padCenter",           call:String_padCenter),#          req:@[@[SV,IV]],                                                                   ret: @[SV],             desc:"center-justify string by adding given padding",
        SystemFunction(lib:"string",        name:"padCenter!",          call:String_padCenterI),#         req:@[@[SV,IV]],                                                                   ret: @[SV],             desc:"center-justify string by adding given padding (in-place)",
        SystemFunction(lib:"string",        name:"padLeft",             call:String_padLeft),#            req:@[@[SV,IV]],                                                                   ret: @[SV],             desc:"left-justify string by adding given padding",
        SystemFunction(lib:"string",        name:"padLeft!",            call:String_padLeftI),#           req:@[@[SV,IV]],                                                                   ret: @[SV],             desc:"left-justify string by adding given padding (in-place)",
        SystemFunction(lib:"string",        name:"padRight",            call:String_padRight),#           req:@[@[SV,IV]],                                                                   ret: @[SV],             desc:"right-justify string by adding given padding",
        SystemFunction(lib:"string",        name:"padRight!",           call:String_padRightI),#          req:@[@[SV,IV]],                                                                   ret: @[SV],             desc:"right-justify string by adding given padding (in-place)",
        SystemFunction(lib:"string",        name:"replace",             call:String_replace),#            req:@[@[SV,SV,SV]],                                                                ret: @[SV],             desc:"get string by replacing occurences of string/regex with given replacement",
        SystemFunction(lib:"string",        name:"replace!",            call:String_replaceI),#           req:@[@[SV,SV,SV]],                                                                ret: @[SV],             desc:"get string by replacing occurences of string/regex with given replacement (in-place)",
        SystemFunction(lib:"string",        name:"split",               call:String_split),#              req:@[@[SV,SV]],                                                                   ret: @[AV],             desc:"split string to array by given string/regex separator",
        SystemFunction(lib:"string",        name:"startsWith",          call:String_startsWith),#         req:@[@[SV,SV]],                                                                   ret: @[BV],             desc:"check if string starts with given string/regex",
        SystemFunction(lib:"string",        name:"strip",               call:String_strip),#              req:@[@[SV]],                                                                      ret: @[SV],             desc:"remove leading and trailing whitespace from given string",
        SystemFunction(lib:"string",        name:"strip!",              call:String_stripI),#             req:@[@[SV]],                                                                      ret: @[SV],             desc:"remove leading and trailing whitespace from given string (in-place)",
        SystemFunction(lib:"string",        name:"uppercase",           call:String_uppercase),#          req:@[@[SV]],                                                                      ret: @[SV],             desc:"uppercase given string",
        SystemFunction(lib:"string",        name:"uppercase!",          call:String_uppercaseI),#         req:@[@[SV]],                                                                      ret: @[SV],             desc:"uppercase given string (in-place)",

        SystemFunction(lib:"terminal",      name:"clear",               call:Terminal_clear),#            req:@[@[NV]],                                                                      ret: @[NV],             desc:"clear screen and move cursor to home",
        SystemFunction(lib:"terminal",      name:"input",               call:Terminal_input),#            req:@[@[NV]],                                                                      ret: @[SV],             desc:"read line from stdin",
        SystemFunction(lib:"terminal",      name:"inputChar",           call:Terminal_inputChar),#        req:@[@[NV]],                                                                      ret: @[SV],             desc:"read character from terminal, without being printed",
        SystemFunction(lib:"terminal",      name:"print",               call:Terminal_print),#            req:@[@[SV],@[AV],@[IV],@[BIV],@[FV],@[BV],@[RV],@[DV]],                           ret: @[SV],             desc:"print given value to screen",
        SystemFunction(lib:"terminal",      name:"prints",              call:Terminal_prints),#           req:@[@[SV],@[AV],@[IV],@[BIV],@[FV],@[BV],@[RV],@[DV]],                           ret: @[SV],             desc:"print given value to screen without newline",
        SystemFunction(lib:"terminal",      name:"shell",               call:Terminal_shell),#            req:@[@[SV]],                                                                      ret: @[SV],             desc:"execute given shell command and get string output",

        SystemFunction(lib:"time",          name:"benchmark",           call:Time_benchmark),#            req:@[@[FV]],                                                                      ret: @[IV],             desc:"time the execution of a given function in seconds",
        SystemFunction(lib:"time",          name:"datetime",            call:Time_datetime),#             req:@[@[SV],@[SV,SV],@[IV],@[IV,SV]],                                              ret: @[IV,SV],          desc:"get timestamp from given datetime string (dd-MM-yyyy HH:mm:ss), or string from given timestamp, optionally using a different format",
        SystemFunction(lib:"time",          name:"day",                 call:Time_day),#                  req:@[@[IV]],                                                                      ret: @[SV],             desc:"get day of the week for given timestamp",
        SystemFunction(lib:"time",          name:"dayOfMonth",          call:Time_dayOfMonth),#           req:@[@[IV]],                                                                      ret: @[IV],             desc:"get day of the month for given timestamp",
        SystemFunction(lib:"time",          name:"dayOfYear",           call:Time_dayOfYear),#            req:@[@[IV]],                                                                      ret: @[IV],             desc:"get day of the year for given timestamp",
        SystemFunction(lib:"time",          name:"delay",               call:Time_delay),#                req:@[@[IV]],                                                                      ret: @[IV],             desc:"create system delay for given duration in milliseconds",
        SystemFunction(lib:"time",          name:"hours",               call:Time_hours),#                req:@[@[IV]],                                                                      ret: @[IV],             desc:"get hours component from given timestamp",
        SystemFunction(lib:"time",          name:"minutes",             call:Time_minutes),#              req:@[@[IV]],                                                                      ret: @[IV],             desc:"get minutes component from given timestamp",
        SystemFunction(lib:"time",          name:"month",               call:Time_month),#                req:@[@[IV]],                                                                      ret: @[SV],             desc:"get month from given timestamp",
        SystemFunction(lib:"time",          name:"now",                 call:Time_now),#                  req:@[@[NV]],                                                                      ret: @[IV],             desc:"get current timestamp",
        SystemFunction(lib:"time",          name:"seconds",             call:Time_seconds),#              req:@[@[IV]],                                                                      ret: @[IV],             desc:"get seconds component from given timestamp",

        SystemFunction(lib:"url",           name:"decodeUrl",           call:Url_decodeUrl),#             req:@[@[SV]],                                                                      ret: @[SV],             desc:"decode given URL",
        SystemFunction(lib:"url",           name:"decodeUrl!",          call:Url_decodeUrlI),#            req:@[@[SV]],                                                                      ret: @[SV],             desc:"decode given URL (in-place)",
        SystemFunction(lib:"url",           name:"encodeUrl",           call:Url_encodeUrl),#             req:@[@[SV]],                                                                      ret: @[SV],             desc:"encode given URL",
        SystemFunction(lib:"url",           name:"encodeUrl!",          call:Url_encodeUrlI),#            req:@[@[SV]],                                                                      ret: @[SV],             desc:"encode given URL (in-place)",
        SystemFunction(lib:"url",           name:"isAbsoluteUrl",       call:Url_isAbsoluteUrl),#         req:@[@[SV]],                                                                      ret: @[BV],             desc:"check if given URL is absolute",
        SystemFunction(lib:"url",           name:"urlAnchor",           call:Url_urlAnchor),#             req:@[@[SV]],                                                                      ret: @[SV],             desc:"get anchor component of given URL",
        SystemFunction(lib:"url",           name:"urlComponents",       call:Url_urlComponents),#         req:@[@[SV]],                                                                      ret: @[DV],             desc:"get all components from given URL",
        SystemFunction(lib:"url",           name:"urlHost",             call:Url_urlHost),#               req:@[@[SV]],                                                                      ret: @[SV],             desc:"get host component from given URL",
        SystemFunction(lib:"url",           name:"urlPassword",         call:Url_urlPassword),#           req:@[@[SV]],                                                                      ret: @[SV],             desc:"get password component from given URL",
        SystemFunction(lib:"url",           name:"urlPath",             call:Url_urlPath),#               req:@[@[SV]],                                                                      ret: @[SV],             desc:"get path from given URL",
        SystemFunction(lib:"url",           name:"urlPort",             call:Url_urlPort),#               req:@[@[SV]],                                                                      ret: @[SV],             desc:"get port component from given URL",
        SystemFunction(lib:"url",           name:"urlQuery",            call:Url_urlQuery),#              req:@[@[SV]],                                                                      ret: @[SV],             desc:"get query part from given URL",
        SystemFunction(lib:"url",           name:"urlScheme",           call:Url_urlScheme),#             req:@[@[SV]],                                                                      ret: @[SV],             desc:"get scheme part from given URL",
        SystemFunction(lib:"url",           name:"urlUser",             call:Url_urlUser)#               req:@[@[SV]],                                                                      ret: @[SV],             desc:"get username component from given URL")
    ]

    #---------------------------
    # Command constants
    #---------------------------

    EXEC_CMD    =   cint(getSystemFunction("exec"))
    GET_CMD     =   cint(getSystemFunction("get"))
    RANGE_CMD   =   cint(getSystemFunction("range"))
    SET_CMD     =   cint(getSystemFunction("set!"))