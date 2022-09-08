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

template printProfilerHeader*() =
    echo ""
    echo fg(magentaColor) & center("→ PROFILER ←", 57) & resetColor()
    echo ""

template printProfilerDataTable*(what: string) =
    printProfilerHeader(what)
    var maxTitle = 0
    for (title, _) in pairs(PR[what]):
        if len(title) > maxTitle:
            maxTitle = len(title)

    PR[what].sort((a, b) => cmp(a[1].time / a[1].runs, b[1].time / b[1].runs), SortOrder.Descending)

    echo " " & alignLeft("ID", maxTitle+10) & "| " & alignLeft("Time/Run (μs)",15) & " | Runs"
    echo "=========================================================".replace("=","-")

    for (title, row) in pairs(PR[what]):
        var timePerRun{.inject.} = (row.time / row.runs / 1_000)
        echo " " & alignLeft(title, maxTitle+10) & "| " & 
                 fg(grayColor) & alignLeft(fmt"{timePerRun:.2f}",15) & resetColor() & "| " & 
                 fg(grayColor) & $row.runs & resetColor()

    echo ""

template hookFunctionProfiler*(name: string, actionContent: untyped): untyped =
    when defined(PROFILER):
        var newRow = addMetricIfNotExists(name, "functions")
        newRow.runs += 1
        newRow.time += getMetric(actionContent)
    else:
        actionContent

template hookOpProfiler*(name: string, actionContent: untyped): untyped =
    when defined(PROFILER):
        var newRow = addMetricIfNotExists(name, "ops")
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
        printProfilerHeader()
        printProfilerDataTable("functions")
        printProfilerDataTable("ops")
    else:
        discard