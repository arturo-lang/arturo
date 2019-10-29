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
    let gcc_flags   = "--gcc.options.speed=\"-O4 -Ofast -flto -fno-strict-aliasing -ffast-math\" --gcc.options.linker=\"-flto\""
    let clang_flags = "--clang.options.speed=\"-O4 -Ofast -flto -fno-strict-aliasing -ffast-math\" --clang.options.linker=\"-flto\""
    # --embedsrc --genScript 
    "nim c " & gcc_flags & " " & clang_flags & " " & join(cmdArgs," ") & " --path:" & srcDir & " -o:" & bin[0] & " -f --nimcache:cache --checks:off " & srcDir & "/main.nim"

template buildParser(forSize:bool=false) = 
    showMessage("Building parser")
    if forSize:
        exec "bash scripts/compile_parser_size.sh"
    else:
        exec "bash scripts/compile_parser_speed.sh"

template updateBuild() =
    showMessage("Updating build number")
    exec "cd .. && bash scripts/update_build.sh && cd nim"

template compileCore() = 
    showMessage("Compiling core for release")
    let args = @[
        "-d:release",

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

template compileTest() = 
    showMessage("Compiling test module")
    exec "nim c -d:release --opt:speed --path:src -o:test src/test.nim"

template profileCore() = 
    showMessage("Compiling core for profiling")
    let args = @[
        "-d:profile",
        "--profiler:on",
        "--stackTrace:on",

        "--passL:parser.a",
        "--threads:on",
        "--hints:off",
        "--opt:speed",
        "--nilseqs:on",
        "--gc:regions"
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

# Tasks

task release, "Build a production-ready optimized release":
    buildParser()
    updateBuild()
    compileCore()
    stripBinary()
    cleanUp()
    showMessage "Done :)", true

task mini, "Build a production-ready optimized mini-release":
    buildParser(forSize=true)
    updateBuild()
    compileMini()
    stripBinary()
    cleanUp()
    showMessage "Done :)", true

task profile, "Build a version for profiling":
    buildParser()
    profileCore()
    cleanUp()
    showMessage "Done :)", true

task debug, "Build a version for debugging":
    buildParser()
    debugCore()
    cleanUp()
    showMessage "Done :)", true

task test, "Run tests":
    compileTest()
    showMessage "Done :)", true
