
## This file helps ``builderUtils.nims``, providing the compiler configuration
## for each type of binary produced.

import std/sugar

proc buildWindows(archFlags: (string) -> void, ssl: bool): void =
    discard

proc buildMacOS(archFlags: (string) -> void, ssl: bool): void =
    discard

proc buildDefault(archFlags: (string) -> void, ssl: bool): void =
    discard