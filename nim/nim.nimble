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

proc buildParser() = 
    showMessage("Building parser")
    exec "flex src/parser/lexer.l"
    exec "bison -d src/parser/parser.y"
    exec "gcc -O3 -Os lex.yy.c -c"
    exec "gcc -O3 -Os parser.tab.c -c"
    exec "ar rvs parser.a lex.yy.o parser.tab.o"

proc compileCore() = 
    showMessage("Compiling core")
    exec "nim c -d:release --passL:parser.a --threads:on --hints:off --opt:size --nilseqs:on --path:src -o:arturo -f src/main.nim"

proc stripBinary() =
    showMessage "Stripping binary"
    exec "strip arturo"

proc cleanUp() =
    showMessage "Cleaning up"
    exec "rm *.c *.a *.h *.o"

# Tasks

task release, "Build an optimised release":
    buildParser()
    compileCore()
    stripBinary()
    cleanUp()
    showMessage "Done :)", true

