#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: extras/web/times.nim
#=======================================================

# `std/times` for Web builds: the very same module (copied 
# from the stdlib by config.nims), only compiled with range 
# & overflow checks on - without them, Nim's JS backend 
# produces broken code for it

{.push rangeChecks: on, overflowChecks: on.}
include "../../../.cache/web/stdtimes"
{.pop.}
