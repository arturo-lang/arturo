#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: extras/tls/ssl_certs.nim
#=======================================================

## Replaces Nim's std/ssl_certs (see `configSSL` in config.nims)
##
## Nim's `newContext` looks for CA certificates by trying each
## path this yields, with `SSL_CTX_load_verify_locations`.
## Instead of scanning the system's usual locations, we always
## point it to the CA bundle embedded in the binary
## (see extras/tls.nim & extras/tls/openssl_compat.c)

import std/os

const EmbeddedCACertsMarker* = "ARTURO_EMBEDDED_CACERT"

iterator scanSSLCertificates*(useEnvVars = false): string =
    ## Yields the embedded CA bundle's marker; with `useEnvVars`
    ## (i.e. `CVerifyPeerUseEnvVars`), SSL_CERT_FILE comes first
    if useEnvVars and existsEnv("SSL_CERT_FILE"):
        yield getEnv("SSL_CERT_FILE")

    yield EmbeddedCACertsMarker
