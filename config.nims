######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2020 Arturo Contributors
#
# @file: config.nims
######################################################

#switch("warning[UnusedImport]", "off")
switch("checks", "off")
switch("cincludes", "extras")
switch("colors", "off")
#switch("d", "PYTHONIC")
switch("d", "danger")
switch("d", "release")
switch("d", "ssl")
switch("embedsrc", "on")
switch("gc", "orc")
#switch("nimcache", ".cache")
switch("opt", "speed")
switch("overflowChecks", "on")
switch("panics", "off")
switch("threads", "on")
switch("threadAnalysis", "off")
switch("path","src")

when not defined DEBUG:
    switch("passC", "-O3")

when defined MINI:
    switch("opt", "size")
elif defined VERBOSE:
    switch("opt", "speed")
elif defined BENCHMARK:
    switch("opt", "speed")
elif defined DEBUG:
    switch("linedir", "on")
    switch("debugger", "on")
    switch("debuginfo", "on")
elif defined PROFILE:
    switch("debuginfo", "on")
    switch("profiler", "on")
    switch("stackTrace", "on")
elif defined WEB:
    discard
else:
    switch("opt", "speed")
