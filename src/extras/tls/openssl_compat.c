/*=======================================================
 * Arturo
 * Programming Language + Bytecode VM compiler
 * (c) 2019-2026 Yanis Zafirópulos
 *
 * @file: extras/tls/openssl_compat.c
 *=======================================================*/

/*
 * A minimal OpenSSL-compatible API on top of mbedTLS
 *
 * Implements exactly the (client-side) subset of OpenSSL that
 * Nim's std/net, std/asyncnet & std/httpclient use, so that they
 * work unchanged, with `-d:ssl --dynlibOverride:ssl`, on top of
 * the vendored mbedTLS (see ../mbedtls)
 *
 * - SSL_set_fd: blocking/non-blocking sockets (std/net)
 * - SSL_set_bio + memory BIOs (std/asyncnet)
 * - CA certificates: the embedded Mozilla bundle (see ../tls.nim
 *   and ssl_certs.nim), plus any file explicitly given
 * - no server side
 */

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

#ifdef _WIN32
    #include <winsock2.h>
    #include <ws2tcpip.h>
#else
    #include <sys/types.h>
    #include <sys/socket.h>
#endif

#include "mbedtls/ssl.h"
#include "mbedtls/x509_crt.h"
#include "mbedtls/pk.h"
#include "mbedtls/error.h"
#include "mbedtls/platform_util.h"
#include "mbedtls/net_sockets.h"
#include "mbedtls/psa_util.h"
#include "psa/crypto.h"

/*=======================================
 * Constants (as in OpenSSL)
 *=======================================*/

#define SSL_ERROR_NONE          0
#define SSL_ERROR_SSL           1
#define SSL_ERROR_WANT_READ     2
#define SSL_ERROR_WANT_WRITE    3
#define SSL_ERROR_SYSCALL       5
#define SSL_ERROR_ZERO_RETURN   6

#define SSL_VERIFY_PEER         0x01

#define SSL_CTRL_MODE                   33
#define SSL_CTRL_SET_TLSEXT_HOSTNAME    55
#define SSL_CTRL_SET_ECDH_AUTO          94

/* what Nim's (patched) scanSSLCertificates yields */
#define EMBEDDED_CA_MARKER      "ARTURO_EMBEDDED_CACERT"

/* provided by tls.nim */
extern const char* arturo_embedded_cacert(void);

#if defined(_MSC_VER)
    #define THREAD_LOCAL __declspec(thread)
#else
    #define THREAD_LOCAL __thread
#endif

/*=======================================
 * Types
 *=======================================*/

typedef struct bio_st {
    unsigned char*  data;
    size_t          off;
    size_t          len;
    size_t          cap;
} BIO;

typedef struct ssl_ctx_st {
    mbedtls_ssl_config  conf;
    mbedtls_x509_crt    ca;
    mbedtls_x509_crt    ownCert;
    mbedtls_pk_context  ownKey;
    int                 verifyMode;
    long                mode;
    int                 useEmbedded;
    int                 hasCA;
    int                 hasCert;
    int                 hasKey;
    int                 embeddedMerged;
} SSL_CTX;

typedef struct ssl_st {
    SSL_CTX*            ctx;
    mbedtls_ssl_context ssl;
    intptr_t            fd;
    BIO*                rbio;
    BIO*                wbio;
    int                 lastError;
    int                 hostnameSet;
    int                 isServer;
    int                 shutdown;
    int                 eof;            /* 1: close_notify, 2: EOF without it */
} SSL;

typedef struct x509_st {
    mbedtls_x509_crt*   crt;
} X509;

typedef struct { int unused; } SSL_METHOD;
typedef struct { int unused; } BIO_METHOD;

static SSL_METHOD   tlsMethod;
static BIO_METHOD   memMethod;

/*=======================================
 * Error queue (just the last one)
 *=======================================*/

static THREAD_LOCAL unsigned long   lastErr = 0;
static THREAD_LOCAL char            lastErrStr[320];

static void clearError(void) {
    lastErr = 0;
    lastErrStr[0] = 0;
}

static void setErrorMsg(unsigned long code, const char* msg) {
    lastErr = code ? code : 1;
    snprintf(lastErrStr, sizeof(lastErrStr), "%s", msg);
}

static void setError(int ret, uint32_t verifyFlags) {
    char buf[200];
    mbedtls_strerror(ret, buf, sizeof(buf));

    if (ret == MBEDTLS_ERR_X509_CERT_VERIFY_FAILED && verifyFlags != 0 && verifyFlags != (uint32_t)-1) {
        char info[256];
        int n = mbedtls_x509_crt_verify_info(info, sizeof(info), "", verifyFlags);
        if (n < 0) info[0] = 0;
        /* one line: "a\nb\n" -> "a; b" */
        for (char* p = info; *p; p++) {
            if (*p == '\n') *p = (p[1] ? ';' : 0);
        }
        char msg[320];
        snprintf(msg, sizeof(msg), "certificate verify failed: %s", info);
        setErrorMsg((unsigned long)(-ret), msg);
    }
    else {
        setErrorMsg((unsigned long)(-ret), buf);
    }
}

void ERR_clear_error(void) {
    clearError();
}

unsigned long ERR_peek_last_error(void) {
    return lastErr;
}

char* ERR_error_string(unsigned long e, char* buf) {
    static THREAD_LOCAL char out[320];
    char* dst = buf ? buf : out;
    size_t sz = buf ? 256 : sizeof(out);     /* OpenSSL: buf must be >= 256 */

    if (e != 0 && e == lastErr && lastErrStr[0])
        snprintf(dst, sz, "%s", lastErrStr);
    else
        snprintf(dst, sz, "TLS error 0x%lx", e);

    return dst;
}

/*=======================================
 * Initialization & helpers
 *=======================================*/

static int ensureInit(void) {
    static int ready = 0;
    if (!ready) {
        if (psa_crypto_init() != PSA_SUCCESS) {
            setErrorMsg(1, "could not initialize the crypto library");
            return 0;
        }
        ready = 1;
    }
    return 1;
}

static mbedtls_x509_crt embeddedCA;
static int              embeddedState = 0;   /* 0: not loaded, 1: ok, -1: failed */

static int parseEmbedded(mbedtls_x509_crt* into) {
    const char* pem = arturo_embedded_cacert();
    if (pem == NULL || pem[0] == 0) return -1;

    int ret = mbedtls_x509_crt_parse(into, (const unsigned char*)pem, strlen(pem) + 1);
    /* > 0: number of certificates that couldn't be parsed (ignored) */
    if (ret < 0) { setError(ret, 0); return -1; }
    return 0;
}

static mbedtls_x509_crt* getEmbeddedCA(void) {
    if (embeddedState == 0) {
        mbedtls_x509_crt_init(&embeddedCA);
        embeddedState = (parseEmbedded(&embeddedCA) == 0) ? 1 : -1;
    }
    return embeddedState == 1 ? &embeddedCA : NULL;
}

/* reads a whole file, NUL-terminated (mbedTLS's PEM parser wants that) */
static unsigned char* readFile(const char* path, size_t* len) {
    FILE* f = fopen(path, "rb");
    if (!f) return NULL;

    unsigned char* buf = NULL;
    size_t cap = 0, n = 0, r;
    do {
        if (cap - n < 4096) {
            size_t ncap = cap ? cap * 2 : 65536;
            unsigned char* nbuf = (unsigned char*)realloc(buf, ncap + 1);
            if (!nbuf) { free(buf); fclose(f); return NULL; }
            buf = nbuf; cap = ncap;
        }
        r = fread(buf + n, 1, cap - n, f);
        n += r;
    } while (r > 0);

    fclose(f);
    buf[n] = 0;
    *len = n + 1;
    return buf;
}

/*=======================================
 * Methods
 *=======================================*/

const SSL_METHOD* TLS_method(void) {
    return &tlsMethod;
}

unsigned long OpenSSL_version_num(void) {
    return 0x30000000UL;    /* behave like OpenSSL 3.0 */
}

/*=======================================
 * SSL_CTX
 *=======================================*/

SSL_CTX* SSL_CTX_new(const SSL_METHOD* method) {
    (void)method;
    clearError();
    if (!ensureInit()) return NULL;

    SSL_CTX* ctx = (SSL_CTX*)calloc(1, sizeof(SSL_CTX));
    if (!ctx) return NULL;

    mbedtls_ssl_config_init(&ctx->conf);
    mbedtls_x509_crt_init(&ctx->ca);
    mbedtls_x509_crt_init(&ctx->ownCert);
    mbedtls_pk_init(&ctx->ownKey);

    int ret = mbedtls_ssl_config_defaults(&ctx->conf, MBEDTLS_SSL_IS_CLIENT,
                                          MBEDTLS_SSL_TRANSPORT_STREAM,
                                          MBEDTLS_SSL_PRESET_DEFAULT);
    if (ret != 0) {
        setError(ret, 0);
        mbedtls_ssl_config_free(&ctx->conf);
        free(ctx);
        return NULL;
    }

    mbedtls_ssl_conf_rng(&ctx->conf, mbedtls_psa_get_random, MBEDTLS_PSA_RANDOM_STATE);
    mbedtls_ssl_conf_authmode(&ctx->conf, MBEDTLS_SSL_VERIFY_NONE);   /* OpenSSL's default */

    /* like OpenSSL 3 (security level 2): no DHE groups below 2048 bits */
    mbedtls_ssl_conf_dhm_min_bitlen(&ctx->conf, 2048);

    return ctx;
}

void SSL_CTX_free(SSL_CTX* ctx) {
    if (!ctx) return;
    mbedtls_ssl_config_free(&ctx->conf);
    mbedtls_x509_crt_free(&ctx->ca);
    mbedtls_x509_crt_free(&ctx->ownCert);
    mbedtls_pk_free(&ctx->ownKey);
    free(ctx);
}

long SSL_CTX_ctrl(SSL_CTX* ctx, int cmd, long larg, void* parg) {
    (void)parg;
    switch (cmd) {
        case SSL_CTRL_MODE:
            ctx->mode |= larg;
            return ctx->mode;
        case SSL_CTRL_SET_ECDH_AUTO:
            return 1;
        default:
            return 0;
    }
}

/* mbedTLS picks its own (modern) ciphersuites */
int SSL_CTX_set_cipher_list(SSL_CTX* ctx, const char* str) {
    (void)ctx; (void)str;
    return 1;
}

int SSL_CTX_set_ciphersuites(SSL_CTX* ctx, const char* str) {
    (void)ctx; (void)str;
    return 1;
}

void SSL_CTX_set_verify(SSL_CTX* ctx, intptr_t mode, void* callback) {
    (void)callback;
    ctx->verifyMode = (int)(mode & SSL_VERIFY_PEER);
    mbedtls_ssl_conf_authmode(&ctx->conf, ctx->verifyMode ? MBEDTLS_SSL_VERIFY_REQUIRED
                                                           : MBEDTLS_SSL_VERIFY_NONE);
}

int SSL_CTX_load_verify_locations(SSL_CTX* ctx, const char* file, const char* path) {
    clearError();

    if (file != NULL) {
        if (strcmp(file, EMBEDDED_CA_MARKER) == 0) {
            if (getEmbeddedCA() == NULL) return 0;
            ctx->useEmbedded = 1;
            return 1;
        }

        size_t len;
        unsigned char* buf = readFile(file, &len);
        if (!buf) {
            setErrorMsg(1, "could not read CA certificate file");
            return 0;
        }
        int ret = mbedtls_x509_crt_parse(&ctx->ca, buf, len);
        free(buf);
        if (ret < 0) { setError(ret, 0); return 0; }
        ctx->hasCA = 1;
        return 1;
    }

    /* CA directories (hashed links) are not supported */
    (void)path;
    setErrorMsg(1, "CA certificate directories are not supported");
    return 0;
}

int SSL_CTX_use_certificate_chain_file(SSL_CTX* ctx, const char* file) {
    clearError();
    size_t len;
    unsigned char* buf = readFile(file, &len);
    if (!buf) {
        setErrorMsg(1, "could not read certificate file");
        return 0;
    }
    int ret = mbedtls_x509_crt_parse(&ctx->ownCert, buf, len);
    free(buf);
    if (ret != 0) { setError(ret < 0 ? ret : MBEDTLS_ERR_X509_INVALID_FORMAT, 0); return 0; }
    ctx->hasCert = 1;

    if (ctx->hasKey) {
        ret = mbedtls_ssl_conf_own_cert(&ctx->conf, &ctx->ownCert, &ctx->ownKey);
        if (ret != 0) { setError(ret, 0); return 0; }
    }
    return 1;
}

int SSL_CTX_use_PrivateKey_file(SSL_CTX* ctx, const char* file, int type) {
    (void)type;
    clearError();
    size_t len;
    unsigned char* buf = readFile(file, &len);
    if (!buf) {
        setErrorMsg(1, "could not read private key file");
        return 0;
    }
    int ret = mbedtls_pk_parse_key(&ctx->ownKey, buf, len, NULL, 0,
                                   mbedtls_psa_get_random, MBEDTLS_PSA_RANDOM_STATE);
    mbedtls_platform_zeroize(buf, len);
    free(buf);
    if (ret != 0) { setError(ret, 0); return 0; }
    ctx->hasKey = 1;

    if (ctx->hasCert) {
        ret = mbedtls_ssl_conf_own_cert(&ctx->conf, &ctx->ownCert, &ctx->ownKey);
        if (ret != 0) { setError(ret, 0); return 0; }
    }
    return 1;
}

int SSL_CTX_check_private_key(const SSL_CTX* ctx) {
    if (!ctx->hasCert || !ctx->hasKey) return 0;
    return mbedtls_pk_check_pair(&ctx->ownCert.pk, &ctx->ownKey,
                                 mbedtls_psa_get_random, MBEDTLS_PSA_RANDOM_STATE) == 0 ? 1 : 0;
}

/* sets the trusted CAs on the context's config, right before it's used */
static void applyCAs(SSL_CTX* ctx) {
    if (ctx->hasCA) {
        if (ctx->useEmbedded && !ctx->embeddedMerged) {
            parseEmbedded(&ctx->ca);
            ctx->embeddedMerged = 1;
        }
        mbedtls_ssl_conf_ca_chain(&ctx->conf, &ctx->ca, NULL);
    }
    else if (ctx->useEmbedded) {
        mbedtls_ssl_conf_ca_chain(&ctx->conf, getEmbeddedCA(), NULL);
    }
}

/*=======================================
 * Memory BIOs
 *=======================================*/

const BIO_METHOD* BIO_s_mem(void) {
    return &memMethod;
}

BIO* BIO_new(const BIO_METHOD* type) {
    (void)type;
    return (BIO*)calloc(1, sizeof(BIO));
}

static void bioFree(BIO* b) {
    if (!b) return;
    free(b->data);
    free(b);
}

static size_t bioPending(const BIO* b) {
    return b->len - b->off;
}

static int bioAppend(BIO* b, const unsigned char* data, size_t len) {
    if (b->off > 0 && b->off == b->len) {
        b->off = b->len = 0;
    }
    if (b->len + len > b->cap) {
        if (b->off > 0) {
            memmove(b->data, b->data + b->off, b->len - b->off);
            b->len -= b->off;
            b->off = 0;
        }
        if (b->len + len > b->cap) {
            size_t ncap = b->cap ? b->cap : 16384;
            while (ncap < b->len + len) ncap *= 2;
            unsigned char* nd = (unsigned char*)realloc(b->data, ncap);
            if (!nd) return -1;
            b->data = nd;
            b->cap = ncap;
        }
    }
    memcpy(b->data + b->len, data, len);
    b->len += len;
    return (int)len;
}

static size_t bioTake(BIO* b, unsigned char* out, size_t len) {
    size_t n = bioPending(b);
    if (n > len) n = len;
    memcpy(out, b->data + b->off, n);
    b->off += n;
    if (b->off == b->len) b->off = b->len = 0;
    return n;
}

int BIO_read(BIO* b, void* data, int len) {
    if (!b || len <= 0) return 0;
    if (bioPending(b) == 0) return -1;      /* empty: "retry" */
    return (int)bioTake(b, (unsigned char*)data, (size_t)len);
}

int BIO_write(BIO* b, const void* data, int len) {
    if (!b || len <= 0) return 0;
    return bioAppend(b, (const unsigned char*)data, (size_t)len);
}

int BIO_ctrl_pending(BIO* b) {
    return b ? (int)bioPending(b) : 0;
}

/*=======================================
 * I/O callbacks for mbedTLS
 *=======================================*/

static int memSend(void* p, const unsigned char* buf, size_t len) {
    SSL* s = (SSL*)p;
    if (bioAppend(s->wbio, buf, len) < 0) return MBEDTLS_ERR_SSL_ALLOC_FAILED;
    return (int)len;
}

static int memRecv(void* p, unsigned char* buf, size_t len) {
    SSL* s = (SSL*)p;
    if (bioPending(s->rbio) == 0) return MBEDTLS_ERR_SSL_WANT_READ;
    return (int)bioTake(s->rbio, buf, len);
}

#ifdef _WIN32

static int fdSend(void* p, const unsigned char* buf, size_t len) {
    SSL* s = (SSL*)p;
    int r = send((SOCKET)s->fd, (const char*)buf, (int)len, 0);
    if (r >= 0) return r;
    int e = WSAGetLastError();
    if (e == WSAEWOULDBLOCK) return MBEDTLS_ERR_SSL_WANT_WRITE;
    if (e == WSAECONNRESET || e == WSAECONNABORTED) return MBEDTLS_ERR_NET_CONN_RESET;
    return MBEDTLS_ERR_NET_SEND_FAILED;
}

static int fdRecv(void* p, unsigned char* buf, size_t len) {
    SSL* s = (SSL*)p;
    int r = recv((SOCKET)s->fd, (char*)buf, (int)len, 0);
    if (r >= 0) return r;
    int e = WSAGetLastError();
    if (e == WSAEWOULDBLOCK) return MBEDTLS_ERR_SSL_WANT_READ;
    if (e == WSAECONNRESET || e == WSAECONNABORTED) return MBEDTLS_ERR_NET_CONN_RESET;
    return MBEDTLS_ERR_NET_RECV_FAILED;
}

#else

#ifndef MSG_NOSIGNAL
    #define MSG_NOSIGNAL 0
#endif

static int fdSend(void* p, const unsigned char* buf, size_t len) {
    SSL* s = (SSL*)p;
    for (;;) {
        ssize_t r = send((int)s->fd, buf, len, MSG_NOSIGNAL);
        if (r >= 0) return (int)r;
        if (errno == EINTR) continue;
        if (errno == EAGAIN || errno == EWOULDBLOCK) return MBEDTLS_ERR_SSL_WANT_WRITE;
        if (errno == EPIPE || errno == ECONNRESET) return MBEDTLS_ERR_NET_CONN_RESET;
        return MBEDTLS_ERR_NET_SEND_FAILED;
    }
}

static int fdRecv(void* p, unsigned char* buf, size_t len) {
    SSL* s = (SSL*)p;
    for (;;) {
        ssize_t r = recv((int)s->fd, buf, len, 0);
        if (r >= 0) return (int)r;
        if (errno == EINTR) continue;
        if (errno == EAGAIN || errno == EWOULDBLOCK) return MBEDTLS_ERR_SSL_WANT_READ;
        if (errno == EPIPE || errno == ECONNRESET) return MBEDTLS_ERR_NET_CONN_RESET;
        return MBEDTLS_ERR_NET_RECV_FAILED;
    }
}

#endif

/*=======================================
 * SSL
 *=======================================*/

SSL* SSL_new(SSL_CTX* ctx) {
    clearError();
    if (!ctx) return NULL;

    SSL* s = (SSL*)calloc(1, sizeof(SSL));
    if (!s) return NULL;

    s->ctx = ctx;
    s->fd = -1;
    mbedtls_ssl_init(&s->ssl);

    applyCAs(ctx);

    int ret = mbedtls_ssl_setup(&s->ssl, &ctx->conf);
    if (ret != 0) {
        setError(ret, 0);
        mbedtls_ssl_free(&s->ssl);
        free(s);
        return NULL;
    }
    return s;
}

void SSL_free(SSL* s) {
    if (!s) return;
    mbedtls_ssl_free(&s->ssl);
    bioFree(s->rbio);
    if (s->wbio != s->rbio) bioFree(s->wbio);
    free(s);
}

#ifdef _WIN32
int SSL_set_fd(SSL* s, uintptr_t fd) {    /* Nim: SocketHandle = int */
#else
int SSL_set_fd(SSL* s, int fd) {          /* Nim: SocketHandle = cint */
#endif
    s->fd = fd;
    mbedtls_ssl_set_bio(&s->ssl, s, fdSend, fdRecv, NULL);
    return 1;
}

/* takes ownership of the BIOs (freed in SSL_free), like OpenSSL */
void SSL_set_bio(SSL* s, BIO* rbio, BIO* wbio) {
    s->rbio = rbio;
    s->wbio = wbio;
    mbedtls_ssl_set_bio(&s->ssl, s, memSend, memRecv, NULL);
}

intptr_t SSL_ctrl(SSL* s, int cmd, intptr_t larg, void* parg) {
    (void)larg;
    switch (cmd) {
        case SSL_CTRL_SET_TLSEXT_HOSTNAME: {
            /* sets both SNI and the name to verify the certificate against */
            int ret = mbedtls_ssl_set_hostname(&s->ssl, (const char*)parg);
            if (ret != 0) { setError(ret, 0); return 0; }
            s->hostnameSet = 1;
            return 1;
        }
        default:
            return 0;
    }
}

void SSL_set_connect_state(SSL* s) {
    s->isServer = 0;
}

void SSL_set_accept_state(SSL* s) {
    s->isServer = 1;
}

/* turns an mbedTLS result into an OpenSSL one, remembering the SSL_ERROR_* */
static int fail(SSL* s, int ret) {
    switch (ret) {
        case MBEDTLS_ERR_SSL_WANT_READ:
            s->lastError = SSL_ERROR_WANT_READ;
            return -1;
        case MBEDTLS_ERR_SSL_WANT_WRITE:
            s->lastError = SSL_ERROR_WANT_WRITE;
            return -1;
        case MBEDTLS_ERR_SSL_PEER_CLOSE_NOTIFY:
            s->lastError = SSL_ERROR_ZERO_RETURN;
            s->eof = 1;
            return 0;
        case 0:
        case MBEDTLS_ERR_SSL_CONN_EOF:
            /* EOF without a close_notify */
            s->lastError = SSL_ERROR_SYSCALL;
            s->eof = 2;
            return 0;
        case MBEDTLS_ERR_NET_SEND_FAILED:
        case MBEDTLS_ERR_NET_RECV_FAILED:
        case MBEDTLS_ERR_NET_CONN_RESET:
            /* the OS error is still in errno / WSAGetLastError */
            s->lastError = SSL_ERROR_SYSCALL;
            return -1;
        default:
            s->lastError = SSL_ERROR_SSL;
            setError(ret, mbedtls_ssl_get_verify_result(&s->ssl));
            return -1;
    }
}

int SSL_do_handshake(SSL* s) {
    if (s->isServer) {
        s->lastError = SSL_ERROR_SSL;
        setErrorMsg(1, "TLS server mode is not supported");
        return -1;
    }

    /* No hostname (e.g. connecting to an IP address): tell mbedTLS not to
     * check it, Nim's checkCertName does it after the handshake instead */
    if (!s->hostnameSet) {
        mbedtls_ssl_set_hostname(&s->ssl, NULL);
        s->hostnameSet = 1;
    }

    int ret = mbedtls_ssl_handshake(&s->ssl);
    if (ret == 0) {
        s->lastError = SSL_ERROR_NONE;
        return 1;
    }
    return fail(s, ret);
}

int SSL_connect(SSL* s) {
    s->isServer = 0;
    return SSL_do_handshake(s);
}

int SSL_accept(SSL* s) {
    s->isServer = 1;
    return SSL_do_handshake(s);
}

int SSL_in_init(const SSL* s) {
    return mbedtls_ssl_is_handshake_over((mbedtls_ssl_context*)&s->ssl) ? 0 : 1;
}

int SSL_read(SSL* s, void* buf, int num) {
    if (num <= 0) return 0;

    /* like OpenSSL: once the peer has closed, keep reporting it (mbedTLS
     * would go back to the transport and wait for more data) */
    if (s->eof) {
        s->lastError = (s->eof == 1) ? SSL_ERROR_ZERO_RETURN : SSL_ERROR_SYSCALL;
        return 0;
    }

    if (!s->hostnameSet && !mbedtls_ssl_is_handshake_over(&s->ssl)) {
        int h = SSL_do_handshake(s);
        if (h != 1) return h;
    }
    int ret = mbedtls_ssl_read(&s->ssl, (unsigned char*)buf, (size_t)num);
    if (ret > 0) {
        s->lastError = SSL_ERROR_NONE;
        return ret;
    }
    return fail(s, ret);
}

int SSL_write(SSL* s, const void* buf, int num) {
    if (num <= 0) return 0;
    if (!s->hostnameSet && !mbedtls_ssl_is_handshake_over(&s->ssl)) {
        int h = SSL_do_handshake(s);
        if (h != 1) return h;
    }
    const unsigned char* p = (const unsigned char*)buf;
    size_t done = 0, total = (size_t)num;

    /* like OpenSSL (without SSL_MODE_ENABLE_PARTIAL_WRITE): all or nothing,
     * as far as possible */
    while (done < total) {
        int ret = mbedtls_ssl_write(&s->ssl, p + done, total - done);
        if (ret > 0) {
            done += (size_t)ret;
            continue;
        }
        if (done > 0) break;
        return fail(s, ret);
    }
    s->lastError = SSL_ERROR_NONE;
    return (int)done;
}

int SSL_pending(const SSL* s) {
    return (int)mbedtls_ssl_get_bytes_avail(&s->ssl);
}

int SSL_get_error(const SSL* s, int ret) {
    if (ret > 0) return SSL_ERROR_NONE;
    return s->lastError != SSL_ERROR_NONE ? s->lastError : SSL_ERROR_SYSCALL;
}

/* unidirectional shutdown: send close_notify (best effort) */
int SSL_shutdown(SSL* s) {
    if (mbedtls_ssl_is_handshake_over(&s->ssl))
        (void)mbedtls_ssl_close_notify(&s->ssl);
    return 0;
}

void SSL_set_shutdown(SSL* s, int mode) {
    s->shutdown = mode;
}

int SSL_get_verify_mode(const SSL* s) {
    return s->ctx->verifyMode;
}

/*=======================================
 * Peer certificate
 *=======================================*/

X509* SSL_get1_peer_certificate(const SSL* s) {
    const mbedtls_x509_crt* crt = mbedtls_ssl_get_peer_cert(&s->ssl);
    if (!crt) return NULL;
    X509* x = (X509*)calloc(1, sizeof(X509));
    if (x) x->crt = (mbedtls_x509_crt*)crt;
    return x;
}

void X509_free(X509* x) {
    free(x);
}

/* Uses mbedTLS's own matching (SANs, wildcards, IPs, CN fallback): the name
 * check in mbedtls_x509_crt_verify is done, and its flag set, independently
 * of whether the chain is trusted */
static int matchesName(X509* x, const char* name) {
    if (!x || !x->crt || !name || !name[0]) return 0;
    uint32_t flags = 0;
    (void)mbedtls_x509_crt_verify(x->crt, NULL, NULL, name, &flags, NULL, NULL);
    if (flags == (uint32_t)-1) return 0;
    return (flags & MBEDTLS_X509_BADCERT_CN_MISMATCH) ? 0 : 1;
}

int X509_check_host(X509* x, const char* name, int namelen, unsigned int flags, char** peername) {
    (void)flags;
    if (peername) *peername = NULL;
    if (!name || namelen < 0) return 0;

    if (namelen == 0) namelen = (int)strlen(name);
    char host[256];
    if ((size_t)namelen >= sizeof(host)) return 0;
    memcpy(host, name, namelen);
    host[namelen] = 0;

    return matchesName(x, host);
}

int X509_check_ip_asc(X509* x, const char* address, unsigned int flags) {
    (void)flags;
    return matchesName(x, address);
}
