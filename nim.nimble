import strformat

# Package

version       = "0.3.9"
author        = "drkameleon"
description   = "Simple, modern and powerful interpreted programming language for super-fast scripting"
license       = "MIT"
srcDir        = "src"
bin           = @["arturo"]

# Dependencies

requires "nim >= 1.0.9"

# Helpers

template showMessage(msg:string,final:bool=false) =
    if not final:
        echo "  \e[1;35m" & msg & "...\e[00m"
    else:
        echo "  \e[1;32m" & msg & "\e[00m"
        echo "------"

template getCommand(cmdArgs:openArray[string]):string =
    let gcc_flags   = "--gcc.options.speed=\"-O4 -Ofast -flto -march=native -fno-strict-aliasing -ffast-math \" --gcc.options.linker=\"-flto\""
    let clang_flags = "--clang.options.speed=\"-O4 -Ofast -flto -march=native -fno-strict-aliasing -ffast-math \" --clang.options.linker=\"-flto\""
    # --embedsrc --genScript 
    "nim c " & gcc_flags & " " & clang_flags & " " & join(cmdArgs," ") & " --path:" & srcDir & " -o:" & bin[0] & " -f --nimcache:_cache --embedsrc --checks:off --overflowChecks:on " & srcDir & "/main.nim"

template getTestCommand(cmdArgs:openArray[string]):string =
    let gcc_flags   = "--gcc.options.speed=\"-O4 -Ofast -flto -march=native -fno-strict-aliasing -ffast-math \" --gcc.options.linker=\"-flto\""
    let clang_flags = "--clang.options.speed=\"-O4 -Ofast -flto -march=native -fno-strict-aliasing -ffast-math \" --clang.options.linker=\"-flto\""
    # --embedsrc --genScript 
    "nim c " & gcc_flags & " " & clang_flags & " " & join(cmdArgs," ") & " --path:" & srcDir & " -o:test -f --checks:off --overflowChecks:on " & srcDir & "/compiler.nim"

template buildLibrary(forSize:bool=false) = 
    showMessage("Registering system library")
    exec "ruby scripts/register_system_functions.rb"

template buildParser(forSize:bool=false) = 
    showMessage("Building parser")
    exec "ruby scripts/register_system_functions.rb"
    if forSize:
        exec "bash scripts/compile_parser_size.sh"
    else:
        exec "bash scripts/compile_parser_speed.sh"

template updateBuild() =
    showMessage("Updating build number")
    exec "bash scripts/update_build.sh"

template compileCore() = 
    showMessage("Compiling core for release")
    let args = @[
        "-d:release",
        "-d:danger",

        "--passL:parser.a",
        "--threads:on",
        "--hints:off",
        "--opt:speed",
        "--nilseqs:on",
        "--gc:regions"
    ]
    exec getCommand(args)

template compileMini() = 
    showMessage("Compiling core for mini-release")
    let args = @[
        "-d:release",
        "-d:mini",

        "--passL:parser.a",
        "--threads:on",
        "--hints:off",
        "--opt:size",
        "--nilseqs:on",
        "--gc:regions"
    ]
    exec getCommand(args)

template compileExperiment() = 
    showMessage("Compiling experimental module")
    exec "nim c -d:release --opt:speed --nimcache:_cache --threads:on --path:src -o:test src/test.nim"


template compileUnittests() = 
    showMessage("Compiling unittests")
    let args = @[
        "-d:release",
        "-d:danger",
        "-d:unittest",

        "--threads:on",
        "--hints:off",
        "--opt:speed",
        "--nilseqs:on",
        "--gc:regions"
    ]
    exec getTestCommand(args)

template runUnittests() =
    exec "./test"

template profileCore() = 
    showMessage("Compiling core for profiling")
    let args = @[
        "-d:profile",
        "--profiler:on",
        "--stackTrace:on",

        "--passL:parser.a",
        #"--threads:on",
        #"--hints:off",
        "--opt:speed",
        #"--nilseqs:on",
        #"--gc:regions"
    ]
    exec getCommand(args)

template profileMemory() = 
    showMessage("Compiling core for memory profiling")
    let args = @[
        "-d:memProfiler",
        "--profiler:off",
        "--stackTrace:on",

        "--passL:parser.a",
        #"--threads:on",
        #"--hints:off",
        "--opt:speed",
        #"--nilseqs:on",
        #"--gc:regions"
    ]
    exec getCommand(args)

template debugCore() = 
    showMessage("Compiling core for debugging")
    let args = @[
        "-d:debug",
        "--linedir:on",
        "--debuginfo",

        "--passL:parser.a",
        "--threads:on",
        "--hints:on",
        "--opt:speed",
        "--nilseqs:on",
        "--gc:regions"
    ]
    exec getCommand(args)

template stripBinary() =
    showMessage "Stripping binary"
    exec "strip arturo"

template cleanUp() =
    showMessage "Cleaning up"
    exec "rm *.c *.a *.h *.o"
    exec "rm src/parser/lexer_final.l"
    #exec "rm src/system.nim"

# Tasks

task release, "Build a production-ready optimized release":
    buildLibrary()
    buildParser()
    updateBuild()
    compileCore()
    stripBinary()
    cleanUp()
    showMessage "Done :)", true

task mini, "Build a production-ready optimized mini-release":
    buildLibrary()
    buildParser(forSize=true)
    updateBuild()
    compileMini()
    stripBinary()
    cleanUp()
    showMessage "Done :)", true

task profile, "Build a version for profiling":
    buildLibrary()
    buildParser()
    profileCore()
    cleanUp()
    showMessage "Done :)", true

task memory, "Build a version for memory profiling":
    buildLibrary()
    buildParser()
    profileMemory()
    cleanUp()
    showMessage "Done :)", true

task debug, "Build a version for debugging":
    buildLibrary()
    buildParser()
    debugCore()
    cleanUp()
    showMessage "Done :)", true

task experiment, "Run experiments":
    compileExperiment()
    showMessage "Done :)", true

task test, "Run Unittests":
    compileUnittests()
    showMessage "Done :)", true
    runUnittests()
