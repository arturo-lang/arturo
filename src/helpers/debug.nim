######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/debug.nim
######################################################

# TODO(Helpers/debug) To be completely removed?
#  It looks totally silly to have a whole module only with one function in it, used to print 2 - albeit stylish - lines and a string...
#  labels: helpers, cleanup

#=======================================
# Methods
#=======================================

proc showDebugHeader*(title: string) =
    echo "======================================================="
    echo "== " & title
    echo "======================================================="
