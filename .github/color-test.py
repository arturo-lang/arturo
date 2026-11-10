#!/usr/bin/env python3
# Temporary: checks when Arturo shows colors
# usage: color-test.py <arturo-binary>

import os, subprocess, sys

BIN = sys.argv[1]
CODE = 'print color #red "x"'
RED = "31m"

BASE = {k: v for k, v in os.environ.items() if k not in ("NO_COLOR", "FORCE_COLOR", "CLICOLOR_FORCE", "TERM")}

def piped(env={}, args=[]):
    r = subprocess.run([BIN] + args + ["-e", CODE], capture_output=True, env={**BASE, **env}, timeout=60)
    return r.stdout.decode(errors="replace")

def pty(env={}, args=[]):
    env = {**BASE, "TERM": "xterm-256color", **env}
    if os.name == "nt":
        from winpty import PtyProcess
        p = PtyProcess.spawn([BIN] + args + ["-e", CODE], env=env)
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
        p = subprocess.Popen([BIN] + args + ["-e", CODE], stdin=slave, stdout=slave, stderr=slave, env=env)
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

checks = [
    ("piped",                         piped, {},                     [],             False),
    ("piped, FORCE_COLOR=1",          piped, {"FORCE_COLOR": "1"},   [],             True),
    ("piped, FORCE_COLOR=0",          piped, {"FORCE_COLOR": "0"},   [],             False),
    ("piped, CLICOLOR_FORCE=1",       piped, {"CLICOLOR_FORCE": "1"},[],             True),
    ("piped, FORCE_COLOR & --no-color", piped, {"FORCE_COLOR": "1"}, ["--no-color"], False),
    ("terminal",                      pty,   {},                     [],             True),
    ("terminal, NO_COLOR=1",          pty,   {"NO_COLOR": "1"},      [],             False),
    ("terminal, TERM=dumb",           pty,   {"TERM": "dumb"},       [],             False),
    ("terminal, --no-color",          pty,   {},                     ["--no-color"], False),
]

failed = 0
for name, run, env, args, expected in checks:
    out = run(env, args)
    got = RED in out
    ok = got == expected
    failed += not ok
    print(("ok  " if ok else "FAIL"), name, "->", "colors" if got else "no colors", "" if ok else repr(out))

sys.exit(1 if failed else 0)
