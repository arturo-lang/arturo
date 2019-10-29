flex src/parser/lexer.l
bison -d src/parser/parser.y
gcc -Os lex.yy.c -c
gcc -Os parser.tab.c -c
ar rvs parser.a lex.yy.o parser.tab.o