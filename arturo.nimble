######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2020 Arturo Contributors
#
# @file: arturo.nimble
######################################################

# Package

version       = "0.9.4"
author        = "arturo-lang"
description   = "Simple, modern and portable interpreted programming language for efficient scripting"
license       = "MIT"
srcDir        = "src"
bin           = @["arturo"]
binDir        = "bin"

# Dependencies

requires "nim >= 1.4.0"
