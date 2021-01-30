######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: helpers/datasource.nim
######################################################

#=======================================
# Libraries
#=======================================

import vm/value
import utils

#=======================================
# Methods
#=======================================

proc printInfo*(n: string, v: Value) =
    echo "printing info"