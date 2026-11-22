#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: extras/wasi.nim
#=======================================================

## Stand-ins for whatever POSIX bits WASI doesn't
## provide, but Nim's stdlib expects

{.compile: "wasi/stubs.c".}
