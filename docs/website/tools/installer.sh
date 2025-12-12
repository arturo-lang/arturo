######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2025 Yanis Zafirópulos
#
# @file: installer.sh
######################################################

set -e

################################################
# CONSTANTS
################################################

BASE_URL="https://arturo-lang.io"
INSTALL_DIR="$HOME/.arturo"
BIN_DIR="$INSTALL_DIR/bin"
TMP_DIR=""

VERSION_TYPE="stable"
BUILD_VARIANT="full"

for arg in "$@"; do
    case $arg in
        --nightly|-n) VERSION_TYPE="latest";;
        --mini|-m)    BUILD_VARIANT="mini";;
    esac
done

################################################
# COLORS
################################################

RED='\033[0;31m'
GREEN='\033[1;32m'
MAGENTA='\033[1;35m'
CYAN='\033[1;36m'
GRAY='\033[0;90m'
CLEAR='\033[0m'

################################################
# UTILITIES
################################################

print() { printf "%b" "$1"; }
println() { printf "%b\n" "$1"; }
error() { println "${RED}✗ $1${CLEAR}" >&2; exit 1; }
info() { println "${GRAY}  $1${CLEAR}"; }
section() { println "\n${MAGENTA}●${CLEAR} $1"; }
command_exists() { command -v "$1" >/dev/null 2>&1; }

cleanup() {
    [ -n "$TMP_DIR" ] && [ -d "$TMP_DIR" ] && rm -rf "$TMP_DIR"
}
trap cleanup EXIT INT TERM

show_header() {
    println "======================================"
    println "${GREEN}"
    println "               _                    "
    println "              | |                   "
    println "     __ _ _ __| |_ _   _ _ __ ___   "
    println "    / _\` | '__| __| | | | '__/ _ \\ "
    println "   | (_| | |  | |_| |_| | | | (_) | "
    println "    \__,_|_|   \__|\__,_|_|  \___/  "
    println "                                    "
    println "${CLEAR}"
    print "     \033[1mArturo"
    print " Programming Language\033[0m\n"
    println "      (c)2025 Yanis Zafirópulos"
    println ""
    println "======================================"
    println " ► Installer"
    println "======================================"
    print "${CLEAR}"
}

show_footer() {
    println ""
    print "${GRAY}"
    println " :---------------------------------------------------------"
    println " : Arturo has been successfully installed!"
    println " :"
    println " : To run it, add this to your \$PATH:"
    println " :"
    println " :    export PATH=\$HOME/.arturo/bin:\$PATH"
    println " :"
    println " : Add it to your $SHELL_RC"
    println " : to set it automatically on every shell session."
    println " :"
    println " : Rock on! :)"
    println " :---------------------------------------------------------"
    print "${CLEAR}"
    println ""
}

################################################
# DETECTION
################################################

detect_system() {
    case "$(uname -s)" in
        Linux*)   OS="linux";;
        Darwin*)  OS="macos";;
        FreeBSD*) OS="freebsd";;
        CYGWIN*|MINGW*|MSYS*) OS="windows";;
        *) error "Unsupported OS: $(uname -s)";;
    esac
    
    case "$(uname -m)" in
        x86_64|amd64)  ARCH="amd64";;
        aarch64|arm64) ARCH="arm64";;
        *) error "Unsupported architecture: $(uname -m)";;
    esac
    
    case "$SHELL" in
        */zsh)  SHELL_RC="~/.zshrc";;
        */bash) SHELL_RC="~/.bashrc or ~/.bash_profile";;
        */fish) SHELL_RC="~/.config/fish/config.fish";;
        *)      SHELL_RC="~/.profile";;
    esac
    
    NEEDS_LEGACY=false
    PKG_MANAGER=""
    DISTRO_NAME=""
    
    if [ "$OS" = "freebsd" ]; then
        PKG_MANAGER="pkg"
        DISTRO_NAME="FreeBSD"
    elif [ "$OS" = "macos" ]; then
        PKG_MANAGER="brew"
        DISTRO_NAME="macOS"
    elif [ "$OS" = "windows" ]; then
        DISTRO_NAME="Windows"
    elif [ "$OS" = "linux" ] && [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO_NAME="$NAME"
        
        case "$ID" in
            ubuntu|debian|linuxmint|pop)
                PKG_MANAGER="apt"
                [ "$ID" = "ubuntu" ] && [ "${VERSION_ID%%.*}" -lt 24 ] && NEEDS_LEGACY=true
                [ "$ID" = "debian" ] && [ "${VERSION_ID%%.*}" -lt 13 ] && NEEDS_LEGACY=true
                ;;
            fedora|centos|rhel|almalinux|rocky)
                PKG_MANAGER=$(command_exists dnf && echo "dnf" || echo "yum")
                ;;
            arch|manjaro|endeavouros)
                PKG_MANAGER="pacman"
                ;;
            opensuse*|sles)
                PKG_MANAGER="zypper"
                ;;
            alpine)
                PKG_MANAGER="apk"
                ;;
            void)
                PKG_MANAGER="xbps-install"
                ;;
        esac
    fi
    
    if [ "$OS" = "linux" ] && command_exists ldd; then
        GLIBC_VERSION=$(ldd --version 2>&1 | head -n1 | grep -oP '\d+\.\d+' | head -n1)
        if [ -n "$GLIBC_VERSION" ]; then
            MAJOR=$(echo "$GLIBC_VERSION" | cut -d. -f1)
            MINOR=$(echo "$GLIBC_VERSION" | cut -d. -f2)
            [ "$MAJOR" -lt 2 ] || [ "$MAJOR" -eq 2 -a "$MINOR" -lt 35 ] && NEEDS_LEGACY=true
        fi
    fi
    
    info "os: $OS"
    info "arch: $ARCH"
    info "distro: $DISTRO_NAME"
    info "shell: $(basename "$SHELL")"
}

################################################
# DEPENDENCIES
################################################

check_deps() {
    [ "$BUILD_VARIANT" != "full" ] && return
    
    MISSING_PACKAGES=""
    
    case "$OS:$PKG_MANAGER" in
        linux:apt)
            PKG=$([ "$NEEDS_LEGACY" = true ] && echo "libwebkit2gtk-4.0-37" || echo "libwebkit2gtk-4.1-0")
            dpkg -l 2>/dev/null | grep -q "^ii.*$PKG" || MISSING_PACKAGES="$PKG"
            INSTALL_CMD="sudo apt update && sudo apt install -y"
            ;;
        linux:dnf|linux:yum)
            rpm -q webkit2gtk4.1 >/dev/null 2>&1 || MISSING_PACKAGES="webkit2gtk4.1"
            INSTALL_CMD="sudo $PKG_MANAGER install -y"
            ;;
        linux:pacman)
            pacman -Q webkit2gtk-4.1 >/dev/null 2>&1 || MISSING_PACKAGES="webkit2gtk-4.1"
            INSTALL_CMD="sudo pacman -S --noconfirm"
            ;;
        linux:zypper)
            rpm -q libwebkit2gtk-4_1-0 >/dev/null 2>&1 || MISSING_PACKAGES="libwebkit2gtk-4_1-0"
            INSTALL_CMD="sudo zypper install -y"
            ;;
        linux:apk)
            apk info -e gcompat >/dev/null 2>&1 || MISSING_PACKAGES="gcompat"
            INSTALL_CMD="sudo apk add"
            ;;
        linux:xbps-install)
            INSTALL_CMD="sudo xbps-install -y"
            ;;
        freebsd:pkg)
            for p in webkit2-gtk3 mpfr; do
                pkg info "$p" >/dev/null 2>&1 || MISSING_PACKAGES="$MISSING_PACKAGES $p"
            done
            MISSING_PACKAGES=$(echo "$MISSING_PACKAGES" | xargs)
            INSTALL_CMD="sudo pkg install -y"
            ;;
        macos:brew)
            for p in gmp mpfr; do
                brew list "$p" >/dev/null 2>&1 || MISSING_PACKAGES="$MISSING_PACKAGES $p"
            done
            MISSING_PACKAGES=$(echo "$MISSING_PACKAGES" | xargs)
            INSTALL_CMD="brew install"
            ;;
    esac
    
    if [ -n "$MISSING_PACKAGES" ]; then
        println "\n${CYAN}Note: Missing required packages for full mode:${CLEAR}"
        info "$MISSING_PACKAGES"
        if [ -n "$INSTALL_CMD" ]; then
            println "\n${GREEN}  $INSTALL_CMD $MISSING_PACKAGES${CLEAR}\n"
        fi
    fi
}

################################################
# DOWNLOAD & INSTALL
################################################

get_version() {
    local path=$([ "$VERSION_TYPE" = "latest" ] && echo "latest/" || echo "")
    local version_url="$BASE_URL/${path}files/VERSION"
    VERSION=$(curl -sf "$version_url") || error "Could not fetch version information"
    info "version: $VERSION"
}

build_artifact_name() {
    local prefix=$([ "$VERSION_TYPE" = "latest" ] && echo "nightly" || echo "$VERSION")
    
    ARTIFACT_NAME="arturo-${prefix}-${OS}-${ARCH}"
    [ "$BUILD_VARIANT" != "full" ] && ARTIFACT_NAME="${ARTIFACT_NAME}-${BUILD_VARIANT}"
    [ "$NEEDS_LEGACY" = true ] && ARTIFACT_NAME="${ARTIFACT_NAME}-legacy"
    
    info "artifact: $ARTIFACT_NAME"
}

download_arturo() {
    TMP_DIR=$(mktemp -d 2>/dev/null || mktemp -d -t arturo)
    local path=$([ "$VERSION_TYPE" = "latest" ] && echo "latest/" || echo "")
    local url="$BASE_URL/${path}files/${ARTIFACT_NAME}.zip"
    
    info "downloading: $url"
    curl -fSL "$url" -o "$TMP_DIR/arturo.zip" || error "Download failed. Try --mini variant or check your connection."
    command_exists unzip || error "unzip is required but not installed"
    unzip -q "$TMP_DIR/arturo.zip" -d "$TMP_DIR" || error "Failed to extract archive"
}

install_arturo() {
    mkdir -p "$BIN_DIR" || error "Could not create installation directory"
    
    [ -f "$TMP_DIR/arturo" ] && cp "$TMP_DIR/arturo" "$BIN_DIR/" && chmod +x "$BIN_DIR/arturo"
    [ -f "$TMP_DIR/arturo.exe" ] && cp "$TMP_DIR/arturo.exe" "$BIN_DIR/"
    [ -f "$TMP_DIR/cacert.pem" ] && cp "$TMP_DIR/cacert.pem" "$BIN_DIR/"
    
    for dll in "$TMP_DIR"/*.dll; do
        [ -f "$dll" ] && cp "$dll" "$BIN_DIR/"
    done
    
    [ ! -f "$BIN_DIR/arturo" ] && [ ! -f "$BIN_DIR/arturo.exe" ] && error "Binary not found in archive"
}

################################################
# MAIN
################################################

main() {
    show_header
    
    section "Checking environment..."
    println ""
    detect_system
    
    section "Resolving version..."
    get_version
    build_artifact_name
    
    section "Checking dependencies..."
    check_deps
    
    section "Downloading..."
    download_arturo
    
    section "Installing..."
    install_arturo
    
    section "Done!"
    show_footer
}

main