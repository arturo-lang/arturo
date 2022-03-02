#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

##  This module contains Windows API, struct, and constant definitions.
##  The definitions are translated from MinGW's Windows headers.
##
##  The module also include some windows string type utilities and COM support.
##  See utils.nim, winstr.nim, and com.nim for details.
##
##  Usage:
##    .. code-block:: Nim
##       import winim # impore all modules, except COM support
##       import winim/lean # for core SDK only
##       import winim/mean # for core SDK + Shell + OLE
##       import winim/com # for core SDK + Shell + OLE + COM support
##
##  To compile:
##    .. code-block:: Nim
##       nim c source.nim
##         add -d:winansi or -d:useWinAnsi for Ansi version (Unicode by default).
##         add -d:noDiscardableApi if not like discardable windows API.
##         add -d:noRes to disable the visual styles (not to link winim32.res or winim64.res).
##         add -d:lean same as import winim/lean.
##         add -d:mean or -d:win32_lean_and_mean same as import winim/mean.
##         add -d:notrace disable COM objects trace. See com.nim for details.

{.deadCodeElim: on.}

when defined(lean):
  import winim/[core]
  export core
elif defined(mean) or defined(win32_lean_and_mean):
  import winim/[core, shell, ole]
  export core, shell, ole
else:
  import winim/[core, shell, net, ole, extra]
  export core, shell, net, ole, extra

import winim/[utils, winstr]
export utils, winstr
