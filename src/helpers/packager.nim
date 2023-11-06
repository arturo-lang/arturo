#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: helpers/packager.nim
#=======================================================

#=======================================
# Libraries
#=======================================

# import algorithm, bitops, std/math, sequtils, sugar

# when defined(WEB):
#     import std/jsbigints
# elif not defined(NOGMP):
#     import helpers/bignums as BignumsHelper

# when defined(NOGMP):
#     import vm/errors
    
# import vm/values/value

#=======================================
# Methods
#=======================================

# func addmod*[T: SomeInteger](a, b, modulus: T): T =
#     let a_m = if a < modulus: a else: a mod modulus
#     if b == 0.T: return a_m
#     let b_m = if b < modulus: b else: b mod modulus
 
#     let b_from_m = modulus - b_m
#     if a_m >= b_from_m: return a_m - b_from_m
#     return a_m + b_m 
