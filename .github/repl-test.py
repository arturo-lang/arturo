#!/usr/bin/env python3
# Temporary: drives `arturo --repl` through a real (pseudo-)terminal and
# checks line editing. POSIX uses pty; Windows uses ConPTY via pywinpty.
# Each scenario makes the REPL write its result to a file, so checks do
# not depend on how the terminal output is rendered.
#
# usage: repl-test.py /path/to/arturo

import os, re, sys, time, shutil, tempfile, threading

WINDOWS = os.name == "nt"
BIN = sys.argv[1]

if WINDOWS:
    # CI runners may start us with Ctrl+C ignored, which children inherit
    import ctypes
    ctypes.windll.kernel32.SetConsoleCtrlHandler(None, False)
ROWS, COLS = 40, 120

LEFT, UP = "\x1b[D", "\x1b[A"
BS, CTRL_C, CTRL_D, CTRL_R, CTRL_U = "\x7f", "\x03", "\x04", "\x12", "\x15"


class Repl:
    def __init__(self, cwd, winsize=True):
        env = dict(os.environ, HOME=cwd, USERPROFILE=cwd, TERM="xterm-256color")
        env.pop("NO_COLOR", None)
        self.out = b""
        self.lock = threading.Lock()
        if WINDOWS:
            from winpty import PtyProcess
            self.proc = PtyProcess.spawn([BIN, "--repl"], cwd=cwd, env=env, dimensions=(ROWS, COLS))
            reader = self._read_win
        else:
            import pty, fcntl, termios, struct
            pid, fd = pty.fork()
            if pid == 0:
                os.chdir(cwd)
                os.execve(BIN, [BIN, "--repl"], env)
            if winsize:
                fcntl.ioctl(fd, termios.TIOCSWINSZ, struct.pack("HHHH", ROWS, COLS, 0, 0))
            self.pid, self.fd = pid, fd
            reader = self._read_posix
        threading.Thread(target=reader, daemon=True).start()

    def _read_posix(self):
        while True:
            try:
                d = os.read(self.fd, 65536)
            except OSError:
                return
            if not d:
                return
            with self.lock:
                self.out += d

    def _read_win(self):
        while True:
            try:
                d = self.proc.read(65536)
            except Exception:
                return
            if not d:
                return
            with self.lock:
                self.out += d.encode("utf-8", "replace")

    def screen(self):
        with self.lock:
            s = self.out.decode("utf-8", "replace")
        return re.sub(r"\x1b\[[0-9;?]*[A-Za-z]|\x1b\][^\x07]*\x07", "", s)

    def wait_for(self, text, timeout):
        end = time.time() + timeout
        while time.time() < end:
            if text in self.screen():
                return True
            time.sleep(0.1)
        return False

    def send(self, keys):
        if WINDOWS:
            self.proc.write(keys)
        else:
            os.write(self.fd, keys.encode("utf-8"))
        time.sleep(0.6)

    def alive(self):
        if WINDOWS:
            return self.proc.isalive()
        pid, _ = os.waitpid(self.pid, os.WNOHANG)
        return pid == 0

    def wait_exit(self, timeout):
        end = time.time() + timeout
        while time.time() < end:
            if not self.alive():
                return True
            time.sleep(0.1)
        return False

    def kill(self):
        try:
            if WINDOWS:
                self.proc.terminate(force=True)
            else:
                os.kill(self.pid, 9)
                os.waitpid(self.pid, 0)
        except Exception:
            pass


def W(s):
    """a line that writes the given Arturo expression to out.txt"""
    return f'write {s} "out.txt"\r'


# (name, keys to send, expected contents of out.txt, posix only?)
SCENARIOS = [
    ("plain ascii",            [W('"hello"')],                                          "hello"),
    ("cjk",                    [W('"a你b"')],                                            "a你b"),
    ("accents (meta clash)",   [W('"café ø áñ"')],                                       "café ø áñ"),
    ("emoji (surrogates)",     [W('"😀!"')],                                             "😀!"),
    ("backspace accent",       ['write "café', BS, '" "out.txt"\r'],                     "caf"),
    ("backspace cjk + emoji",  ['write "你😀', BS, BS, 'ok" "out.txt"\r'],                "ok"),
    ("cursor left over é",     ['write "éb" "out.txt"', LEFT * 13, "X\r"],               "Xéb"),
    ("history up",             ['write.append "你好" "out.txt"\r', UP, "\r"],            "你好你好"),
    ("ctrl-r search",          ['write.append "R" "out.txt"\r', "print 1\r",
                                CTRL_R, "append", "\r"],                                  "RR"),
    ("tab completion",         ['write to :string siz', "\t", '[1 2] "out.txt"\r'],      "2"),
    ("multi-line",             ["f: function [x][ \r", "x * 2 \r", "]\r",
                                W("to :string f 21")],                                    "42"),
    ("ctrl-c stops running code", ["while [true][]\r", CTRL_C, W('"ok"')],                "ok"),
    ("ctrl-c drops typed line",   ['write "no" "out.txt"', CTRL_C, W('"ok"')],            "ok"),
    ("ctrl-c at empty prompt",    [CTRL_C, W('"ok"')],                                    "ok"),
    ("paste multi-line block",    ["f: function [x][\r    y: x * 2\r    y + 1\r]\r",
                                   W("to :string f 20")],                                 "41"),
    ("paste, then edit & enter",  ['a: 1\rb: 2', ' + a\r', W("to :string b")],           "3"),
    ("recall multi-line entry",   ["x: 0\r", "x: x + 1\r" + W("to :string x"), UP, "\r"], "2"),
    ("long line wraps",           [W('"' + "abcdefghij" * 30 + '"')],                     "abcdefghij" * 30),
]


def run(name, keys, expected, winsize=True):
    d = tempfile.mkdtemp(prefix="repltest")
    r = Repl(d, winsize)
    problems = []
    try:
        if not r.wait_for("$>", 60):
            problems.append("no prompt")
        else:
            for k in keys:
                r.send(k)
            time.sleep(0.5)
            p = os.path.join(d, "out.txt")
            got = open(p, "rb").read().decode("utf-8", "backslashreplace") if os.path.exists(p) else None
            if got != expected:
                problems.append(f"expected {expected!r}, got {got!r}")
            r.send(CTRL_D)
            if not r.wait_exit(10):
                problems.append("did not exit on Ctrl-D")
    finally:
        r.kill()
    if problems:
        tail = r.screen()[-1500:]
        print(f"FAIL  {name}: {'; '.join(problems)}\n----- screen (tail):\n{tail}\n-----")
    else:
        print(f"OK    {name}")
    shutil.rmtree(d, ignore_errors=True)
    return not problems


def hints():
    d = tempfile.mkdtemp(prefix="repltest")
    r = Repl(d)
    try:
        r.wait_for("$>", 60)
        r.send("function")
        ok = r.wait_for("arguments body", 5)
        r.send(CTRL_U + CTRL_D)
    finally:
        r.kill()
    print(("OK    " if ok else "FAIL  ") + "hints")
    shutil.rmtree(d, ignore_errors=True)
    return ok


results = [run(*s) for s in SCENARIOS]
results.append(hints())
if not WINDOWS:
    results.append(run("terminal without size", [W('"ok"')], "ok", winsize=False))

print(f"\n{sum(results)}/{len(results)} passed")
sys.exit(0 if all(results) else 1)
