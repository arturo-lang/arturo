#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: extras/tls.nim
#=======================================================

## TLS through the vendored mbedTLS (extras/mbedtls),
## behind a minimal OpenSSL-compatible API (tls/openssl_compat.c),
## so that Nim's std/net, std/asyncnet & std/httpclient
## work unchanged on top of it (with `--dynlibOverride:ssl`,
## see `configSSL` in config.nims)
##
## CA certificates come from the bundle embedded below

#=======================================
# Libraries
#=======================================

import std/[macros, os]

#=======================================
# Compilation & Linking
#=======================================

const
    mbedtlsDir = currentSourcePath().parentDir() / "mbedtls"
    tlsDir = currentSourcePath().parentDir() / "tls"

    mbedtlsSources = [
        "aes", "aesce", "aesni", "asn1parse", "asn1write", "base64",
        "bignum", "bignum_core", "chacha20", "chachapoly", "cipher",
        "cipher_wrap", "constant_time", "ctr_drbg", "dhm", "ecdh", "ecdsa",
        "ecp", "ecp_curves", "entropy", "entropy_poll", "error", "gcm",
        "hkdf", "md", "md5", "mps_reader", "oid", "padlock", "pem", "pk",
        "pk_ecc", "pk_wrap", "pkparse", "platform", "platform_util",
        "poly1305", "psa_crypto", "psa_crypto_aead", "psa_crypto_cipher",
        "psa_crypto_client", "psa_crypto_driver_wrappers_no_static",
        "psa_crypto_ecp", "psa_crypto_ffdh", "psa_crypto_hash", "psa_crypto_mac",
        "psa_crypto_random", "psa_crypto_rsa", "psa_crypto_slot_management",
        "psa_util", "rsa", "rsa_alt_helpers", "sha1", "sha256", "sha512",
        "ssl_ciphersuites", "ssl_client", "ssl_msg", "ssl_tls",
        "ssl_tls12_client", "ssl_tls13_client", "ssl_tls13_generic",
        "ssl_tls13_keys", "x509", "x509_crt"
    ]

macro compileMbedtls(): untyped =
    result = newStmtList()
    for src in mbedtlsSources:
        result.add nnkPragma.newTree(
            nnkExprColonExpr.newTree(
                ident("compile"),
                newLit(mbedtlsDir / "library" / (src & ".c"))
            )
        )

{.passC: "-I" & (mbedtlsDir / "include").}

compileMbedtls()

{.compile: tlsDir / "openssl_compat.c".}

when defined(windows):
    {.passL: "-lws2_32 -lbcrypt".}

#=======================================
# Embedded CA certificates
#=======================================

const EmbeddedCACerts = staticRead(tlsDir / "cacert.pem")

proc embeddedCACerts(): cstring {.exportc: "arturo_embedded_cacert", cdecl.} =
    ## The embedded (Mozilla) CA bundle, in PEM
    ## (used by tls/openssl_compat.c)
    EmbeddedCACerts.cstring
