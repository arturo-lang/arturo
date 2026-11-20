
{. push used .}

proc miniBuildConfig() =
    --define:MINI

proc webBuildConfig() =
    --define:WEB

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