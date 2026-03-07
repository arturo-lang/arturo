
{. push used .}

proc miniBuildConfig() =
    --define:MINI

proc webBuildConfig() =
    --define:WEB

proc fullBuildConfig() =
    --define:GMP
    --define:useOpenssl3
    --define:ssl
    --define:DOCGEN

    --define:CLIPBOARD
    --define:DIALOGS
    --define:PARSERS
    --define:SQLITE
    --define:WEBVIEW

proc bundleConfig() =
    --define:BUNDLE
    #--define:NOERRORLINES

{. pop .}