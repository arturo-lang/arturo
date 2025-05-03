#!/usr/bin/env nim
######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2025 Yanis Zafirópulos
#
# @file: build.nims
######################################################
# initial conversion to NimScript thanks to:
# - Patrick (skydive241@gmx.de)

#=======================================
# Libraries
#=======================================

import std/[json, os, sequtils, strformat, strutils, tables]

import ".config/utils/ui.nims"
import ".config/utils/cli.nims"

#=======================================
# Initialize globals
#=======================================

mode = ScriptMode.Silent
--hints:off

#=======================================
# Flag system
#=======================================

include ".config/utils/flags.nims"

include ".config/arch.nims"
include ".config/buildmode.nims"
include ".config/devtools.nims"
include ".config/who.nims"

#=======================================
# Constants
#=======================================

# Most of the time package names are the same among distros using
# the same package manager. The exceptions are listed as <pkgman><distro>
type
    PkgMan = enum
        apk
        apt
        aptChimera
        brew
        bsd
        dnf
        dnfMandriva
        emerge
        eopkg
        guix
        nix
        pacman
        pkg_add
        pkgin
        swupd
        upgradepkg
        xbps
        zypper

let
    targetDir = getHomeDir()/".arturo"

    paths: tuple = (
        targetBin:      targetDir/"bin",
        targetLib:      targetDir/"lib",
        targetStores:   targetDir/"stores",
        mainFile:       "src"/"arturo.nim",
    )

# BSDs not supported yet
when defined(linux):
    const
        dependencies = [
            "gtk+-3.0",
            "webkit2gtk-4.1",
            "gmp",
            "mpfr",
        ]
elif defined(macosx):
    const
        dependencies = [
            "mpfr",
        ]
elif defined(windows):
    const
        dependencies: array[0, string] = []
else:
    const
        dependencies: array[0, string] = []

when defined(linux):
    const
        distros = {
            "alpine"        : apk,
            "altlinux"      : apt,
            "arch"          : pacman,
            "archlinux"     : pacman,
            "arkane"        : pacman,
            "artix"         : pacman,
            "aurora"        : brew,
            "blackarch"     : pacman,
            "blendos"       : pacman,
            "bluefin"       : brew,
            "centos"        : dnf,
            "chimera"       : aptChimera,
            "clear-linux-os": swupd,
            "debian"        : apt,
            "deepin"        : apt,
            "fedora"        : dnf,
            "garuda"        : pacman,
            "gentoo"        : emerge,
            "gnoppix"       : pacman,
            "guix"          : guix,
            "kaos"          : pacman,
            "manjaro"       : pacman,
            "nixos"         : nix,
            "nobara"        : dnf,
            "openmandriva"  : dnfMandriva,
            "opensuse"      : zypper,
            "pureos"        : apt,
            "rhel"          : dnf,
            "slackware"     : upgradepkg,
            "solus"         : eopkg,
            "suse"          : zypper,
            "ubuntu"        : apt,
            "void"          : xbps,
        }.toTable

elif defined(bsd):
    const
        distros = {
            "dragonfly"     : bsd,
            "freebsd"       : bsd,
            "ghostbsd"      : bsd,
            "netbsd"        : pkgin,
            "openbsd"       : pkg_add,
        }.toTable

elif defined(macosx):
    const
        distros = {
            "macos"         : brew,
        }.toTable

else:
    const
        distros = Table[string, PkgMan]()

const
    buildsWithDependencies = [
        "@full",
        "@docgen",
    ]

    dependenciesNames = {
        apk:        { "gtk+-3.0"      : "gtk+3.0-dev",
                      "webkit2gtk-4.1": "webkit2gtk-4.1-dev",
                      "gmp"           : "gmp-dev",
                      "mpfr"          : "mpfr-dev",
        }.toTable,
        apt:        { "gtk+-3.0"      : "libgtk-3-dev",
                      "webkit2gtk-4.1": "libwebkit2gtk-4.1-dev",
                      "gmp"           : "libgmp-dev",
                      "mpfr"          : "libmpfr-dev",
        }.toTable,
        aptChimera: { "gtk+-3.0"      : "gtk+3-devel",
                      "webkit2gtk-4.1": "webkitgtk-devel",
                      "gmp"           : "gmp-devel",
                      "mpfr"          : "mpfr-devel",
        }.toTable,
        brew:       { "gtk+-3.0"      : "gtk+3",
                      "webkit2gtk-4.1": "webkitgtk",
                      "gmp"           : "gmp",
                      "mpfr"          : "mpfr",
        }.toTable,
        dnf:        { "gtk+-3.0"      : "gtk3-devel",
                      "webkit2gtk-4.1": "webkit2gtk4.1-devel",
                      "gmp"           : "gmp-devel",
                      "mpfr"          : "mpfr-devel",
        }.toTable,
        dnfMandriva:{ "gtk+-3.0"      : "lib64gtk+3.0-devel",
                      "webkit2gtk-4.1": "lib64webkit4.1-devel",
                      "gmp"           : "lib64gmp-devel",
                      "mpfr"          : "lib64mpfr-devel",
        }.toTable,
        emerge:     { "gtk+-3.0"      : "gtk+",
                      "webkit2gtk-4.1": "webkit-gtk",
                      "gmp"           : "gmp",
                      "mpfr"          : "mpfr",
        }.toTable,
        eopkg:      { "gtk+-3.0"      : "libgtk-3-devel",
                      "webkit2gtk-4.1": "libwebkit-gtk41-devel",
                      "gmp"           : "gmp",
                      "mpfr"          : "mpfr",
        }.toTable,
        guix:       { "gtk+-3.0"      : "gtk+@3",
                      "webkit2gtk-4.1": "webkitgtk",
                      "gmp"           : "gmp",
                      "mpfr"          : "mpfr",
        }.toTable,
        nix:        { "gtk+-3.0"      : "gtk3",
                      "webkit2gtk-4.1": "webkitgtk_4_1",
                      "gmp"           : "gmp",
                      "mpfr"          : "mpfr",
        }.toTable,
        pacman:     { "gtk+-3.0"      : "gtk3",
                      "webkit2gtk-4.1": "webkit2gtk-4.1",
                      "gmp"           : "gmp",
                      "mpfr"          : "mpfr",
        }.toTable,
        slackware:  { "gtk+-3.0"      : "gtk+3[current version here].txz",
                      "webkit2gtk-4.1": "webkit2gtk4.1[current version here].txz",
                      "gmp"           : "gmp[current version here].txz",
                      "mpfr"          : "mpfr[current version here].txz",
        }.toTable,
        swupd:      { "gtk+-3.0"      : "devpkg-gtk3",
                      "webkit2gtk-4.1": "devpkg-webkitgtk",
                      "gmp"           : "devpkg-gmp",
                      "mpfr"          : "devpkg-mpfr",
        }.toTable,
        xbps:       { "gtk+-3.0"      : "gtk+3-devel",
                      "webkit2gtk-4.1": "webkit2gtk-devel",
                      "gmp"           : "gmp-devel",
                      "mpfr"          : "mpfr-devel",
        }.toTable,
        zypper:     { "gtk+-3.0"      : "gtk3-devel",
                      "webkit2gtk-4.1": "webkit2gtk3-devel",
                      "gmp"           : "gmp-devel",
                      "mpfr"          : "mpfr-devel",
        }.toTable,
    }.toTable

    # String templates for complex installation commands
    nixInstallCmd =
        """
        Update configuration.nix to include:
        $1

        and for building applications targeting Arturo use:
        nix-shell -p <THE LIST ABOVE, HERE>
        or edit shell.nix accordingly.
        """
    
    installCmds = {
        apk        : "apk add $1",
        apt        : "apt-get install $1",
        brew       : "brew install $1",
        bsd        : "pkg install $1",
        aptChimera : "apk add $1",
        dnf        : "dnf install $1",
        dnfMandriva: "dnf install $1",
        emerge     : "emerge install $1",
        eopkg      : "eopkg install $1",
        guix       : "guix install $1",
        nix        :  nixInstallCmd,
        pacman     : "pacman -S $1",
        pkg_add    : "pkg_add $1",
        pkgin      : "pkgin install $1",
        swupd      : "swupd bundle-add $1",
        upgradepkg : "upgradepkg --install-new $1",
        xbps       : "xbps-install $1",
        zypper     : "zypper install $1",
    }.toTable

    #TODO OTHER = @["redox", "tinycore"] these are niche but very interesting

#=======================================
# Types
#=======================================

type BuildConfig = tuple
    binary, version, bundle: string
    shouldCompress, shouldInstall, shouldLog, generateBundle, isDeveloper: bool

func webVersion(config: BuildConfig): bool

func backend(config: BuildConfig): string =
    result = "c"
    if config.webVersion:
        return "js"

func silentCompilation(config: BuildConfig): bool =
    ## CI and User builds should actually be silent,
    ## the most important is the exit code.
    ## But for developers, it's useful to have a detailed log.
    not (config.isDeveloper or config.shouldLog)

func webVersion(config: BuildConfig): bool =
    config.version == "@web"

func buildConfig(): BuildConfig =
    (
        binary:             "bin/arturo".toExe,
        version:            "@full",
        bundle:             "",
        shouldCompress:     true,
        shouldInstall:      false,
        shouldLog:          false,
        generateBundle:     false,
        isDeveloper:        false,
    )

#=======================================
# Helpers
#=======================================

func toErrorCode(a: bool): int =
    if a:
        return QuitSuccess
    else:
        return QuitFailure

template unless(condition: bool, body: untyped) =
    if not condition:
        body

# TODO(build.nims) JavaScript compression not working correctly
#  labels: web,bug
proc recompressJS*(jsFile: string, config: BuildConfig) =
    var js: string
    "testsed.txt".writeFile("""
        s/Field([0-5])/F\1/g
        s/field [^\"]+ is not accessible [^\"]+//g
    """)

    let CompressionResult =
        gorgeEx fmt"""
            sed -E -f testsed.txt {jsFile}
        """

    if CompressionResult.exitCode != QuitSuccess:
        js = readFile(jsFile)
            .replaceWord("Field0", "F0")
            .replaceWord("Field1", "F1")
            .replaceWord("Field2", "F2")
            .replaceWord("Field3", "F3")
    else:
        js = CompressionResult.output

    jsFile.writeFile js

proc miniBuild*() =
    # all the necessary "modes" for mini builds
    miniBuildConfig()

    # plus, shrinking + the MINI flag
    if hostOS=="freebsd" or hostOS=="openbsd" or hostOS=="netbsd":
        --verbosity:3

proc compressBinary(config: BuildConfig) =

    if (not config.shouldCompress) or (not config.webVersion):
        return

    section "Post-processing..."

    log "compressing binary..."
    let minBin = config.binary.replace(".js",".min.js")

    let CompressionResult =
        gorgeEx fmt"uglifyjs {config.binary} -c -m ""toplevel,reserved=['A$']"" -c -o {minBin}"

    if CompressionResult.exitCode != QuitSuccess:
        warn "uglifyjs: 3rd-party tool not available"
        minBin.writeFile readFile(config.binary)
    
    recompressJS(minBin, config)

proc verifyDirectories*() =
    ## Create target dirs recursively, if they don't exist
    log "setting up directories..."
    for path in [paths.targetBin, paths.targetLib, paths.targetStores]:
        mkdir path

proc compile*(config: BuildConfig, showFooter: bool = false): int
    {. raises: [OSError, ValueError, Exception] .} =

    proc windowsHostSpecific() =
        if config.isDeveloper and not flags.contains("NOWEBVIEW"):
            discard gorgeEx "src\\extras\\webview\\deps\\build.bat"
            #discard gorgeEx "src\\extras\\webview\\deps\\build-new.bat"
        --passL:"\"-static-libstdc++ -static-libgcc -Wl,-Bstatic -lstdc++ -Wl,-Bdynamic\""
        --gcc.linkerexe:"g++"

    proc unixHostSpecific() =
        --passL:"\"-lm\""

    result = QuitSuccess
    let
        params = flags.join(" ")
        cmd = fmt"nim {config.backend} {params} -o:{config.binary} {paths.mainFile}"

    if "windows" == hostOS:
         windowsHostSpecific()
    else:
        unixHostSpecific()

    if config.silentCompilation:
        return cmd.gorgeEx().exitCode
    else:
        echo fmt"{colors.gray}"
        cmd.exec()

proc installAll*(config: BuildConfig, targetFile: string) =

    # Helper functions

    proc copy(file: string, source: string, target: string) =
        cpFile source.joinPath(file), target.joinPath(file)

    # Methods

    proc copyWebView() =
        let 
            sourcePath = "src\\extras\\webview\\deps\\dlls\\x64\\"
            targetPath = "bin"
        log "copying webview..."
        "webview.dll".copy(sourcePath, targetPath)
        "WebView2Loader.dll".copy(sourcePath, targetPath)

    proc copyArturo(config: BuildConfig, targetFile: string) =
        log "copying files..."
        cpFile(config.binary, targetFile)

    proc giveBinaryPermission(targetFile: string) =
        exec fmt"chmod +x {targetFile}"

    proc main(config: BuildConfig) =

        if not config.shouldInstall:
            return

        section "Installing..."

        if config.webVersion:
            panic "Web builds can't be installed, please don't use --install"

        verifyDirectories()
        config.copyArturo(targetFile)

        if hostOS != "windows":
            giveBinaryPermission(targetFile)
        else:
            copyWebView()

        log fmt"deployed to: {targetDir}"

    main(config)

proc getDistro(): string =
    if defined(linux):
        var id = gorge("grep ^ID= /etc/os-release").toLower()
        if id.len == 0: return "unknown"
        var idLike = gorge("grep ^ID_LIKE= /etc/os-release")
        var idLikes: seq[string]
        if idLike.len > 0:
            idLikes = idLike[8..^1].strip(chars = {'"'}).toLower().splitWhitespace()
        for distro in distros.keys:
            if distro in id or distro in idLikes:
                return distro
        return "unknown"

    if defined(bsd):
        var distro = gorge("uname -s").toLower()
        if distro in distros:
            return distro
        else:
            return "unknown"

    if defined(macosx):
        return "macos"

proc checkDependencies(logging: bool) =
    var fails: seq[string]
    var os: string

    when defined(windows): return
    when defined(bsd)    : return

    log ""
    for dep in dependencies:
        if gorgeEx(fmt"pkg-config --exists {dep}").exitCode != 0:
            fails.add(dep)

    if fails.len > 0:
        os = getDistro()
        let failText = (if fails.len == 1: "this dependency" else: fmt"these {fails.len} dependencies")
        warn fmt"Missing {failText}:"
        for fail in fails:
            log fail
            if os == "nixos": continue
            if os != "unknown":
                var cmd = installCmds[distros[os]]
                log "-> " & cmd % dependenciesNames[distros[os]][fail]
        log ""

        if os == "nixos":
            log installCmds[nix] %
                (fails.map do (fail: string) -> string:
                    dependenciesNames[distros[os]][fail]).join("\p")

        panic "Install all packages listed above and try again", 1
    else:
        if logging:
            log "Dependencies successfully checked"

proc showBuildInfo*(config: BuildConfig) =
    let
        params = flags.join(" ")
        version = "version/version".staticRead()
        build = "version/build".staticRead()

    if config.generateBundle:
        section "Bundling..."
    else:
        section "Building..."
    log fmt"version: {version}/{build}"
    log fmt"config: {config.version}"

    if not config.silentCompilation:
        log fmt"flags: {params}"

    if config.version in buildsWithDependencies:
        checkDependencies(config.shouldLog)

#=======================================
# Methods
#=======================================

proc buildArturo*(config: BuildConfig, targetFile: string) =
    
    # Methods 

    proc showInfo(config: BuildConfig) =
        showEnvironment()
        config.showBuildInfo()

    proc setDevmodeUp() =
        devConfig()

    proc setBundlemodeUp() =
        bundleConfig()
        putEnv "BUNDLE_CONFIG", config.bundle

    proc tryCompilation(config: BuildConfig) =
        ## Panics if can't compile.
        if (let cd = config.compile(showFooter=true); cd != 0):
            panic "Compilation failed. Please try again with --log and report it.", cd

    proc main() =
        showHeader "install"

        if config.isDeveloper:
            setDevmodeUp()

        if config.generateBundle:
            setBundlemodeUp()

        config.showInfo()
        config.tryCompilation()
        config.compressBinary()

        if config.shouldInstall:
            config.installAll(targetFile)

        showFooter()

    main()

proc buildPackage*(config: BuildConfig) =

    # Helper functions

    proc dataFile(package: string): string =
        return fmt"{package}.data.json"

    proc file(package: string): string =
        return fmt"{package}.art"

    proc info(package: string): string =
        staticExec fmt"arturo --package-info {package.file}"

    # Subroutines

    proc generateData(package: string) =
        section "Processing data..."
        (package.dataFile).writeFile(package.info)
        log fmt"written to: {package.dataFile}"

    proc setEnvUp(package: string) =
        section "Setting up options..."

        putEnv "PORTABLE_INPUT", package.file
        putEnv "PORTABLE_DATA", package.dataFile

        log fmt"done!"

    proc setFlagsUp() =
        --forceBuild:on
        --opt:size
        --define:NOERRORLINES
        --define:PORTABLE

    proc showFlags() =
        let params = flags.join(" ")
        log fmt"FLAGS: {params}"
        echo ""

    proc cleanUp(package: string) =
        rmFile package.dataFile
        echo fmt"{styles.clear}"

    proc main() =
        let package = config.binary

        showHeader "package"

        package.generateData()
        package.setEnvUp()
        showEnvironment()
        config.showBuildInfo()

        setFlagsUp()
        showFlags()

        if (let cd = compile(config, showFooter=false); cd != 0):
            panic "Package building failed. Please try again with --log and report it.", cd

        package.cleanUp()

    main()


proc buildDocs*() =
    let 
        params = flags.join(" ")
        genDocs = fmt"nim doc --project --index:on --outdir:dev-docs {params} src/arturo.nim"
        genIndex = "nim buildIndex -o:dev-docs/theindex.html dev-docs"

    showHeader "docs"

    section "Generating documentation..."
    genDocs.exec()
    genIndex.exec()

proc performTests*(binary: string): bool =
    result = true

    showHeader "test"
    try:
        exec fmt"{binary} ./tools/tester.art"
    except:
        return false

proc performBenchmarks*(binary: string): bool =
    result = true

    showHeader "benchmark"
    try:
        exec fmt"{binary} ./tools/benchmarker.art"
    except:
        return false

#=======================================
# Main
#=======================================

cliInstance.header = getLogo()
cliInstance.defaultCommand = "build"
let 
    args = cliInstance.args

cmd build, "[default] Build arturo and optionally install the executable":
    ## build:
    ##     Provides a cross-compilation for the Arturo's binary.
    ##
    ##     --arch -a: $hostCPU          chooses the target CPU
    ##          [amd64, arm, arm64, i386, x86]
    ##     --as: arturo                 changes the name of the binary
    ##     --mode -m: full              chooses the target Build Version
    ##          [full, mini, web]
    ##     --os: $hostOS                chooses the target OS
    ##          [freebsd, linux, openbsd, mac, macos, macosx, netbsd, win, windows]
    ##     --profiler -p: none          defines which profiler use
    ##          [default, mem, native, none, profile]
    ##     --who: none                  defines who is compiling the code
    ##          [dev, user]
    ##     --debug -d                   enables debugging
    ##     --install -i                 installs the final binary
    ##     --log -l                     shows compilation logs
    ##     --raw                        disables compression
    ##     --release                    enable release config mode
    ##     --help

    let
        availableCPUs = @["amd-64", "x64", "x86-64", "arm-64", "i386", "x86",
                          "x86-32", "arm", "arm-32"]
        availableOSes = @["freebsd", "openbsd", "netbsd", "linux", "mac",
                          "macos", "macosx", "win", "windows",]
        availableBuilds = @["full", "mini", "docgen", "safe", "web"]
        availableProfilers = @["default", "mem", "native", "profile"]

    var config = buildConfig()

    config.binary = "bin"/args.getOptionValue("as", default="arturo").toExe

    match args.getOptionValue("arch", short="a",
                              default=hostCPU,
                              into=availableCPUs):
        let
            amd64 = availableCPUs[0..2]
            arm64 = [availableCPUs[3]]
            x86 = availableCPUs[4..6]
            arm32 = availableCPUs[7..8]

        >> amd64: amd64Config()
        >> arm64: arm64Config()
        >> x86:   arm64Config()
        >> arm32: arm32Config()

    match args.getOptionValue("mode", short="m", default="full", into=availableBuilds):
        >> ["full"]:
            fullBuildConfig()
        >> ["mini"]:
            miniBuildConfig()
            config.version = "@mini"
            miniBuild()
        >> ["docgen"]:
            fullBuildConfig()
            docgenBuildConfig()
            config.version = "@docgen"
        >> ["safe"]:
            safeBuildConfig()
            miniBuild()
        >> ["web"]:
            config.binary     = config.binary.replace(".exe", "") & ".js"
            config.version    = "@web"
            webBuildConfig()
            miniBuild()

    match args.getOptionValue("os", default=hostOS, into=availableOSes):
        let
            bsd = availableOSes[0..2]
            linux = [availableOSes[3]]
            macos = availableOSes[4..6]
            windows = availableOSes[7..8]

        >> bsd:     discard
        >> linux:   discard
        >> macos:   discard
        >> windows: discard

    match args.getOptionValue("profiler", default="none", short="p",
                              into=availableProfilers):
        >> ["default"]: profilerConfig()
        >> ["mem"]:     memProfileConfig()
        >> ["native"]:  nativeProfileConfig()
        >> ["profile"]: profileConfig()

    match args.getOptionValue("who", default="", into= @["user", "dev"]):
        >> ["user"]:
            config.isDeveloper = false
            userConfig()
        >> ["dev"]:
            config.isDeveloper = true
            devConfig()

    if args.hasFlag("bundle", "b"):
        config.generateBundle = true
        config.bundle = args.getPositionalArg(2)

    if args.hasFlag("debug", "d"):
        config.shouldCompress = false
        debugConfig()

    if args.hasFlag("install", "i"):
        config.shouldInstall = true

    if args.hasFlag("log", "l"):
        config.shouldLog = true

    if args.hasFlag("raw"):
        config.shouldCompress = false

    if args.hasFlag("release"):
        releaseConfig()

    config.buildArturo(targetDir/config.binary)

cmd package, "Package arturo app and build executable":
    ## package <pkg-name>:
    ##     Compiles packages into executables.
    ##
    ##     --arch: $hostCPU             chooses the target CPU
    ##          [amd64, arm, arm64, i386, x86]
    ##     --debug -d                   enables debugging
    ##     --help

    const availableCPUs = @["amd-64", "x64", "x86-64", "arm-64", "i386", "x86",
                          "x86-32", "arm", "arm-32"]

    var config = buildConfig()
    config.binary = args.getPositionalArg(2)

    match args.getOptionValue("arch", short="a",
                              default=hostCPU,
                              into=availableCPUs):
        let
            amd64 = availableCPUs[0..2]
            arm64 = [availableCPUs[3]]
            x86 = availableCPUs[4..6]
            arm32 = availableCPUs[7..8]

        >> amd64: amd64Config()
        >> arm64: arm64Config()
        >> x86:   arm64Config()
        >> arm32: arm32Config()

    if args.hasFlag("debug", "d"):
        config.shouldCompress = false
        debugConfig()

    config.buildPackage()

cmd docs, "Build the internal documentation":
    ## docs:
    ##     Builds the developer documentation
    ##
    ##     --help

    --define:DOCGEN
    buildDocs()

cmd test, "Run test suite":
    ## test:
    ##     Runs test suite
    ##
    ##     --using -u: arturo           runs with the given binary
    ##     --help

    let
        binary = args.getOptionValue("using", default="arturo", short="u").toExe
        paths: tuple = (
            local: "bin"/binary,
            global: paths.targetBin/binary
        )

    unless paths.global.performTests():
        quit paths.local.performTests().toErrorCode

cmd benchmark, "Run benchmark suite":
    ## benchmark:
    ##     Runs benchmark suite
    ## 
    ##     --using -u: arturo           runs with the given binary
    ##     --help
    
    let
        binary = args.getOptionValue("using", default="arturo", short="u").toExe
        paths: tuple = (
            local: "bin"/binary,
            global: paths.targetBin/binary
        )

    unless paths.global.performBenchmarks():
        quit paths.local.performBenchmarks().toErrorCode

helpForMissingCommand()
