######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2021 Yanis Zafirópulos
#
# @file: utils.sh
######################################################

################################################
# OPTIONS
################################################

# variables

MAIN="src/arturo.nim"

FLAGS="\
 --skipParentCfg:on\
 --warning[UnusedImport]:off\
 --colors:off\
 -d:release\
 -d:danger\
 --panics:off\
 --gc:orc\
 --checks:off\
 --overflowChecks:on\
 -d:ssl\
 --threads:on\
 --passC:"-O3"\
 --cincludes:extras\
 --nimcache:.cache\
 --embedsrc:on\
 --path:src"

################################################
# HELPERS
################################################

RED='\e[0;31m'
GREEN='\e[1;32m'
BLUE='\e[0;34m'
MAGENTA='\e[1;35m'
CYAN='\e[1;36m'
GRAY='\e[0;90m'
CLEAR='\e[0m'

printColorized() {
    NC='\e[0m'
    printf "${1}${2}${NC}"
}

print() {
    printf "${1}"
}

eecho() {
    printf "$1\n"
}

showHeader() {
    eecho "======================================"
    eecho "${GREEN}"
    eecho "               _                    "
    eecho "              | |                   "
    eecho "     __ _ _ __| |_ _   _ _ __ ___   "
    eecho "    / _\` | '__| __| | | | '__/ _ \ "
    eecho "   | (_| | |  | |_| |_| | | | (_) | "
    eecho "    \__,_|_|   \__|\__,_|_|  \___/  "
    eecho "                                    "
    eecho "${CLEAR}"
    printf "     \e[1mArturo"
    printf " Programming Language\e[0m\n"
    eecho "      (c)2021 Yanis Zafirópulos"
    eecho ""

    eecho "======================================"
    eecho " ► $1"
    eecho "======================================"
    printf "${CLEAR}"
}

showFooter(){
    eecho ""
    printf "${GRAY}"
    eecho " :---------------------------------------------------------"
    eecho " : Arturo has been successfully installed!"
    eecho " :"
    eecho " : To be able to run it,"
    eecho " : first make sure its in your \$PATH:"
    eecho " :"
    eecho " :    export PATH=$HOME/.arturo/bin:\$PATH"
    eecho " :"
    eecho " : and add it to your ${shellRcFile},"
    eecho " : so that it's set automatically every time."
    eecho " :"
    eecho " : Rock on! :)"
    eecho " :---------------------------------------------------------"
    printf "${CLEAR}"
    eecho ""
}

section(){
    eecho ""
    printf " ${MAGENTA}●${CLEAR} ${1}"
    eecho ""
}

info(){
    eecho "   ${GRAY}${1}${CLEAR}"
}

command_exists(){
    type "$1" &> /dev/null
}

animate_progress(){
    pid=$! # Process Id of the previous running command

    spin='-\|/'

    i=0
    printf "${CYAN}"
    while kill -0 $pid 2>/dev/null
    do
        i=$(( (i+1) %4 ))
        printf "\r ${spin:$i:1}"
        sleep .1
    done
    printf "\b\b\b\b     \x1B[A\x1B[A"
    printf "${CLEAR}"
}

##-----------------------------------------------

verifyOS(){
    case "$OSTYPE" in
        linux*)   currentOS="linux" ;;
        darwin*)  currentOS="macos" ;; 
        cygwin*)  currentOS="windows" ;;
        msys*)    currentOS="windows" ;;
        solaris*) currentOS="solaris" ;;
        freebsd*) currentOS="freebsd" ;;
        bsd*)     currentOS="bsd" ;;
        *)        currentOS="unknown" ;;
    esac

    info "os: $currentOS"
}

verifyShell(){
    case "$SHELL" in
        "/bin/zsh")     
            currentShell="zsh" ;
            shellRcFile="~/.zshrc" ;;
        "/bin/bash")    
            currentShell="bash" ;
            shellRcFile="~/.bashrc or ~/.profile" ;;
        "/bin/sh")      
            currentSheel="sh" ;
            shellRcFile="~/.profile" ;;
        *)              
            currentShell="unrecognized" ;
            shellRcFile="~/.profile" ;;
    esac

    info "shell: $currentShell"
}

verifyNim(){
    if ! command_exists nim ; 
    then
        curl https://nim-lang.org/choosenim/init.sh -sSf | sh
    fi
    VERS=$(nim -v | grep -o "Version \d\.\d\.\d")
    NIMV="${VERS/Version /}"
    info "nim: $NIMV"
}