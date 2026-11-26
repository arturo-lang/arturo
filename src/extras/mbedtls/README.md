# mbedTLS (vendored)

[Mbed TLS](https://github.com/Mbed-TLS/mbedtls) **3.6.8 LTS**, from the official
release tarball `mbedtls-3.6.8.tar.bz2`
(sha256 `bc54b818e87f49c0b3281dd85d24adaede0e63b4e822e3fbd49c005a38b9595b`).
Apache-2.0 (see `LICENSE`).

Only part of it is here:

- `include/mbedtls/`, `include/psa/` - the public headers, unchanged, except for
  `include/mbedtls/mbedtls_config.h`, which is our own trimmed configuration
- `library/*.h` - the private headers, unchanged
- `library/*.c` - only the sources that compile to something with our
  configuration (+ `aesce.c` & `padlock.c`, which only do on arm64 / x86)

Everything is compiled through `src/extras/tls.nim` (via `{.compile.}`),
so there is no separate build step.

## Updating

1. Download the new release tarball and check it against its `*-sha256sum.txt`
2. Replace `include/mbedtls`, `include/psa` and `library/*.h`
3. Replace the `library/*.c` files listed in `src/extras/tls.nim`
   (and check whether new ones are needed: compile each `library/*.c`
   with our config and keep the ones with any symbols in them)
4. Re-apply our `mbedtls_config.h` (compare with the new default one)
