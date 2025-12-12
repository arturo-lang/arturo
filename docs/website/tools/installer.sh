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

REPO="arturo-lang/arturo"
INSTALL_DIR="$HOME/.arturo"
BIN_DIR="$INSTALL_DIR/bin"
TMP_DIR=""

VERSION_TYPE="release"
BUILD_VARIANT="full"

for arg in "$@"; do
    case $arg in
        --nightly|-n) VERSION_TYPE="nightly"; REPO="arturo-lang/nightly";;
        --mini|-m)    BUILD_VARIANT="mini";;
    esac
done

################################################
# COLORS
################################################

RED='\033[0;31m'
GREEN='\033[1;32m'
BLUE='\033[0;34m'
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

detect_os() {
    case "$(uname -s)" in
        Linux*)     OS="linux";;
        Darwin*)    OS="macos";;
        FreeBSD*)   OS="freebsd";;
        CYGWIN*|MINGW*|MSYS*) OS="windows";;
        *)          error "Unsupported OS: $(uname -s)";;
    esac
    
    info "os: $OS"
}

detect_arch() {
    case "$(uname -m)" in
        x86_64|amd64)   ARCH="amd64";;
        aarch64|arm64)  ARCH="arm64";;
        *)              error "Unsupported architecture: $(uname -m)";;
    esac
    
    info "arch: $ARCH"
}

detect_shell() {
    case "$SHELL" in
        */zsh)  SHELL_RC="~/.zshrc";;
        */bash) SHELL_RC="~/.bashrc or ~/.bash_profile";;
        */fish) SHELL_RC="~/.config/fish/config.fish";;
        *)      SHELL_RC="~/.profile";;
    esac
    
    info "shell: $(basename "$SHELL")"
}

detect_distro() {
    DISTRO="unknown"
    DISTRO_VERSION=""
    NEEDS_LEGACY=false
    
    if [ "$OS" != "linux" ]; then
        return
    fi
    
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO="$ID"
        DISTRO_VERSION="$VERSION_ID"
        
        case "$DISTRO" in
            ubuntu)
                info "distro: Ubuntu $DISTRO_VERSION"
                if [ "${DISTRO_VERSION%%.*}" -lt 24 ]; then
                    NEEDS_LEGACY=true
                fi
                ;;
            debian)
                info "distro: Debian $DISTRO_VERSION"
                if [ "${DISTRO_VERSION%%.*}" -lt 13 ]; then
                    NEEDS_LEGACY=true
                fi
                ;;
            fedora|centos|rhel|almalinux|rocky)
                info "distro: $NAME $DISTRO_VERSION"
                ;;
            arch|opensuse*|alpine|void)
                info "distro: $NAME"
                ;;
            *)
                info "distro: $NAME (generic)"
                ;;
        esac
    else
        info "distro: unknown (generic Linux)"
    fi
}

check_glibc() {
    if [ "$OS" != "linux" ]; then
        return
    fi
    
    if ! command_exists ldd; then
        return
    fi
    
    GLIBC_VERSION=$(ldd --version 2>&1 | head -n1 | grep -oP '\d+\.\d+' | head -n1)
    
    if [ -n "$GLIBC_VERSION" ]; then
        info "glibc: $GLIBC_VERSION"
        
        MAJOR=$(echo "$GLIBC_VERSION" | cut -d. -f1)
        MINOR=$(echo "$GLIBC_VERSION" | cut -d. -f2)
        
        if [ "$MAJOR" -lt 2 ] || ([ "$MAJOR" -eq 2 ] && [ "$MINOR" -lt 35 ]); then
            NEEDS_LEGACY=true
        fi
    fi
}

################################################
# DEPENDENCIES
################################################

check_dependencies() {
    local missing=""
    
    case "$OS" in
        linux)
            if [ "$BUILD_VARIANT" = "full" ]; then
                case "$DISTRO" in
                    ubuntu|debian)
                        if [ "$NEEDS_LEGACY" = true ]; then
                            PKG="libwebkit2gtk-4.0-37"
                        else
                            PKG="libwebkit2gtk-4.1-0"
                        fi
                        if ! dpkg -l | grep -q "$PKG"; then
                            missing="$PKG"
                        fi
                        ;;
                    fedora|centos|rhel|almalinux|rocky)
                        if ! rpm -q webkit2gtk4.1 >/dev/null 2>&1; then
                            missing="webkit2gtk4.1"
                        fi
                        ;;
                    arch)
                        if ! pacman -Q webkit2gtk-4.1 >/dev/null 2>&1; then
                            missing="webkit2gtk-4.1"
                        fi
                        ;;
                    opensuse*)
                        if ! rpm -q libwebkit2gtk-4_1-0 >/dev/null 2>&1; then
                            missing="libwebkit2gtk-4_1-0"
                        fi
                        ;;
                esac
            fi
            ;;
        freebsd)
            if [ "$BUILD_VARIANT" = "full" ]; then
                if ! pkg info webkit2-gtk3 >/dev/null 2>&1; then
                    missing="webkit2-gtk3 mpfr"
                fi
            fi
            ;;
        macos)
            if [ "$BUILD_VARIANT" = "full" ]; then
                if ! command_exists brew; then
                    missing="homebrew (visit https://brew.sh)"
                elif ! brew list gmp >/dev/null 2>&1 || ! brew list mpfr >/dev/null 2>&1; then
                    missing="gmp mpfr"
                fi
            fi
            ;;
    esac
    
    if [ -n "$missing" ]; then
        println "\n${CYAN}Note: The following packages are required:${CLEAR}"
        info "$missing"
        println "\n${GRAY}Install them with your package manager before running Arturo.${CLEAR}\n"
    fi
}

################################################
# DOWNLOAD
################################################

get_latest_release() {
    local api_url="https://api.github.com/repos/$REPO/releases"
    
    if [ "$VERSION_TYPE" = "nightly" ]; then
        RELEASE_TAG=$(curl -sf "$api_url" | grep '"tag_name"' | grep -o '[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}' | head -n1)
    else
        RELEASE_TAG=$(curl -sf "$api_url/latest" | grep '"tag_name"' | sed -E 's/.*"tag_name": "([^"]+)".*/\1/')
    fi
    
    [ -z "$RELEASE_TAG" ] && error "Could not determine latest release"
    
    info "version: $RELEASE_TAG"
}

build_artifact_name() {
    local base="arturo"
    local version_str=""
    
    if [ "$VERSION_TYPE" = "nightly" ]; then
        version_str="-nightly.$(echo "$RELEASE_TAG" | tr -d '-')"
    else
        version_str="-$RELEASE_TAG"
    fi
    
    ARTIFACT_NAME="${base}${version_str}-${OS}-${ARCH}"
    
    [ "$BUILD_VARIANT" != "full" ] && ARTIFACT_NAME="${ARTIFACT_NAME}-${BUILD_VARIANT}"
    [ "$NEEDS_LEGACY" = true ] && ARTIFACT_NAME="${ARTIFACT_NAME}-legacy"
    
    info "artifact: $ARTIFACT_NAME"
}

download_arturo() {
    TMP_DIR=$(mktemp -d 2>/dev/null || mktemp -d -t arturo)
    
    local download_url="https://github.com/$REPO/releases/download/$RELEASE_TAG/${ARTIFACT_NAME}.zip"
    
    info "downloading from: $download_url"
    
    if ! curl -fSL "$download_url" -o "$TMP_DIR/arturo.zip"; then
        error "Download failed. Please check your connection or try --mini variant."
    fi
    
    if ! command_exists unzip; then
        error "unzip is required but not installed"
    fi
    
    unzip -q "$TMP_DIR/arturo.zip" -d "$TMP_DIR" || error "Failed to extract archive"
}

################################################
# INSTALLATION
################################################

install_arturo() {
    mkdir -p "$BIN_DIR" || error "Could not create installation directory"
    
    if [ -f "$TMP_DIR/arturo" ]; then
        cp "$TMP_DIR/arturo" "$BIN_DIR/" || error "Installation failed"
        chmod +x "$BIN_DIR/arturo"
    elif [ -f "$TMP_DIR/arturo.exe" ]; then
        cp "$TMP_DIR/arturo.exe" "$BIN_DIR/" || error "Installation failed"
    else
        error "Binary not found in archive"
    fi
    
    if [ -f "$TMP_DIR/cacert.pem" ]; then
        cp "$TMP_DIR/cacert.pem" "$BIN_DIR/"
    fi
    
    for dll in "$TMP_DIR"/*.dll; do
        [ -f "$dll" ] && cp "$dll" "$BIN_DIR/"
    done
}

################################################
# MAIN
################################################

main() {
    show_header
    
    section "Checking environment..."
    println ""
    detect_os
    detect_arch
    detect_shell
    detect_distro
    check_glibc
    
    section "Resolving version..."
    get_latest_release
    build_artifact_name
    
    section "Checking dependencies..."
    check_dependencies
    
    section "Downloading..."
    download_arturo
    
    section "Installing..."
    install_arturo
    
    section "Done!"
    show_footer
}

main