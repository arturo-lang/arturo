#!/usr/bin/env bash

flex source/grammar/lexer.l
bison -d source/grammar/parser.y
gcc lex.yy.c -c
gcc parser.tab.c -c
mv lex.yy.o obj/lexer.o
mv parser.tab.o obj/parser.o
rm lex.yy.c parser.tab.c parser.tab.h