#!/usr/bin/env bash
#*****************************************************************
#* Arturo :VM
#* 
#* Programming Language + Compiler
#* (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
#*
#* @file: build.sh
#*****************************************************************

##=========================
## global variables
##=========================

BINARY=arturo
CC=clang
FLEX=flex
BISON=bison
AWK=awk
UPX=upx

##=========================
## Libraries
##=========================

LIBGMP="/usr/local/opt/gmp/lib/libgmp.a"

##=========================
## Config
##=========================


##=========================
## sources
##=========================

SOURCES=(
    helpers/benchmark
    helpers/i32tos
    helpers/stoi32
    repl/repl 
    vm/generator
    vm/objfile
    vm/optimizer
    vm/value
    vm/vm
    main
)

OBJECTS=("${SOURCES[@]##*/}")
OBJECTS=("${OBJECTS[@]/%/.o}")

##=========================
## helpers
##=========================

print_task(){
    printf "\033[1;35m>\033[0m "
    printf "%-25s" "$1"
}

print_task_main(){
    printf "\033[1;35m>\033[0m "
    printf "%-25s" "$1"
    printf "\n"
}

print_subtask(){
    printf "    \033[0;36m- $1\033[0m\n"
}

end_task(){
    printf " \033[1;32m✓\033[0m\n"
}

##=========================
## get command
##=========================

command=$1 

##=========================
## print logo
##=========================

printf "\n"
printf "\e[32m\e[1m     db    88\"\"Yb 888888 88   88 88\"\"Yb  dP\"Yb\n"  
printf "    dPYb   88__dP   88   88   88 88__dP dP   Yb \n"
printf "   dP__Yb  88\"Yb    88   Y8   8P 88\"Yb  Yb   dP \n"
printf "  dP\"\"\"\"Yb 88  Yb   88   \`YbodP' 88  Yb  YbodP\e[0m\n"
printf "\n"
printf "=================================================>\n"
printf "  \033[1mArturo\033[0m :VM\n"
printf "  (c) 2019, Yanis Zafirópulos\n"
printf "=================================================>\n\n"

##=========================
## main build
##=========================

print_task "Updating build..."
    $AWK '/([0-9]+)/ { printf "%d", $0+1 }' < src/version/BuildNo > src/version/BuildNo.tmp
    mv src/version/BuildNo.tmp src/version/BuildNo
    echo -n `date +%d-%b-%Y` > src/version/BuildDate
    cd src/version
    echo "#ifndef __VERSION_H__" > version.h
    echo "#define __VERSION_H__" >> version.h
    echo "" >> version.h
    xxd -i Version >> version.h
    xxd -i BuildNo >> version.h
    xxd -i BuildDate >> version.h
    echo "" >> version.h
    echo "#endif" >> version.h
    cd ../..
end_task

print_task_main "Building parser..."
    print_subtask "[FLEX] src/parser/lexer.l"
        $FLEX -F -8 src/parser/lexer.l

    print_subtask "[BISON] src/parser/parser.y"
        $BISON -d src/parser/parser.y
        # -v --report-file=parser.debug

    print_subtask "[C] lex.yy.c"
        $CC -O3 -I/Users/drkameleon/Downloads/mimalloc-1.2.2/include/ -c lex.yy.c

    print_subtask "[C] parser.tab.c"
        $CC -O3 -I/Users/drkameleon/Downloads/mimalloc-1.2.2/include/ -c parser.tab.c

    echo ""

# print_task_main "Building external libraries..."
#   print_subtask "[C] src/3rdparty/sds"
#       $CC -O3 -std=c99 --save-temps=.cache -c src/3rdparty/sds/sds.c

#   echo ""

print_task_main "Building core..."
    for s in ${SOURCES[@]}; do
        file=src/$s.c
        print_subtask "[C] $file"
            $CC -O3 -std=c99 --save-temps=.cache -Isrc/ -c $file
    done
    echo ""

print_task "Linking..."
    $CC parser.tab.o lex.yy.o ${OBJECTS[@]} $LIBGMP -o bin/$BINARY
    #-lpthread 
end_task

print_task "Compressing binary..."
    $UPX -q bin/$BINARY >/dev/null 2>&1
end_task

print_task "Cleaning up..."
    mv *.s *.i .cache/
    rm -f *.c *.o *.h *.a *.bc *.ii
    cd src/3rdparty/libsrt
    make -f Makefile.posix clean >/dev/null 2>&1
    cd ../../..
end_task

print_task "Installing..."
    cp bin/$BINARY /usr/local/bin
end_task

##=========================
## print instructions
##=========================

printf "\n\033[1;35m=\033[0m Done! :)\n\n"
printf "***************************************************************\n"
printf "* You may access the binary running 'arturo'\n"
printf "* as long as /usr/local/bin is in your \$PATH variable.\n"
printf "***************************************************************\n"
