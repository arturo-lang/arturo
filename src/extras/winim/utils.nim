#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

##  This module contains utilities for happily coding in winim.

{.deadCodeElim: on.}

import inc/windef

# todo: need more converter?

converter winimConverterBooleanToBOOL*(x: bool): BOOL =
  ## Converter between Windows' BOOL/WINBOOL and Nim's boolean type

  result = if x: TRUE else: FALSE

converter winimConverterBOOLToBoolean*(x: BOOL): bool =
  ## Converter between Windows' BOOL/WINBOOL and Nim's boolean type

  result = if x == FALSE: false else: true

converter winimConverterVarObjectToPtrObject*[T: object](x: var T): ptr T =
  ## Pass an object by address if target is "ptr object". For example:
  ##
  ## .. code-block:: Nim
  ##    var msg: MSG
  ##    while GetMessage(msg, 0, 0, 0) != 0:
  ##      TranslateMessage(msg)
  ##      DispatchMessage(msg)

  result = x.addr

proc `&`*[T](x: var T): ptr T {.inline.} =
  ## Use `&` like it in C/C++ to get address for anything.

  result = x.addr

when not compiles(unsafeaddr GUID_NULL):
  proc `&`*(x: object): ptr type(x) {.importc: "&", nodecl.}
    ## Use `&` to gets pointer for const object. For example:
    ##
    ## .. code-block:: Nim
    ##    # pUk is "ptr IUnknown" for some object
    ##    var pDisp: ptr IDispatch
    ##    pUk.QueryInterface(&IID_IDispatch, &pDisp)

else:
  template `&`*(x: object): ptr type(x) = unsafeaddr x
    ## Use `&` to gets pointer for const object. For example:
    ##
    ## .. code-block:: Nim
    ##    # pUk is "ptr IUnknown" for some object
    ##    var pDisp: ptr IDispatch
    ##    pUk.QueryInterface(&IID_IDispatch, &pDisp)
