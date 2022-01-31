# TODO(nimble) cleanup nimble file
#  the file is not currently working: either clean it up and make sure it *is* working, or remote it completely to avoid confusion
#  labels: installer,cleanup
######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2020 Arturo Contributors
# (c) 2022 Yanis Zafirópulos
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
