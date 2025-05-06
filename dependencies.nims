import std/[sequtils, strformat, strutils, tables]

import ".config/utils/ui.nims"

# Most of the time package names are the same among distros using
# the same package manager. The exceptions are listed as <pkgman><distro>
type
    PkgMan = enum
        apk
        apkChimera
        apt
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
            "chimera"       : apkChimera,
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
    buildsWithDependencies* = [
        "@full",
        "@docgen",
    ]

    dependenciesNames = {
        apk:        { "gtk+-3.0"      : "gtk+3.0-dev",
                      "webkit2gtk-4.1": "webkit2gtk-4.1-dev",
                      "gmp"           : "gmp-dev",
                      "mpfr"          : "mpfr-dev",
        }.toTable,
        apkChimera: { "gtk+-3.0"      : "gtk+3-devel",
                      "webkit2gtk-4.1": "webkitgtk-devel",
                      "gmp"           : "gmp-devel",
                      "mpfr"          : "mpfr-devel",
        }.toTable,
        apt:        { "gtk+-3.0"      : "libgtk-3-dev",
                      "webkit2gtk-4.1": "libwebkit2gtk-4.1-dev",
                      "gmp"           : "libgmp-dev",
                      "mpfr"          : "libmpfr-dev",
        }.toTable,
        brew:       { "gtk+-3.0"      : "gtk+3",
                      "webkit2gtk-4.1": "webkitgtk",
                      "gmp"           : "gmp",
                      "mpfr"          : "mpfr",
        }.toTable,
        bsd:        { "gtk+-3.0"      : "gtk3",
                      "webkit2gtk-4.1": "webkit2-gtk",
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
        pkg_add:    { "gtk+-3.0"      : "gtk+3",
                      "webkit2gtk-4.1": "webkitgtk41",
                      "gmp"           : "gmp",
                      "mpfr"          : "mpfr",
        }.toTable,
        pkgin:      { "gtk+-3.0"      : "gtk3",
                      "webkit2gtk-4.1": "webkit-gtk",
                      "gmp"           : "gmp",
                      "mpfr"          : "mpfr",
        }.toTable,
        upgradepkg: { "gtk+-3.0"      : "gtk+3<CURRENT VERSION HERE>.txz",
                      "webkit2gtk-4.1": "webkit2gtk4.1<CURRENT VERSION HERE>.txz",
                      "gmp"           : "gmp<CURRENT VERSION HERE>.txz",
                      "mpfr"          : "mpfr<CURRENT VERSION HERE>.txz",
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
        apkChimera : "apk add $1",
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

proc checkDependencies*(logging: bool) =
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

        echo "Install all packages listed above and try again", 1
    else:
        if logging:
            log "Dependencies successfully checked"
