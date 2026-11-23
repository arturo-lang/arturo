
{. push used .}

proc miniBuildConfig() =
    --define:MINI

proc webBuildConfig() =
    --define:WEB

proc wasiBuildConfig() =
    # WebAssembly, via WASI (preview 1): a 32-bit
    # target, as far as Nim (& Arturo) are concerned
    --define:WASI
    --define:bit32
    --cpu:wasm32
    --os:linux

proc fullBuildConfig(withUI = true) =
    --define:GMP
    --define:useOpenssl3
    --define:ssl
    --define:DOCGEN

    --define:PARSERS
    --define:SQLITE

    if withUI:
        --define:CLIPBOARD
        --define:DIALOGS
        --define:WEBVIEW
    else:
        --define:NOUI

proc bundleConfig() =
    --define:BUNDLE
    #--define:NOERRORLINES

{. pop .}