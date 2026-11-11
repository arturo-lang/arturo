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

# don't choke on printing non-ascii output (e.g. cp1252 consoles)
sys.stdout.reconfigure(errors="backslashreplace")

if WINDOWS:
    # CI runners may start us with Ctrl+C ignored, which children inherit
    import ctypes
    ctypes.windll.kernel32.SetConsoleCtrlHandler(None, False)
ROWS, COLS = 40, 120
PROMPT, PROMPTS = "<prompt>", ["$>", "\u276f"]   # (plain or fancy)

LEFT, UP = "\x1b[D", "\x1b[A"
BS, CTRL_C, CTRL_D, CTRL_R, CTRL_U = "\x7f", "\x03", "\x04", "\x12", "\x15"


HOME_KEY, DEL = "\x1b[H", "\x1b[3~"

# a key with modifiers, the kitty way & the xterm way
# (modifiers: 1 + shift(1) + alt(2) + ctrl(4) + capslock(64))
def KITTY(key, mods): return f"\x1b[{key if isinstance(key, int) else ord(key)};{mods}u"
def XTERM(key, mods): return f"\x1b[27;{mods};{key if isinstance(key, int) else ord(key)}~"

# Shift/Alt+Enter on Windows (as ConPTY gets it from Windows Terminal):
# \e[Vk;Sc;Uc;Kd;Cs;Rc_  -  VK_RETURN, key down & up, with SHIFT_PRESSED (0x10) or LEFT_ALT_PRESSED (0x02)
def WIN32_ENTER(state): return f"\x1b[13;28;13;1;{state};1_\x1b[13;28;13;0;{state};1_"


class Repl:
    def __init__(self, cwd, winsize=True, extra_env=None):
        env = dict(os.environ, HOME=cwd, USERPROFILE=cwd, TERM="xterm-256color")
        env.pop("NO_COLOR", None)
        for k in ("TMUX", "XTERM_VERSION", "TERM_PROGRAM"):
            env.pop(k, None)
        env.update(extra_env or {})
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

    def raw(self):
        with self.lock:
            return self.out

    def screen(self):
        with self.lock:
            s = self.out.decode("utf-8", "replace")
        return re.sub(r"\x1b\[[0-9;?]*[A-Za-z]|\x1b\][^\x07]*\x07", "", s)

    def wait_for(self, text, timeout):
        end = time.time() + timeout
        while time.time() < end:
            if any(t in self.screen() for t in (PROMPTS if text == PROMPT else [text])):
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


def WA(s):
    """(same, but appending to it)"""
    return f'write.append {s} "out.txt"\r'


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
    ("tab completion after [",    ["write to :string first @[siz", "\t", '[1 2]] "out.txt"\r'], "2"),
    ("paste with tabs",           ["g: function [x][\r\tx * 2\r]\r", W("to :string g 4")], "8"),
    ("open bracket continues",    ["f: function [x][", "\r", "loop 1..x 'i [", "\r",
                                   "write.append to :string i \"out.txt\"", "\r", "]", "\r",
                                   "]", "\r", "f 3\r"],                                    "123"),
    ("auto-indent & dedent",      ["b: [", "\r", "1", "\r", "]", "\r"],
                                   ("history", "b: [\\n    1\\n]")),
    ("complete `lookup`",         ["looku", "\t", '"zip"\r'],                           ("history", 'lookup "zip"')),
    ("double space continues",    ["x: 1 +  ", "\r", "2\r", W("to :string x")],        "3"),
    ("complete user symbols",     ["myValue: 42\r", "write to :string myV", "\t", '"out.txt"\r'], "42"),
    ("complete dictionary keys",  ["myDict: #[alpha: #[beta: 7]]\r", "write to :string myDict\\al", "\t",
                                   "\\be", "\t", ' "out.txt"\r'],                         "7"),
    ("loop filling the stack",    ["loop 1..300000 [i][i * 2]\r", W('"ok"')],            "ok"),
    ("leftovers kept (default)",  ["1 2 3\r", "n: size stack\r", W("to :string n")],     "2"),
    ("cleanStack? on",            ["Repl\\cleanStack?: true\r", "1 2 3\r", "n: size stack\r",
                                   W("to :string n")],                                    "0"),
    ("runaway recursion",         ["f: function [x][f x + 1]\r", "f 1\r", W('"ok"')], "ok"),
    ("complete user options",     ["greet: function [x][\r;; options: [\r;;    loud: « shout\r;; ]\r",
                                   "x\r", "]\r", "greet.lo", "\t", "1\r"],               ("history", "greet.loud 1")),

    # Shift/Alt+Enter: a new line in the same entry (one entry in history = it didn't submit)
    ("alt+enter (esc + cr)",      ["a: 1", "\x1b\r", "b: 2\r"],                     ("history", "a: 1\\nb: 2"), "posix"),
    ("alt+enter (esc + lf)",      ["a: 1", "\x1b\n", "b: 2\r"],                     ("history", "a: 1\\nb: 2"), "posix"),
    ("alt+enter (xterm, 8-bit)",  ["a: 1", "\u008d", "b: 2\r"],                     ("history", "a: 1\\nb: 2"), "posix"),
    ("shift+enter (kitty)",       ["a: 1", KITTY(13, 2), "b: 2\r"],                 ("history", "a: 1\\nb: 2"), "posix"),
    ("alt+enter (kitty)",         ["a: 1", KITTY(13, 3), "b: 2\r"],                 ("history", "a: 1\\nb: 2"), "posix"),
    ("shift+enter + capslock",    ["a: 1", KITTY(13, 66), "b: 2\r"],                ("history", "a: 1\\nb: 2"), "posix"),
    ("shift+enter (xterm)",       ["a: 1", XTERM(13, 2), "b: 2\r"],                 ("history", "a: 1\\nb: 2"), "posix"),
    ("alt+enter (xterm)",         ["a: 1", XTERM(13, 3), "b: 2\r"],                 ("history", "a: 1\\nb: 2"), "posix"),
    ("shift+enter (windows)",     ["a: 1", WIN32_ENTER(0x10), "b: 2\r"],            ("history", "a: 1\\nb: 2"), "windows"),
    ("alt+enter (windows)",       ["a: 1", WIN32_ENTER(0x02), "b: 2\r"],            ("history", "a: 1\\nb: 2"), "windows"),
    ("shift+enter, then run it",  ["x: 20 ; (new line, or the rest is a comment)", KITTY(13, 2), W("to :string x + 1")], "21", "posix"),
    ("shift+enter in brackets",   ["c: [", KITTY(13, 2), "1", "\r", "]", "\r"],     ("history", "c: [\\n    1\\n]"), "posix"),
    ("plain enter still submits", ["a: 1\r", "b: 2\r"],                             ("history", "b: 2")),

    # keys the kitty way (as sent, once it's turned on)
    ("ctrl+c (kitty)",            ['write.append "no" "out.txt"', KITTY("c", 5), WA('"ok"')], "ok", "posix"),
    ("ctrl+c + capslock (kitty)", ['write.append "no" "out.txt"', KITTY("c", 69), WA('"ok"')], "ok", "posix"),
    ("ctrl+a & ctrl+e (kitty)",   ['"b" "out', KITTY("a", 5), "write ", KITTY("e", 5), '.txt"\r'], "b", "posix"),
    ("alt+b (kitty)",             ["x: 10 + 2", KITTY("b", 3), "3\r", W("to :string x")], "42", "posix"),
    ("ctrl+u (kitty)",            ['write.append "no" "out.txt"', KITTY("u", 5), WA('"ok"')], "ok", "posix"),
    ("ctrl+r (kitty)",            ['write.append "R" "out.txt"\r', "print 1\r",
                                   KITTY("r", 5), "append", "\r"],                   "RR", "posix"),
    ("esc is ignored (kitty)",    ['write "ok"', KITTY(27, 1), ' "out.txt"\r'],      "ok", "posix"),
    ("ctrl+c (xterm)",            ['write.append "no" "out.txt"', XTERM("c", 5), WA('"ok"')], "ok", "posix"),

    # older keys, as before
    ("home & delete",             ['Zwrite "ok" "out.txt"', HOME_KEY, DEL, "\r"],    "ok"),
    ("ctrl+arrows, F5 ignored",   ['write "ok" "out.txt"', "\x1b[1;5C", "\x1b[1;5D", "\x1b[15~", "\r"], "ok", "posix"),
]


def run(name, keys, expected, platform=None, winsize=True):
    d = tempfile.mkdtemp(prefix="repltest")
    r = Repl(d, winsize)
    problems = []
    try:
        if not r.wait_for(PROMPT, 60):
            problems.append("no prompt")
        else:
            for k in keys:
                r.send(k)
            time.sleep(0.5)
            if isinstance(expected, tuple):
                # ("history", text): check the saved history instead
                expected = expected[1]
                p = os.path.join(d, ".arturo", "history.lst")
                got = open(p, "rb").read().decode("utf-8", "backslashreplace") if os.path.exists(p) else ""
                got = expected if expected in got.splitlines() else got
            else:
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
        r.wait_for(PROMPT, 60)
        r.send("function")
        ok = r.wait_for("arguments body", 5)
        r.send(CTRL_U + CTRL_D)
    finally:
        r.kill()
    print(("OK    " if ok else "FAIL  ") + "hints")
    shutil.rmtree(d, ignore_errors=True)
    return ok


def key_reports():
    """asking the terminal to tell keys apart: only while editing, only where it should"""
    KITTY_ON, KITTY_OFF = b"\x1b[>1u", b"\x1b[<u"
    XTERM_ON, XTERM_OFF = b"\x1b[>4;1m", b"\x1b[>4m"
    cases = [
        # (name, extra env, kitty?, xterm?)
        ("any terminal",    {},                                    True,  False),
        ("Terminal.app",    {"TERM_PROGRAM": "Apple_Terminal"},    False, False),
        ("xterm",           {"XTERM_VERSION": "XTerm(390)"},       True,  True),
        ("tmux",            {"TMUX": "/tmp/tmux-0/default,1,0"},   True,  True),
        ("linux console",   {"TERM": "linux"},                     False, False),
    ]
    ok = True
    for name, env, kitty, xterm in cases:
        d = tempfile.mkdtemp(prefix="repltest")
        r = Repl(d, extra_env=env)
        problems = []
        try:
            r.wait_for(PROMPT, 60)
            r.send("print 6 * 7")
            editing = r.raw()           # (while editing)
            r.send("\r")
            r.wait_for("42", 10)
            time.sleep(0.5)
            waiting = r.raw()           # (code ran, waiting at the next prompt)
            r.send(W('"ok"'))
            r.send(CTRL_D)
            exited = r.wait_exit(10)
            out = r.raw()               # (after quitting)
            if not exited:
                problems.append("did not exit on Ctrl-D")
            for label, on, off, wanted in [("kitty", KITTY_ON, KITTY_OFF, kitty), ("xterm", XTERM_ON, XTERM_OFF, xterm)]:
                if wanted:
                    if editing.count(on) != editing.count(off) + 1:
                        problems.append(f"{label}: not on while editing")
                    if waiting.count(on) != waiting.count(off):
                        problems.append(f"{label}: still on, after the entry")
                    # off, before the entry's code even ran
                    if waiting.rfind(off) > waiting.rfind(b"42"):
                        problems.append(f"{label}: off only after the code ran")
                    if out.count(on) != out.count(off) or out.count(on) < 3:
                        problems.append(f"{label}: on {out.count(on)}x, off {out.count(off)}x, by the end")
                elif on in out:
                    problems.append(f"{label}: on, but it shouldn't be")
            p = os.path.join(d, "out.txt")
            if not (os.path.exists(p) and open(p).read() == "ok"):
                problems.append("entries didn't run")
        finally:
            r.kill()
        print(("OK    " if not problems else "FAIL  ") + f"key reports ({name})" + ("" if not problems else f": {'; '.join(problems)}"))
        ok = ok and not problems
        shutil.rmtree(d, ignore_errors=True)
    return ok


def piped():
    """input that doesn't come from a terminal (linenoise falls back to plain line reading)"""
    import subprocess
    d = tempfile.mkdtemp(prefix="repltest")
    env = dict(os.environ, HOME=d, USERPROFILE=d)
    r = subprocess.run([BIN, "--repl"], input=b"print 1\n\nprint 2\n",
                       capture_output=True, env=env, cwd=d, timeout=60)
    out = r.stdout.decode("utf-8", "replace").replace("\r", "")
    ok = "\n2\n" in out
    print(("OK    " if ok else "FAIL  ") + "piped input with an empty line")
    if not ok:
        print(f"----- output (tail):\n{out[-600:]}\n-----")
    shutil.rmtree(d, ignore_errors=True)
    return ok


def mintty():
    """input from a Cygwin/MSYS2 pty, as in mintty (the terminal itself echoes & edits the line)"""
    d = tempfile.mkdtemp(prefix="repltest")
    r = Repl(d)
    cmd = 'print "zz" ++ "top"'
    try:
        r.wait_for(PROMPT, 60)
        r.send(cmd + "\r")
        r.send("\r")
        r.send(W('"ok"'))
        time.sleep(0.5)
        p = os.path.join(d, "out.txt")
        got = open(p).read() if os.path.exists(p) else None
        echoes = r.screen().count(cmd)
    finally:
        r.kill()
    ok = got == "ok" and echoes == 1
    print(("OK    " if ok else "FAIL  ") + f"MSYS2 pty: empty line & single echo (out.txt: {got!r}, echoes: {echoes})")
    if not ok:
        print(f"----- screen (tail):\n{r.screen()[-1500:]}\n-----")
    shutil.rmtree(d, ignore_errors=True)
    return ok


if "--piped" in sys.argv:
    sys.exit(0 if piped() else 1)
if "--mintty" in sys.argv:
    sys.exit(0 if mintty() else 1)

PLATFORM = "windows" if WINDOWS else "posix"
results = [run(*s) for s in SCENARIOS if len(s) < 4 or s[3] in (None, PLATFORM)]
results.append(hints())
if not WINDOWS:
    results.append(run("terminal without size", [W('"ok"')], "ok", winsize=False))
    results.append(key_reports())

print(f"\n{sum(results)}/{len(results)} passed")
sys.exit(0 if all(results) else 1)
