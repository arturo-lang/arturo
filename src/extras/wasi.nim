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

import os

# WASI has no notion of a current directory: wasi-libc
# always starts at `/`. So, if we've been given one
# (e.g. `wasmtime run --dir /::/ --env PWD ...`),
# let's start from there - like we would natively
if existsEnv("PWD"):
    try: setCurrentDir(getEnv("PWD"))
    except OSError: discard
