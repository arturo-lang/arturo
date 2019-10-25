#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: version.nim
  *****************************************************************]#

import strutils

const 
    ART_VERSION     = "0.3.9"
    ART_BUILD       = readFile("../source/resources/build.txt").strip
    ART_BUILD_DATE  = readFile("../source/resources/build_date.txt").strip

when defined(mini): 
    const ART_EDITION = "mini"
else: 
    const ART_EDITION = "full"

#[######################################################
    Methods
  ======================================================]#

template showVersion*() = 
    const vers = "\x1B[32m\x1B[1mArturo " & ART_VERSION & "\x1B[0m (" & ART_BUILD_DATE & " build " & ART_BUILD & ") [" & hostCPU & "-" & hostOS & "-" & ART_EDITION & "]"
    echo vers
    echo "(c) 2019 Yanis Zafirópulos\n"
