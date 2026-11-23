/* [arturo] Force-included in every C file of a WASI build:
 * constants & declarations that Nim's stdlib expects from
 * a POSIX system, but WASI (preview 1) doesn't provide.
 * (whatever needs an implementation is in: wasi/stubs.c) */

#ifndef WASI_SHIM_H
#define WASI_SHIM_H

/* see: wasi/stubs.c */
#include <sys/types.h>

#define SYS_getrandom   318
long syscall(long number, ...);

uid_t geteuid(void);
int setpgid(pid_t pid, pid_t pgid);
int kill(pid_t pid, int sig);
int system(const char *command);
char *ctermid(char *s);

#include <signal.h>
int sigemptyset(sigset_t *set);

/* resource limits */
#include <sys/resource.h>
#ifndef RLIMIT_NOFILE
#define RLIMIT_STACK    3
#define RLIMIT_NOFILE   7
typedef unsigned long long rlim_t;
struct rlimit {
    rlim_t rlim_cur;
    rlim_t rlim_max;
};
int getrlimit(int resource, struct rlimit *rlim);
int setrlimit(int resource, const struct rlimit *rlim);
#endif

/* sockets: WASI (preview 1) can only use already-open ones */
#include <sys/socket.h>
int socket(int domain, int type, int protocol);
int bind(int fd, const struct sockaddr *addr, socklen_t len);
int connect(int fd, const struct sockaddr *addr, socklen_t len);
int listen(int fd, int backlog);
int getsockname(int fd, struct sockaddr *addr, socklen_t *len);
int getpeername(int fd, struct sockaddr *addr, socklen_t *len);
int setsockopt(int fd, int level, int name, const void *value, socklen_t len);

/* sockets types & protocols */
#ifndef SOCK_RAW
#define SOCK_RAW        3

/* sockets (they all fail at runtime anyway) */
#ifndef SO_DEBUG
#define SO_DEBUG        1
#endif
#ifndef SO_DONTROUTE
#define SO_DONTROUTE    5
#endif
#ifndef SO_BROADCAST
#define SO_BROADCAST    6
#endif
#ifndef SO_REUSEADDR
#define SO_REUSEADDR    2
#endif
#ifndef SO_KEEPALIVE
#define SO_KEEPALIVE    9
#endif
#ifndef SO_OOBINLINE
#define SO_OOBINLINE    10
#endif
#ifndef SO_REUSEPORT
#define SO_REUSEPORT    15
#endif
#ifndef SO_ACCEPTCONN
#define SO_ACCEPTCONN   30
#endif
#ifndef SO_TYPE
#define SO_TYPE         3
#endif
#ifndef SO_ERROR
#define SO_ERROR        4
#endif
#ifndef SO_SNDBUF
#define SO_SNDBUF       7
#endif
#ifndef SO_RCVBUF
#define SO_RCVBUF       8
#endif
#ifndef SO_LINGER
#define SO_LINGER       13
#endif
#ifndef SO_RCVLOWAT
#define SO_RCVLOWAT     18
#endif
#ifndef SO_SNDLOWAT
#define SO_SNDLOWAT     19
#endif
#ifndef SO_RCVTIMEO
#define SO_RCVTIMEO     66
#endif
#ifndef SO_SNDTIMEO
#define SO_SNDTIMEO     67
#endif
#ifndef SOMAXCONN
#define SOMAXCONN       128
#endif
#ifndef MSG_DONTWAIT
#define MSG_DONTWAIT    0x0040
#endif
#ifndef MSG_OOB
#define MSG_OOB         0x0001
#endif
#ifndef MSG_DONTROUTE
#define MSG_DONTROUTE   0x0004
#endif
#ifndef MSG_EOR
#define MSG_EOR         0x0080
#endif
#ifndef MSG_NOSIGNAL
#define MSG_NOSIGNAL    0x4000
#endif

/* terminal size (it can't be queried) */
#ifndef TIOCGWINSZ
#define TIOCGWINSZ      0x5413
struct winsize {
    unsigned short ws_row;
    unsigned short ws_col;
    unsigned short ws_xpixel;
    unsigned short ws_ypixel;
};
#endif

#endif
#ifndef SOCK_SEQPACKET
#define SOCK_SEQPACKET  5
#endif
#ifndef IPPROTO_ICMPV6
#define IPPROTO_ICMPV6  58
#endif

#endif
