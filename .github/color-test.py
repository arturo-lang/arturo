#!/usr/bin/env python3
# Temporary: checks when (and which) colors Arturo shows
# usage: color-test.py <arturo-binary>

import os, subprocess, sys

BIN = sys.argv[1]
WIN = os.name == "nt" or sys.platform in ("cygwin", "msys")
RED = 'print color #red "x"'

BASE = {k: v for k, v in os.environ.items()
        if k not in ("NO_COLOR", "FORCE_COLOR", "CLICOLOR_FORCE", "TERM", "COLORTERM", "TERM_PROGRAM")}

def piped(code, env={}, args=[]):
    r = subprocess.run([BIN] + args + ["-e", code], capture_output=True, env={**BASE, **env}, timeout=60)
    return r.stdout.decode(errors="replace")

def pty(code, env={}, args=[]):
    env = {**BASE, "TERM": "xterm-256color", **env}
    if os.name == "nt":
        from winpty import PtyProcess
        p = PtyProcess.spawn([BIN] + args + ["-e", code], env=env)
        out = ""
        while True:
            try:
                out += p.read()
            except EOFError:
                break
        return out
    else:
        import pty as ptym
        master, slave = ptym.openpty()
        p = subprocess.Popen([BIN] + args + ["-e", code], stdin=slave, stdout=slave, stderr=slave, env=env)
        os.close(slave)
        out = b""
        while True:
            try:
                chunk = os.read(master, 4096)
            except OSError:
                break
            if not chunk:
                break
            out += chunk
        p.wait(timeout=60)
        os.close(master)
        return out.decode(errors="replace")

F = {"FORCE_COLOR": "1"}

# (name, runner, code, env, args, text, should it be there?)
checks = [
    # when colors are shown
    ("piped",                           piped, RED, {},                      [],             "31m", False),
    ("piped, FORCE_COLOR=1",            piped, RED, F,                       [],             "31m", True),
    ("piped, FORCE_COLOR=0",            piped, RED, {"FORCE_COLOR": "0"},    [],             "31m", False),
    ("piped, CLICOLOR_FORCE=1",         piped, RED, {"CLICOLOR_FORCE": "1"}, [],             "31m", True),
    ("piped, FORCE_COLOR & --no-color", piped, RED, F,                       ["--no-color"], "31m", False),
    ("terminal",                        pty,   RED, {},                      [],             "31m", True),
    ("terminal, NO_COLOR=1",            pty,   RED, {"NO_COLOR": "1"},       [],             "31m", False),
    ("terminal, TERM=dumb",             pty,   RED, {"TERM": "dumb"},        [],             "31m", False),
    ("terminal, --no-color",            pty,   RED, {},                      ["--no-color"], "31m", False),

    # which colors are shown
    ("orange, 256 colors",      piped, 'print color #orange "x"',  {**F, "TERM": "xterm-256color"},   [], "38;5;208m", True),
    ("orange, 16 colors",       piped, 'print color #orange "x"',  {**F, "TERM": "xterm"},            [], "93m" if not WIN else "38;5;208m", True),
    ("rgb, truecolor",          piped, 'print color #1e90ff "x"',  {**F, "COLORTERM": "truecolor"},   [], "38;2;30;144;255m", True),
    ("rgb, 256 colors",         piped, 'print color #1e90ff "x"',  {**F, "TERM": "xterm-256color"},   [], "38;5;33m" if not WIN else "38;2;30;144;255m", True),
    ("rgb, 16 colors",          piped, 'print color #1e90ff "x"',  {**F, "TERM": "xterm"},            [], "96m" if not WIN else "38;2;30;144;255m", True),
    ("rgb, FORCE_COLOR=3",      piped, 'print color #1e90ff "x"',  {"FORCE_COLOR": "3", "TERM": "xterm"}, [], "38;2;30;144;255m", True),
    ("bold & underline",        piped, 'print color.bold.underline #red "x"', F,                  [], "1;31m\x1b[4m", True),

    # terminal info
    ("tty?, piped",             piped, 'print terminal\\tty?',     {}, [], "false", True),
    ("tty?, terminal",          pty,   'print terminal\\tty?',     {}, [], "true",  True),
    ("colors, piped",           piped, 'print terminal\\colors',   {}, [], "0",     True),
    ("colors, NO_COLOR",        pty,   'print terminal\\colors',   {"NO_COLOR": "1"}, [], "0", True),
    ("colors, terminal",        pty,   'print terminal\\colors',   {}, [], "256" if not WIN else "16777216", True),

    # clear
    ("clear, piped",            piped, 'clear print "x"',          {}, [], "2J", False),
]

failed = 0
for name, run, code, env, args, text, expected in checks:
    out = run(code, env, args)
    got = text in out
    ok = got == expected
    failed += not ok
    print(("ok  " if ok else "FAIL"), name, "" if ok else repr(out))

sys.exit(1 if failed else 0)
