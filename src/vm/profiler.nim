######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/profiler.nim
######################################################

# Contains code (mainly the call tree tracer) based on
# the Nimprof module: https://github.com/nim-lang/Nim/blob/version-1-6/lib/pure/nimprof.nim
# which forms part of the Nim standard library.
# (c) Copyright 2015 Andreas Rumpf

when defined(PROFILER):
    {.push profiler: off.}

    #=======================================
    # Libraries
    #=======================================

    import algorithm, hashes, std/monotimes, sets
    import strformat, strutils, sugar, tables, times

    import helpers/terminal

    include "system/timers"

    #=======================================
    # Types
    #=======================================

    type
        ProfilerDataRow* = ref object
            time*: int
            runs*: int

        ProfilerDataTable* = OrderedTable[string, ProfilerDataRow]

        ProfileEntry = object
            total: int
            st: StackTrace
        ProfileData = array[0..64*1024-1, ptr ProfileEntry]

    #=======================================
    # Constants
    #=======================================

    const
        ProfilerLine*       = "======================================================================================================="
        ProfilerLineLen*    = len(ProfilerLine)

        withThreads         = compileOption("threads")
        tickCountCorrection = 50_000

    #=======================================
    # Variables
    #=======================================

    var
        PR*                     : OrderedTable[string, ProfilerDataTable]

        profileData             : ProfileData
        emptySlots              = profileData.len * 3 div 2
        maxChainLen             = 0
        totalCalls              = 0
        interval                : Nanos = 5_000_000 - tickCountCorrection
        hook_t0 {.threadvar.}   : Ticks
        hook_gTicker            : int

#=======================================
# Helpers
#=======================================

when defined(PROFILER):

    when withThreads:
        import locks
        var
            profilingLock: Lock

        initLock profilingLock

    proc hookAux(st: StackTrace, costs: int) =
        when withThreads: 
            acquire profilingLock
  
        inc totalCalls
        var last = high(st.lines)
        while last > 0 and isNil(st[last]): dec last
        var h = hash(pointer(st[last])) and high(profileData)

        if emptySlots == 0:
            var minIdx = h
            var probes = maxChainLen
            while probes >= 0:
                if profileData[h].st == st:
                    inc profileData[h].total, costs
                    return
                if profileData[minIdx].total < profileData[h].total:
                    minIdx = h
                h = ((5 * h) + 1) and high(profileData)
                dec probes
            profileData[minIdx].total = costs
            profileData[minIdx].st = st
        else:
            var chain = 0
            while true:
                if profileData[h] == nil:
                    profileData[h] = cast[ptr ProfileEntry](allocShared0(sizeof(ProfileEntry)))
                    profileData[h].total = costs
                    profileData[h].st = st
                    dec emptySlots
                    break
                if profileData[h].st == st:
                    inc profileData[h].total, costs
                    break
                h = ((5 * h) + 1) and high(profileData)
                inc chain
            maxChainLen = max(maxChainLen, chain)

        when withThreads: 
            release profilingLock

    proc requestedHook(): bool {.locks: 0.} =
        if interval == 0: result = true
        elif hook_gTicker == 0:
            hook_gTicker = 500
            if getTicks() - hook_t0 > interval:
                result = true
        else:
            dec hook_gTicker

    proc hook(st: StackTrace) {.locks: 0.} =
        if interval == 0:
            hookAux(st, 1)
        else:
            hookAux(st, 1)
            hook_t0 = getTicks()

    proc getTotal(x: ptr ProfileEntry): int =
        result = if isNil(x): 0 else: x.total

    proc cmpEntries(a, b: ptr ProfileEntry): int =
        result = b.getTotal - a.getTotal

    proc `//`(a, b: int): string =
        result = format("$1/$2 = $3%", a, b, formatFloat(a / b * 100.0, ffDecimal, 2))

    proc printProfilerHeader*(what: string) =
        echo fg(cyanColor) & ProfilerLine
        echo " " & what.toUpperAscii
        echo ProfilerLine & resetColor()

    proc printProfilerCallTree*() {.noconv.} =
        printProfilerHeader("call tree")

        system.profilingRequestedHook = nil
        when declared(system.StackTrace):
            system.profilerHook = nil

        sort(profileData, cmpEntries)
        var entries = 0
        for i in 0..high(profileData):
            if profileData[i] != nil: 
                inc entries

        var perProc = initCountTable[string]()
        for i in 0..entries-1:
            var dups = initHashSet[string]()
            for ii in 0..high(StackTrace.lines):
                let procname = profileData[i].st[ii]
                if isNil(procname): 
                    break
                let p = $procname
                if not containsOrIncl(dups, p):
                    perProc.inc(p, profileData[i].total)

        var sum = 0
        for i in 0..min(100, entries-1):
            if profileData[i].total >= 1:
                inc sum, profileData[i].total

                echo alignLeft(fmt" Entry: {i+1}/{entries} Calls: {profileData[i].total // totalCalls}", ProfilerLineLen-27) & "|" & fmt"{sum}>" & fg(grayColor) & align(fmt"{sum // totalCalls}", 23) & resetColor()

                for ii in 0..high(StackTrace.lines):
                    let procname = profileData[i].st[ii]
                    let filename = profileData[i].st.files[ii]
                    if isNil(procname): break

                    echo "\t" & alignLeft(fmt"{filename}: {procname}",ProfilerLineLen-35) & "| " & fg(grayColor) & align(fmt"{perProc[$procname] // totalCalls}", 24) & resetColor()
        echo ""

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
    echo fg(magentaColor) & center("→ PROFILER ←", ProfilerLineLen) & resetColor()
    echo ""

template printProfilerDataTable*(what: string) =
    printProfilerHeader(what)
    var totalImpact = 0

    var maxTitle = 0
    for (title, row) in pairs(PR[what]):
        if len(title) > maxTitle:
            maxTitle = len(title)
        totalImpact += row.time

    PR[what].sort((a, b) => cmp(a[1].time, b[1].time), SortOrder.Descending)

    echo " " & alignLeft("ID", maxTitle+10) & "| " & 
               alignLeft("Time/Run (μs)",15) & " | " & 
               alignLeft("Runs",15) & "| " & 
               alignLeft("Total Time (ms)",20) & "| " &
               "Impact (%)"
    echo ProfilerLine.replace("=","-")

    for (title, row) in pairs(PR[what]):
        var timePerRun{.inject.} = (row.time / row.runs / 1_000)
        var relImpact{.inject.} = (row.time / totalImpact) * 100
        var totalTime{.inject.} = row.time / 1_000_000
        echo " " & alignLeft(title, maxTitle+10) & "| " & 
                 fg(grayColor) & alignLeft(fmt"{timePerRun:.2f}",15) & resetColor() & "| " & 
                 fg(grayColor) & alignLeft($row.runs,15) & resetColor() & "| " & 
                 fg(grayColor) & alignLeft(fmt"{totalTime:.2f}",20) & resetColor() & "| " &
                 fg(grayColor) & fmt"{relImpact:.2f}" & resetColor() &
                 resetColor()

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

template hookProcProfiler*(name: string, actionContent: untyped): untyped =
    when defined(PROFILER):
        var newRow = addMetricIfNotExists(name, "procs")
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
            "functions": initOrderedTable[string, ProfilerDataRow](),
            "ops": initOrderedTable[string, ProfilerDataRow](),
            "procs": initOrderedTable[string, ProfilerDataRow]()
        }.toOrderedTable

        # TODO(VM/profiler) Completely remove or make it work "properly"
        #  labels: vm, benchmark, performance, bug
        when false:
            system.profilingRequestedHook = requestedHook
            system.profilerHook = hook
    else:
        discard

proc showProfilerData*() =
    when defined(PROFILER):
        printProfilerHeader()
        printProfilerDataTable("functions")
        printProfilerDataTable("ops")
        printProfilerDataTable("procs")
        when false:
            printProfilerCallTree()
    else:
        discard

when defined(PROFILER):
    {.push profiler:on .}