# Package

version       = "0.6.0"
author        = "drkameleon"
description   = "Simple, modern and powerful interpreted programming language for super-fast scripting"
license       = "MIT"
srcDir        = "src"
bin           = @["arturo"]

# Dependencies

requires "nim >= 1.0.2"

requires "bignum >= 1.0.4"
requires "markdown >= 0.8.0"
requires "mustache >= 0.2.1"

# Helpers

template buildParser() =
    exec("flex -F -8 src/parser/lexer.l")
    exec("bison -d src/parser/parser.y")
    exec("gcc -O4 -Ofast -flto -fno-strict-aliasing lex.yy.c -c")
    exec("gcc -O4 -Ofast -flto -fno-strict-aliasing parser.tab.c -c")
    exec("ar rvs parser.a lex.yy.o parser.tab.o")

template compressBinary() = 
    exec("upx arturo")

template cleanUp() =
    echo getCurrentDir()
    exec("pwd")
    exec("rm -f lex.yy.c parser.tab.c parser.tab.h")

# Hooks

before install:
    buildParser()


after install:
    compressBinary()
    cleanUp()
    echo("After PkgDir: ", thisDir())

after build:
    echo "AFTER"
