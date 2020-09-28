#!/usr/bin/env bash
######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2020 Yanis Zafirópulos
#
# @file: build
######################################################

awk '{sub(/[[:digit:]]+$/,$NF+1)}1' version/build > version/build_tmp && mv version/build_tmp version/build

# print header

echo "                                    ";
echo "               _                    ";
echo "              | |                   ";
echo "     __ _ _ __| |_ _   _ _ __ ___   ";
echo "    / _\` | '__| __| | | | '__/ _ \ ";
echo "   | (_| | |  | |_| |_| | | | (_) | ";
echo "    \__,_|_|   \__|\__,_|_|  \___/  ";
echo "                                    ";

printf "   \e[1mArturo\e[0m"
echo " Programming Language + VM"
echo "   (c)2019-2020 / Yanis Zafirópulos"
echo ""
echo "======================================"
echo " Builder/Installer"
echo "======================================"
printf "\e[0m"

# options
BINARY=bin/arturo
HINTS="" #"--hint[Conf]:off --hint[CC]:off --hint[Link]:off --hint[SuccessX]:off"
WARNINGS="--warning[UnusedImport]:off"
FLAGS="${HINTS} ${WARNINGS} --colors:off -d:PYTHONIC -d:release -d:danger --panics:on --gc:arc --checks:off -d:ssl"
NIM_OPTS=""
DO_COMPRESS=true
DO_PASSEXTRA=true
DO_INSTALL=false

NIM=nim

echo ""

if [ $# -eq 0 ]; then
    
    printf "\e[1;35m●\e[0m Setting mode:\e[1;32m full\e[0m"
    FLAGS="c ${FLAGS} --opt:speed"
fi

while test $# -gt 0
do
    case "$1" in
        install)    
                    DO_INSTALL=true

                    printf "\e[1;35m●\e[0m Setting mode:\e[1;32m full\e[0m"
                    FLAGS="c ${FLAGS} --opt:speed"
            ;;
        mini)       
                    printf "\e[1;35m●\e[0m setting mode:\e[1;32m mini\e[0m"
                    FLAGS="c ${FLAGS} --opt:size"
            ;;
        verbose) 	
                    printf "\e[1;35m●\e[0m setting mode:\e[1;32m verbose\e[0m"
                    FLAGS="c ${FLAGS} --opt:speed"
                    NIM_OPTS="${NIM_OPTS} -d:VERBOSE"
            ;;
        benchmark) 	
                    printf "\e[1;35m●\e[0m setting mode:\e[1;32m benchmark\e[0m"
                    FLAGS="c ${FLAGS} --opt:speed"
                    NIM_OPTS="${NIM_OPTS} -d:BENCHMARK"
            ;;
        debug) 		
                    printf "\e[1;35m●\e[0m setting mode:\e[1;32m debug\e[0m"
                    NIM_OPTS="${NIM_OPTS} -d:DEBUG --debugger:on --debuginfo --linedir:on"
					DO_COMPRESS=false
					DO_PASSEXTRA=false
            ;;
        profile) 	
                    printf "\e[1;35m●\e[0m setting mode:\e[1;32m profile\e[0m"
                    FLAGS="c ${FLAGS} --opt:speed"
                    NIM_OPTS="${NIM_OPTS} -d:PROFILE --profiler:on --stackTrace:on"
            ;;
        web)        
                    printf "\e[1;35m●\e[0m setting mode:\e[1;32m web\e[0m"
                    FLAGS="js"
                    NIM_OPTS="${NIM_OPTS} -d:WEB"
            ;;
        *)          
			;;
    esac
    shift
done

echo ""

echo ""
printf "\e[1;35m●\e[0m Building Arturo\e[0m"
echo ""
printf "  \e[0;90mversion: "
cat version/version
printf "\e[0m"

#--passC:"-O3 -flto" --passL:"-flto"

if $DO_PASSEXTRA ; then
    echo ""
    printf "  \e[1;90m"
	$NIM $FLAGS $NIM_OPTS --passC:"-O3" --cincludes:extras --nimcache:.cache --embedsrc:on --path:src -o:$BINARY src/arturo.nim
else
    echo ""
    printf "  \e[1;90m"
	$NIM $FLAGS $NIM_OPTS --cincludes:extras --nimcache:.cache --embedsrc:on --path:src -o:$BINARY src/arturo.nim
fi
printf "\e[0m"
echo ""

# ultracompress final binary

if $DO_COMPRESS ; then
    echo ""
	printf "\e[1;35m●\e[0m Optimizing binary\e[0m"
    echo ""
    printf "  \e[0;90mcompression: on\e[0m"
    echo ""
	upx -q $BINARY >/dev/null 2>&1
fi

if $DO_INSTALL ; then
    echo ""
    printf "\e[1;35m●\e[0m Installing\e[0m"
    echo ""
    printf "  \e[0;90m@ /usr/local/bin\e[0m"
    echo ""
    sudo cp $BINARY /usr/local/bin
fi

echo ""
printf "\e[1;35m●\e[0m Done!\e[0m"
echo ""
echo ""
printf "\e[0;90m"
echo ":---------------------------------------------------------"
echo ": Just run 'arturo' (or ./arturo, in case you didn't"
echo ": install the binary globally) and enjoy."
echo ": "
echo ": Rock on! :)"
echo ":---------------------------------------------------------"
printf "\e[0m"
echo ""

#################################################
# that's all folks...
#################################################