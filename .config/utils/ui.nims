proc showLogo*() =
    echo r"====================================================================={GREEN}".fmt
    echo r"                               _                                     "
    echo r"                              | |                                    "
    echo r"                     __ _ _ __| |_ _   _ _ __ ___                    "
    echo r"                    / _` | '__| __| | | | '__/ _ \                   "
    echo r"                   | (_| | |  | |_| |_| | | | (_) |                  "
    echo r"                    \__,_|_|   \__|\__,_|_|  \___/                   "
    echo r"{CLEAR}{BOLD}                                                        ".fmt
    echo r"                     Arturo Programming Language{CLEAR}              ".fmt
    echo r"                      (c)2023 Yanis Zafirópulos                      "
    echo r"                                                                     "

proc showHeader*(title: string) =
    echo r"====================================================================="
    echo r" ► {title.toUpperAscii()}                                            ".fmt
    echo r"====================================================================="

proc section*(title: string) =
    echo r"{CLEAR}".fmt
    echo r"--------------------------------------------"
    echo r" {MAGENTA}●{CLEAR} {title}".fmt
    echo r"--------------------------------------------"

proc showFooter*() =
    echo r"{CLEAR}".fmt
    echo r"====================================================================="
    echo r" {MAGENTA}●{CLEAR}{GREEN} Awesome!{CLEAR}".fmt
    echo r"====================================================================="
    echo r"   Arturo has been successfully built & installed!"
    if hostOS != "windows":
        echo r""
        echo r"   To be able to run it,"
        echo r"   first make sure its in your $PATH:"
        echo r""
        echo r"          export PATH=$HOME/.arturo/bin:$PATH"
        echo r""
        echo r"   and add it to your {getShellRc()},".fmt
        echo r"   so that it's set automatically every time."
    echo r""
    echo r"   Rock on! :)"
    echo r"====================================================================="
    echo r"{CLEAR}".fmt

proc showEnvironment*() =
    section "Checking environment..."

    echo "{GRAY}   os: {hostOS}".fmt
    echo "   compiler: Nim v{NimVersion}{CLEAR}".fmt

proc showBuildInfo*() =
    let params = flags.join(" ")
    section "Building..."
    echo "{GRAY}   version: ".fmt & staticRead("version/version") & " b/" & staticRead("version/build")
    echo "   config: {CONFIG}{CLEAR}".fmt

    if IS_DEV or PRINT_LOG:
        echo "{GRAY}   flags: {params}{CLEAR}".fmt