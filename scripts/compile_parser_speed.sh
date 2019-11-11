flex -F -8 src/parser/lexer_final.l # perhaps remove -F and add -I (interactive) ?
bison -d src/parser/parser.y
gcc -O4 -Ofast -flto -fno-strict-aliasing lex.yy.c -c
gcc -O4 -Ofast -flto -fno-strict-aliasing parser.tab.c -c
ar rvs parser.a lex.yy.o parser.tab.o