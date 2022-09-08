######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/profiler.nim
######################################################

#=======================================
# Libraries
#=======================================

import tables

#=======================================
# Types
#=======================================

type
    ProfilerDataRow* = ref object
        time*: int
        runs*: int

    ProfilerDataTable* = OrderedTable[string, ProfilerDataRow]

    ProfilerData* = ref object
        ops*: ProfilerDataRow
        procs*: ProfilerDataRow

#=======================================
# Variables
#=======================================

var
    PR*: ProfilerData

#=======================================
# Forward declarations
#=======================================

#=======================================
# Templates
#=======================================

#=======================================
# Helpers
#=======================================

#=======================================
# Methods
#=======================================
