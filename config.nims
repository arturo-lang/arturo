# TODO(config.nims) do we really need that?
#  perhaps the only reason this should stay is if the .nimble file remains. if not, it only generates confusion.
#  labels: installer,cleanup
######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2020 Arturo Contributors
# (c) 2022 Yanis Zafirópulos
#
# @file: config.nims
######################################################

switch("hints", "off")
switch("colors","off")
switch("d","release")
switch("d","danger")
switch("panics","off")
switch("gc","orc")
switch("checks","off")
switch("overflowChecks","on")
switch("d","ssl")
switch("passC","-O3")
switch("cincludes","extras")
switch("nimcache",".cache")
switch("embedsrc","on")
switch("path","src")

when defined MINI:
    switch("opt", "size")
else:
    switch("opt", "speed")
