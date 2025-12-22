#!/usr/bin/env nim
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

BASE_URL="http://188.245.97.105"
INSTALL_DIR="$HOME/.arturo"
BIN_DIR="$INSTALL_DIR/bin"
TMP_DIR=""

VERSION_TYPE="latest"
BUILD_VARIANT="full"

for arg in "$@"; do
    case $arg in
        --mini|-m) BUILD_VARIANT="mini";;
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
WHITE='\033[1m'
CLEAR='\033[0m'

################################################
# UTILITIES
################################################

print() { printf "%b" "$1"; }
println() { printf "%b\n" "$1"; }
error() { println " ${RED}✗ $1${CLEAR}" >&2; exit 1; }
info() { println "${GRAY}      $1${CLEAR}"; }
info2() { print "${GRAY}      $1${CLEAR}"; }
section() { println "\n ${MAGENTA}●${CLEAR} $1"; }
command_exists() { command -v "$1" >/dev/null 2>&1; }

fetch() {
    local url="$1"
    local output="$2"
    
    if [ "$DOWNLOAD_TOOL" = "curl" ]; then
        if [ "$output" = "-" ]; then
            curl -sf "$url"
        else
            curl -fsSL "$url" -o "$output"
        fi
    else
        wget -qO "$output" "$url"
    fi
}

cleanup() {
    [ -n "$TMP_DIR" ] && [ -d "$TMP_DIR" ] && rm -rf "$TMP_DIR"
}
trap cleanup EXIT INT TERM

show_spinner() {
    local pid=$1
    local message=$2
    local spin='|/-\'
    local i=0
    
    # Only show spinner if we have a proper terminal
    if [ -t 1 ] 2>/dev/null; then
        printf " %s " "$message"
        while kill -0 $pid 2>/dev/null; do
            case $i in
                0) c='|' ;;
                1) c='/' ;;
                2) c='-' ;;
                3) c='\' ;;
            esac
            printf "\b${GRAY}%s${CLEAR}" "$c"
            i=$(( (i+1) % 4 ))
            sleep 0.1
        done
        printf "\b \b"  # Clear spinner
    fi
    wait $pid
    return $?
}

show_header() {
    println "${GREEN}              _                    "
    println "             | |                   "
    println "    __ _ _ __| |_ _   _ _ __ ___   "
    println "   / _\` | '__| __| | | | '__/ _ \\\\ "
    println "  | (_| | |  | |_| |_| | | | (_) | "
    println "   \\\\__,_|_|   \\\\__|\\\\__,_|_|  \\\\___/  ${CLEAR}"
    println "   (c)2019-2025 Yanis Zafirópulos"
    println "${CYAN}"
    println "======================================================="
    println " ► Installer"
    println "======================================================="
    print "${CLEAR}"
}

show_footer() {
    println "${CYAN}"
    println "======================================================="
    println " ► Quick setup"
    println "======================================================="
    println "${CLEAR}"
    println "   Arturo has been successfully installed!"
    println "  "
    println "   To be able to run it from anywhere,"
    println "   update your \$PATH:"
    println "       ${GRAY}export PATH=\$HOME/.arturo/bin:\$PATH${CLEAR}"
    println "  "
    println "   Add it to your $SHELL_RC"
    println "   to set it automatically on every shell session."
    println "  "
    if [ -n "$MISSING_PACKAGES" ]; then
        if [ -n "$INSTALL_CMD" ]; then
            println "   To install missing dependencies:"
            println "       ${GRAY}$INSTALL_CMD $MISSING_PACKAGES${CLEAR}\n"
        fi
    fi

    println "   Rock on! 🤘"
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
    
    # Detect download tool
    if command_exists curl; then
        DOWNLOAD_TOOL="curl"
    elif command_exists wget; then
        DOWNLOAD_TOOL="wget"
    else
        error "curl/wget required but not found. Please install one of them first to be able to continue."
    fi
    
    NEEDS_LEGACY=false
    PKG_MANAGER=""
    DISTRO_NAME=""
    
    if [ "$OS" = "freebsd" ]; then
        PKG_MANAGER="pkg"
    elif [ "$OS" = "macos" ]; then
        PKG_MANAGER="brew"  # Default

        for p in gmp mpfr; do
            if (command_exists port || [ -x /opt/local/bin/port ]) && \
            (port installed "$p" 2>/dev/null || /opt/local/bin/port installed "$p" 2>/dev/null) | grep -q "^  $p @"; then
                PKG_MANAGER="port"
                break
            fi
        done
        
        if [ "$PKG_MANAGER" = "brew" ] && ! command_exists brew; then
            if command_exists port || [ -x /opt/local/bin/port ]; then
                PKG_MANAGER="port"
            fi
        fi
    elif [ "$OS" = "linux" ] && [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO_NAME="$NAME"
        
        case "$ID" in
            ubuntu|debian|linuxmint|pop)
                PKG_MANAGER="apt"
                if [ "$ID" = "ubuntu" ]; then
                    [ "${VERSION_ID%%.*}" -lt 24 ] && NEEDS_LEGACY=true
                fi
                if [ "$ID" = "debian" ]; then
                    [ "${VERSION_ID%%.*}" -lt 13 ] && NEEDS_LEGACY=true
                fi
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
            if [ "$MAJOR" -lt 2 ] || [ "$MAJOR" -eq 2 -a "$MINOR" -lt 35 ]; then
                NEEDS_LEGACY=true
            fi
        fi
    fi
    
    info "os: $OS"
    info "arch: $ARCH"
    if [ "$OS" = "linux" ]; then
        info "distro: $DISTRO_NAME"
    fi
    info "shell: $(basename "$SHELL")"
    info "downloader: $DOWNLOAD_TOOL"
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
            INSTALL_CMD="sudo pacman -Syu --noconfirm"
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
            for p in webkit2-gtk_41 mpfr; do
                pkg info "$p" >/dev/null 2>&1 || MISSING_PACKAGES="$MISSING_PACKAGES $p"
            done
            MISSING_PACKAGES=$(echo "$MISSING_PACKAGES" | xargs)
            INSTALL_CMD="pkg install -y"
            ;;
        macos:brew)
            for p in gmp mpfr; do
                brew list "$p" >/dev/null 2>&1 || MISSING_PACKAGES="$MISSING_PACKAGES $p"
            done
            MISSING_PACKAGES=$(echo "$MISSING_PACKAGES" | xargs)
            
            if [ -n "$MISSING_PACKAGES" ]; then
                if ! command_exists brew; then
                    INSTALL_CMD="/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\" && brew install"
                else
                    INSTALL_CMD="brew install"
                fi
            fi
            ;;
        macos:port)
            for p in gmp mpfr; do
                (port installed "$p" 2>/dev/null || /opt/local/bin/port installed "$p" 2>/dev/null) | grep -q "^  $p @" || MISSING_PACKAGES="$MISSING_PACKAGES $p"
            done
            MISSING_PACKAGES=$(echo "$MISSING_PACKAGES" | xargs)
            [ -n "$MISSING_PACKAGES" ] && INSTALL_CMD="sudo port install"
            ;;
    esac
    
    if [ -n "$MISSING_PACKAGES" ]; then
        info "required packages:${CLEAR}"
        info "    $MISSING_PACKAGES"
    fi
}

################################################
# DOWNLOAD & INSTALL
################################################

get_version() {
    local path=$([ "$VERSION_TYPE" = "latest" ] && echo "latest/" || echo "")
    local version_url="$BASE_URL/${path}files/VERSION"

    VERSION=$(fetch "$version_url" -) || error "Could not fetch version information"
    info "version: $VERSION"
}

download_arturo() {
    ARTIFACT_NAME="arturo-${VERSION}-${OS}-${ARCH}"
    [ "$BUILD_VARIANT" != "full" ] && ARTIFACT_NAME="${ARTIFACT_NAME}-${BUILD_VARIANT}"
    [ "$NEEDS_LEGACY" = true ] && ARTIFACT_NAME="${ARTIFACT_NAME}-legacy"

    TMP_DIR=$(mktemp -d 2>/dev/null || mktemp -d -t arturo)
    local path=$([ "$VERSION_TYPE" = "latest" ] && echo "latest/" || echo "")
    local url="${path}files/${ARTIFACT_NAME}.zip"
    
    info2 "archive: $url"

    url="$BASE_URL/$url"

    fetch "$url" "$TMP_DIR/arturo.zip" 2>&1 &
    show_spinner $! "" || error "Download failed. Something went wrong, please check your connection."
    println ""
    
    if command_exists unzip; then
        unzip -q "$TMP_DIR/arturo.zip" -d "$TMP_DIR" || error "Failed to extract archive"
    elif command_exists python3; then
        python3 -m zipfile -e "$TMP_DIR/arturo.zip" "$TMP_DIR" || error "Failed to extract archive"
    elif command_exists python; then
        python -m zipfile -e "$TMP_DIR/arturo.zip" "$TMP_DIR" || error "Failed to extract archive"
    else
        error "unzip required but not found. Please install it first to be able to continue."
    fi
}

install_arturo() {
    info "into: ${BIN_DIR}"
    mkdir -p "$BIN_DIR" || error "Could not create installation directory"
    
    if [ -f "$TMP_DIR/arturo" ]; then
        cp "$TMP_DIR/arturo" "$BIN_DIR/" || error "Failed to copy arturo binary"
        chmod +x "$BIN_DIR/arturo" || error "Failed to make arturo executable"
    fi
    
    if [ -f "$TMP_DIR/arturo.exe" ]; then
        cp "$TMP_DIR/arturo.exe" "$BIN_DIR/" || error "Failed to copy arturo.exe"
    fi
    
    if [ -f "$TMP_DIR/cacert.pem" ]; then
        cp "$TMP_DIR/cacert.pem" "$BIN_DIR/" || error "Failed to copy cacert.pem"
    fi
    
    if ls "$TMP_DIR"/*.dll 1> /dev/null 2>&1; then
        cp "$TMP_DIR"/*.dll "$BIN_DIR/" || error "Failed to copy DLL files"
    fi
    
    if [ ! -f "$BIN_DIR/arturo" ] && [ ! -f "$BIN_DIR/arturo.exe" ]; then
        error "Binary not found in archive"
    fi
}

################################################
# MAIN
################################################

main() {
    show_header
    
    section "Checking environment..."
    detect_system
    
    section "Resolving version..."
    get_version

    section "Downloading..."
    download_arturo
    
    section "Checking dependencies..."
    check_deps
    
    section "Installing..."
    install_arturo
    
    section "Done! ✓"
    show_footer
}

main