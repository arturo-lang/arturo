######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2020 Arturo Contributors
# (c) 2021 Yanis Zafirópulos
#
# @file: arturo.nimble
######################################################

# Package

version       = static readFile("version/version")
author        = "Yanis Zafirópulos"
description   = "Simple, modern and portable interpreted programming language for efficient scripting"
license       = "MIT"
srcDir        = "src"
bin           = @["arturo"]
binDir        = "bin"

# Dependencies

requires "nim >= 1.4.0"
