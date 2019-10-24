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

template getCommand(cmdArgs:openArray[string]):string =
    "nim c " & join(cmdArgs," ") & " --path:" & srcDir & " -o:" & bin[0] & " -f --nimcache:cache " & srcDir & "/main.nim"

template buildParser() = 
    showMessage("Building parser")
    exec "flex src/parser/lexer.l"
    exec "bison -d src/parser/parser.y"
    exec "gcc -O3 -Os lex.yy.c -c"
    exec "gcc -O3 -Os parser.tab.c -c"
    exec "ar rvs parser.a lex.yy.o parser.tab.o"

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
        "--nilseqs:on"
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
        "--nilseqs:on"
    ]
    exec getCommand(args)

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
        "--nilseqs:on"
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
        "--nilseqs:on"
    ]
    exec getCommand(args)

template stripBinary() =
    showMessage "Stripping binary"
    exec "strip arturo"

template cleanUp() =
    showMessage "Cleaning up"
    exec "rm *.c *.a *.h *.o"

# Tasks

task release, "Build a production-ready optimize release":
    buildParser()
    updateBuild()
    compileCore()
    stripBinary()
    cleanUp()
    showMessage "Done :)", true

task mini, "Build a production-ready optimize mini-release":
    buildParser()
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
