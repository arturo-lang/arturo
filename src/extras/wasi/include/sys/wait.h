/* [arturo] WASI has no processes: just enough
 * of <sys/wait.h> for Nim's stdlib to compile */

#ifndef WASI_SYS_WAIT_H
#define WASI_SYS_WAIT_H

#include <sys/types.h>

#define WNOHANG     1
#define WUNTRACED   2
#define WCONTINUED  8

#define WEXITSTATUS(s)  (((s) & 0xff00) >> 8)
#define WTERMSIG(s)     ((s) & 0x7f)
#define WSTOPSIG(s)     WEXITSTATUS(s)
#define WIFEXITED(s)    (!WTERMSIG(s))
#define WIFSTOPPED(s)   (((s) & 0xff) == 0x7f)
#define WIFSIGNALED(s)  (((s) & 0xffff) - 1U < 0xffu)
#define WIFCONTINUED(s) ((s) == 0xffff)

pid_t wait(int *status);
pid_t waitpid(pid_t pid, int *status, int options);

#endif
