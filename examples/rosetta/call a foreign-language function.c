// compile with:
// clang -c -w mylib.c
// clang -shared -o libmylib.dylib mylib.o

#include <stdio.h>

void sayHello(char* name){
    printf("Hello %s!\n", name);
}

int doubleNum(int num){
    return num * 2;
}