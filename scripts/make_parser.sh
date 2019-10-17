#!/usr/bin/env bash

flex source/grammar/lexer.l
bison -d source/grammar/parser.y
gcc -O3 -Os lex.yy.c -c
gcc -O3 -Os parser.tab.c -c
mv lex.yy.o obj/lexer.o
mv parser.tab.o obj/parser.o
rm lex.yy.c parser.tab.c parser.tab.h