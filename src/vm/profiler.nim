######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/profiler.nim
######################################################

when defined(PROFILER):

    #=======================================
    # Libraries
    #=======================================

    import algorithm, std/monotimes, strformat
    import strutils, sugar, tables, times

    import helpers/terminal

    #=======================================
    # Types
    #=======================================

    type
        ProfilerDataRow* = ref object
            time*: int
            runs*: int

        ProfilerDataTable* = OrderedTable[string, ProfilerDataRow]

    #=======================================
    # Variables
    #=======================================

    var
        PR*: OrderedTable[string, ProfilerDataTable]

#=======================================
# Helpers
#=======================================

when defined(PROFILER):
    proc printProfilerHeader*(what: string) =
        echo fg(cyanColor) &
             "========================================================="
        echo " " & what.toUpperAscii
        echo "=========================================================" & resetColor()

#=======================================
# Templates
#=======================================

template getMetric*(actionContent: untyped): int =
    let t0 = getMonoTime()
    actionContent
    (int)(ticks(getMonoTime()) - ticks(t0))

template addMetricIfNotExists*(name: string, metric: untyped): untyped =
    if not PR[metric].hasKey(name):
        PR[metric][name] = ProfilerDataRow(time:0, runs:0)
    PR[metric][name]

template printProfilerDataTable*(what: string) =
    printProfilerHeader(what)
    var maxTitle = 0
    for (title, _) in pairs(PR[what]):
        if len(title) > maxTitle:
            maxTitle = len(title)


    PR[what].sort((a, b) => cmp(a[1].time / a[1].runs, b[1].time / b[1].runs), SortOrder.Descending)

    for (title, row) in pairs(PR[what]):
        var timePerRun{.inject.} = (row.time / row.runs / 1_000)
        echo alignLeft(title, maxTitle+10) & "| " & alignLeft(fmt"{timePerRun:.2f}μs",15) & "|" & $row.runs

template hookFunctionProfiler*(name: string, actionContent: untyped): untyped =
    when defined(PROFILER):
        var newRow = addMetricIfNotExists(name, "functions")
        newRow.runs += 1
        newRow.time += getMetric(actionContent)
    else:
        actionContent


#=======================================
# Methods
#=======================================

proc initProfiler*() =
    when defined(PROFILER):
        PR = {
            "ops": initOrderedTable[string, ProfilerDataRow](),
            "procs": initOrderedTable[string, ProfilerDataRow](),
            "functions": initOrderedTable[string, ProfilerDataRow]()
        }.toOrderedTable
    else:
        discard

proc showProfilerData*() =
    when defined(PROFILER):
        printProfilerDataTable("functions")
    else:
        discard