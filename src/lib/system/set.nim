#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/set.nim
  * @description: Array/Set manipulation
  *****************************************************************]#

#[######################################################
    Functions
  ======================================================]#

proc Set_difference*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = A(VALID(0,AV)).toHashSet
    let v1 = A(VALID(1,AV)).toHashSet

    result = ARR(v0.difference(v1).toSeq)

proc Set_intersection*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = A(VALID(0,AV)).toHashSet
    let v1 = A(VALID(1,AV)).toHashSet

    result = ARR(v0.intersection(v1).toSeq)

proc Set_symmetricDifference*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = A(VALID(0,AV)).toHashSet
    let v1 = A(VALID(1,AV)).toHashSet

    result = ARR(v0.symmetricDifference(v1).toSeq)

proc Set_union*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = A(VALID(0,AV)).toHashSet
    let v1 = A(VALID(1,AV)).toHashSet

    result = ARR(v0.union(v1).toSeq)

#[******************************************************
  ******************************************************
    UnitTests
  ******************************************************
  ******************************************************]#

# when defined(unittest):

#     suite "Library: system/set":

#         test "all":
#             check(eq( callFunction("all",@[ARR(@[TRUE,TRUE,TRUE])]), TRUE ))
#             check(eq( callFunction("all",@[ARR(@[TRUE,TRUE,FALSE])]), FALSE ))

#         test "any":
#             check(eq( callFunction("any",@[ARR(@[TRUE,TRUE,TRUE])]), TRUE ))
#             check(eq( callFunction("any",@[ARR(@[TRUE,TRUE,FALSE])]), TRUE ))
#             check(eq( callFunction("any",@[ARR(@[FALSE,FALSE,FALSE])]), FALSE ))
