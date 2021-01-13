panic() {
    printf "$@\n" >&2
    exit 1
}

create_directory() {
    if [ ! -d "$1" ]; then
        if ! mkdir -p "$1" 2>/dev/null; then
            panic "Cannot create directory: $1."
        fi
    fi
}

create_tmp_directory() {
    ARTURO_TMP_DIR="$(mktemp -d 2>/dev/null || mktemp -d -t art)"
}

cleanup_tmp_directory() {
    if [ -n "$ARTURO_TEMP_DIR" ] ; then
        rm -rf "$ARTURO_TEMP_DIR"
        ARTURO_TEMP_DIR=""
    fi
}

install_prerequisites() {
    wget -qO - https://nim-lang.org/choosenim/init.sh | bash -s -- -y
    export PATH="$HOME/.nimble/bin:$PATH"

    case "$(uname)" in
        "Linux")
            sudo apt-fast update
            sudo apt-fast install -yq libgtk-3-dev libwebkit2gtk-4.0-dev
            ;;
        *)
            ;;
    esac
}

install_arturo() {
    cd $ARTURO_TMP_DIR
    git clone https://github.com/arturo-lang/arturo.git
    cd arturo
    ./build.sh install
}

main() {
    trap cleanup_tmp_directory EXIT
    create_tmp_directory
    install_prerequisites
    install_arturo
}

main