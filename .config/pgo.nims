
## Profile-guided optimization
## ---------------------------
##
## A PGO build happens in three steps:
##  1. build an instrumented binary
##  2. run it on the training set (tools/pgo/train
##     + tests/unittests), collecting a profile
##  3. build again, letting the C compiler optimize
##     based on that profile
##
## Nim uses clang on macOS & the BSDs and gcc elsewhere,
## and the two of them have different flags and profile
## formats.

{. push used .}

let
    pgoUsesClang = hostOS in ["macosx", "freebsd", "openbsd"]
    pgoCacheDir = getCurrentDir()/".cache"
    pgoDir = pgoCacheDir/"pgo"
    pgoProfile = pgoDir/"arturo.profdata"
    pgoTrainingSets = [
        getCurrentDir()/"tools"/"pgo"/"train",
        getCurrentDir()/"tests"/"unittests"
    ]

proc pgoFlags(generate: bool): seq[string] =
    let compilerFlags =
        if pgoUsesClang:
            if generate: @["-fprofile-instr-generate"]
            else: @["-fprofile-instr-use=" & pgoProfile]
        else:
            if generate: @["-fprofile-generate", "-fprofile-update=single"]
            else: @["-fprofile-use", "-fprofile-correction", "-Wno-missing-profile"]

    for flag in compilerFlags:
        result.add "--passC:" & flag
        result.add "--passL:" & flag

proc pgoFilesIn(dir: string, ext: string): seq[string] =
    for file in listFiles(dir):
        if file.endsWith(ext):
            result.add file
    for sub in listDirs(dir):
        result.add pgoFilesIn(sub, ext)

proc pgoCleanUp() =
    ## remove profiles from previous runs, if any
    rmDir pgoDir
    mkDir pgoDir
    if dirExists(pgoCacheDir):
        for file in pgoFilesIn(pgoCacheDir, ".gcda"):
            rmFile file

proc pgoTrain(binary: string) =
    ## run every training script with the instrumented binary;
    ## failures don't matter here, we only care about the profile
    let bin = getCurrentDir()/binary.replace('/', DirSep)
    putEnv "LLVM_PROFILE_FILE", pgoDir/"%p.profraw"

    if hostOS == "windows":
        # full builds need the webview DLLs next to the binary
        let dlls = getCurrentDir()/"src"/"extras"/"webview"/"deps"/"dlls"/"x64"
        for dll in ["webview.dll", "WebView2Loader.dll"]:
            if fileExists(dlls/dll):
                cpFile(dlls/dll, bin.parentDir/dll)

    var ran, failed = 0
    var lastFailure = ""
    for dir in pgoTrainingSets:
        for file in listFiles(dir):
            if not file.endsWith(".art"):
                continue
            # gorgeEx doesn't go through a shell on Windows
            let cmd =
                if hostOS == "windows": fmt"cmd /c cd /d {dir.quoteShell} && {bin.quoteShell} {file.extractFilename.quoteShell}"
                else: fmt"cd {dir.quoteShell} && {bin.quoteShell} {file.extractFilename.quoteShell}"
            let res = gorgeEx(cmd, "\n")
            inc ran
            if res.exitCode != 0:
                inc failed
                lastFailure = cmd & "\n" & res.output

    log fmt"training runs: {ran} ({failed} with non-zero exit code)"
    if ran > 0 and failed == ran:
        warn lastFailure

proc pgoMergeProfile(): bool =
    ## clang needs the raw profiles merged into one file;
    ## gcc just leaves .gcda files next to the object files
    if pgoUsesClang:
        let
            profdata = if hostOS == "macosx": "xcrun llvm-profdata" else: "llvm-profdata"
            res = gorgeEx(fmt"{profdata} merge -o {pgoProfile.quoteShell} {quoteShell(pgoDir)}/*.profraw")
        if res.exitCode != 0:
            warn res.output
            return false
        # the raw profiles can be several hundred MBs
        for file in pgoFilesIn(pgoDir, ".profraw"):
            rmFile file
        return fileExists(pgoProfile)
    else:
        return pgoFilesIn(pgoCacheDir, ".gcda").len > 0

{. pop .}
