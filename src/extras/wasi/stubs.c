/* [arturo] Implementations for the bits of POSIX that
 * Nim's stdlib expects, but WASI (preview 1) doesn't
 * provide: mostly, they just fail with ENOSYS */

#include <errno.h>
#include <stdarg.h>
#include <stddef.h>
#include <unistd.h>

/* Nim's std/sysrand (on Linux) goes for
 * `syscall(SYS_getrandom, ...)`: we only
 * support that one, via getentropy */
long syscall(long number, ...) {
    if (number == SYS_getrandom) {
        va_list args;
        va_start(args, number);
        unsigned char *buf = va_arg(args, unsigned char *);
        size_t len = va_arg(args, size_t);
        va_end(args);

        size_t done = 0;
        while (done < len) {
            size_t chunk = len - done > 256 ? 256 : len - done;
            if (getentropy(buf + done, chunk) != 0) return -1;
            done += chunk;
        }
        return (long)len;
    }
    errno = ENOSYS;
    return -1;
}

/* there are no limits to query, really:
 * so let's just say we have the usual ones */
int getrlimit(int resource, struct rlimit *rlim) {
    if (resource == RLIMIT_NOFILE) {
        rlim->rlim_cur = 1024;
        rlim->rlim_max = 1024;
        return 0;
    }
    errno = EINVAL;
    return -1;
}

int setrlimit(int resource, const struct rlimit *rlim) {
    (void)resource; (void)rlim;
    errno = ENOSYS;
    return -1;
}

/*---------------------------------------
 * Users & processes
 *---------------------------------------*/

#include <signal.h>
#include <spawn.h>
#include <stdio.h>
#include <sys/wait.h>

uid_t geteuid(void) { return 0; }

int setpgid(pid_t pid, pid_t pgid) {
    (void)pid; (void)pgid;
    errno = ENOSYS;
    return -1;
}

int kill(pid_t pid, int sig) {
    (void)pid; (void)sig;
    errno = ENOSYS;
    return -1;
}

int sigemptyset(sigset_t *set) {
    *set = 0;
    return 0;
}

int system(const char *command) {
    /* "is there a shell?" - no */
    if (command == NULL) return 0;
    errno = ENOSYS;
    return -1;
}

char *ctermid(char *s) {
    static char none[1] = "";
    if (s) { s[0] = '\0'; return s; }
    return none;
}

pid_t wait(int *status) {
    (void)status;
    errno = ECHILD;
    return -1;
}

pid_t waitpid(pid_t pid, int *status, int options) {
    (void)pid; (void)status; (void)options;
    errno = ECHILD;
    return -1;
}

int posix_spawn(pid_t *pid, const char *path,
                const posix_spawn_file_actions_t *fa,
                const posix_spawnattr_t *attr,
                char *const argv[], char *const envp[]) {
    (void)pid; (void)path; (void)fa; (void)attr; (void)argv; (void)envp;
    return ENOSYS;
}

int posix_spawnp(pid_t *pid, const char *file,
                 const posix_spawn_file_actions_t *fa,
                 const posix_spawnattr_t *attr,
                 char *const argv[], char *const envp[]) {
    (void)pid; (void)file; (void)fa; (void)attr; (void)argv; (void)envp;
    return ENOSYS;
}

int posix_spawn_file_actions_init(posix_spawn_file_actions_t *fa) { (void)fa; return 0; }
int posix_spawn_file_actions_destroy(posix_spawn_file_actions_t *fa) { (void)fa; return 0; }
int posix_spawn_file_actions_addclose(posix_spawn_file_actions_t *fa, int fd) { (void)fa; (void)fd; return 0; }
int posix_spawn_file_actions_adddup2(posix_spawn_file_actions_t *fa, int fd, int newfd) { (void)fa; (void)fd; (void)newfd; return 0; }

int posix_spawnattr_init(posix_spawnattr_t *attr) { (void)attr; return 0; }
int posix_spawnattr_destroy(posix_spawnattr_t *attr) { (void)attr; return 0; }
int posix_spawnattr_setflags(posix_spawnattr_t *attr, short flags) { (void)attr; (void)flags; return 0; }
int posix_spawnattr_setpgroup(posix_spawnattr_t *attr, pid_t pgroup) { (void)attr; (void)pgroup; return 0; }
int posix_spawnattr_setsigmask(posix_spawnattr_t *attr, const sigset_t *set) { (void)attr; (void)set; return 0; }

/*---------------------------------------
 * Sockets & name resolution
 *---------------------------------------*/

#include <netdb.h>
#include <sys/socket.h>

int h_errno = 0;

int socket(int domain, int type, int protocol) {
    (void)domain; (void)type; (void)protocol;
    errno = ENOSYS;
    return -1;
}

int bind(int fd, const struct sockaddr *addr, socklen_t len) {
    (void)fd; (void)addr; (void)len;
    errno = ENOSYS;
    return -1;
}

int connect(int fd, const struct sockaddr *addr, socklen_t len) {
    (void)fd; (void)addr; (void)len;
    errno = ENOSYS;
    return -1;
}

int listen(int fd, int backlog) {
    (void)fd; (void)backlog;
    errno = ENOSYS;
    return -1;
}

int getsockname(int fd, struct sockaddr *addr, socklen_t *len) {
    (void)fd; (void)addr; (void)len;
    errno = ENOSYS;
    return -1;
}

int getpeername(int fd, struct sockaddr *addr, socklen_t *len) {
    (void)fd; (void)addr; (void)len;
    errno = ENOSYS;
    return -1;
}

int setsockopt(int fd, int level, int name, const void *value, socklen_t len) {
    (void)fd; (void)level; (void)name; (void)value; (void)len;
    errno = ENOSYS;
    return -1;
}

int getaddrinfo(const char *node, const char *service,
                const struct addrinfo *hints, struct addrinfo **res) {
    (void)node; (void)service; (void)hints;
    *res = NULL;
    return EAI_FAIL;
}

void freeaddrinfo(struct addrinfo *res) { (void)res; }

const char *gai_strerror(int errcode) {
    (void)errcode;
    return "networking is not supported on WASI";
}
