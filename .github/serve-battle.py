#!/usr/bin/env python3
# temporary battle-test harness for `serve` (to be removed)
# usage: python3 serve-battle.py <arturo-binary>

import http.client, os, signal, socket, subprocess, sys, tempfile, time

ARTURO = sys.argv[1]
WORK = tempfile.mkdtemp(prefix="serve-battle-")
IS_WIN = os.name == "nt"

results = []

def record(group, name, ok, detail=""):
    results.append((group, name, ok, detail))
    print(f"{'PASS' if ok else 'FAIL'}  [{group}] {name}  {detail}", flush=True)

def write(name, src):
    p = os.path.join(WORK, name)
    with open(p, "w", encoding="utf-8") as f:
        f.write(src)
    return p

def wait_port(port, proc, secs=20):
    end = time.time() + secs
    while time.time() < end:
        if proc.poll() is not None:
            return False
        try:
            socket.create_connection(("127.0.0.1", port), timeout=0.3).close()
            return True
        except OSError:
            time.sleep(0.1)
    return False

def killtree(proc):
    if proc.poll() is None:
        if IS_WIN:
            subprocess.run(["taskkill", "/F", "/T", "/PID", str(proc.pid)], capture_output=True)
        else:
            try: os.killpg(proc.pid, signal.SIGKILL)
            except OSError: proc.kill()
    try: proc.wait(timeout=10)
    except subprocess.TimeoutExpired: pass

class Server:
    def __init__(self, script, port):
        self.script, self.port, self.proc, self.logs = script, port, None, []
        self.start()

    def start(self):
        log = open(self.script + f".{len(self.logs)}.log", "w+")
        self.logs.append(log)
        kw = {}
        if not IS_WIN:
            kw["start_new_session"] = True
        self.proc = subprocess.Popen([ARTURO, self.script], stdout=log, stderr=subprocess.STDOUT, **kw)
        if not wait_port(self.port, self.proc):
            print(f"!! server {self.script} failed to start", flush=True)

    def alive(self):
        return self.proc.poll() is None

    def stop(self):
        killtree(self.proc)

    def dump(self):
        for l in self.logs:
            l.flush(); l.seek(0)
            txt = l.read()
            if txt.strip():
                print(f"----- {os.path.basename(l.name)}\n{txt[-4000:]}")

def req(port, method, path, body=None, headers=None, timeout=5):
    c = http.client.HTTPConnection("127.0.0.1", port, timeout=timeout)
    try:
        c.request(method, path, body=body, headers=headers or {})
        r = c.getresponse()
        data = r.read().decode("utf-8", "replace") if method != "HEAD" else ""
        return r.status, data, dict(r.getheaders())
    except Exception as e:
        return None, f"<{type(e).__name__}: {e}>", {}
    finally:
        c.close()

def run_cases(group, srv, cases):
    for (method, path, body, hdrs, exp_status, exp_body) in cases:
        status, data, _ = req(srv.port, method, path, body, hdrs)
        time.sleep(0.15)
        alive = srv.alive()
        name = f"{method} {path}" + (f" body={body!r}" if body is not None else "")
        ok = alive and (exp_status is None or status == exp_status) \
                   and (exp_body is None or exp_body in data)
        detail = f"-> {status} {data[:60]!r}"
        if not alive:
            detail += f"  SERVER DIED (exit={srv.proc.returncode})"
            srv.start()
        record(group, name, ok, detail)

FORM = {"Content-Type": "application/x-www-form-urlencoded"}
JSON = {"Content-Type": "application/json"}

#----------------------------------------
# 1. DSL routes
#----------------------------------------
dsl = write("dsl.art", r'''
serve .port: 19101 [
    GET "/"             -> "Welcome"
    GET "/about"        [ "About us" ]
    GET {//user/(?<name>[a-z]+)/} $[name][
        emit.html ~"Hello, |name|!"
    ]
    GET {//product/(?<id>[0-9]+)/(?<slug>[a-z-]+)/} $[id, slug][
        ~"item |id| |slug|"
    ]
    GET "/post" $[id][ emit.html ~"post id: |id|" ]
    POST "/login" $[username, password][
        emit.json write.json #[ msg: ~"Welcome back, |username|!" ] ø
    ]
    POST "/getinfo" $[id][
        emit.json write.json #[ i: id msg: "info" ] ø
    ]
    PUT "/put" $[x][ ~"put |x|" ]
    DELETE "/del" -> "deleted"
    GET "/boom" [ 1 / 0 ]
    GET "/status" [ emit.status: 201 .headers: #["X-Foo": "bar"] "created" ]
    GET "/int" -> 42
    GET "/dict" -> #[a: 1]
    GET "/blk" -> [1 2 3]
    GET "/nul" -> null
    GET "/bin" [ to :binary "abc" ]
    GET {//.*/}         -> "catch-all"
]
''')
s = Server(dsl, 19101)
run_cases("dsl", s, [
    ("GET",    "/",                None, None, 200, "Welcome"),
    ("GET",    "/about",           None, None, 200, "About us"),
    ("GET",    "/user/john",       None, None, 200, "Hello, john!"),        # 2203
    ("GET",    "/user/John",       None, None, 200, "catch-all"),
    ("GET",    "/product/12/foo-bar", None, None, 200, "item 12 foo-bar"),
    ("GET",    "/post?id=5",       None, None, 200, "post id: 5"),
    ("GET",    "/post",            None, None, None, None),                 # missing param
    ("GET",    "/post?foo=1",      None, None, None, None),
    ("POST",   "/login",  "username=admin&password=secret", FORM, 200, "Welcome back, admin!"),
    ("POST",   "/login",  '{"username":"admin","password":"x"}', JSON, 200, "Welcome back, admin!"),
    ("POST",   "/getinfo", "id=5", FORM, 200, '"5"'),                       # 2046
    ("POST",   "/getinfo", "",     FORM, None, None),                       # 2046
    ("POST",   "/getinfo", "foo=1", FORM, None, None),
    ("POST",   "/getinfo", "5",    JSON, None, None),
    ("POST",   "/getinfo", "[1,2]", JSON, None, None),
    ("PUT",    "/put",     "x=1",  FORM, 200, "put 1"),
    ("DELETE", "/del",     None, None, 200, "deleted"),
    ("PATCH",  "/nope",    None, None, 404, None),
    ("HEAD",   "/",        None, None, None, None),
    ("OPTIONS","/",        None, None, None, None),
    ("GET",    "/boom",    None, None, 500, None),
    ("GET",    "/status",  None, None, 201, "created"),
    ("GET",    "/int",     None, None, 200, "42"),
    ("GET",    "/dict",    None, None, None, None),
    ("GET",    "/blk",     None, None, 200, "1 2 3"),
    ("GET",    "/nul",     None, None, 200, None),
    ("GET",    "/bin",     None, None, 200, "abc"),
    ("GET",    "/a%20b/%C3%BC", None, None, 200, "catch-all"),
    ("GET",    "/",        None, None, 200, "Welcome"),
])
s.stop(); s.dump()

#----------------------------------------
# 1b. regex routes containing '/i', '/m', '/s'
#----------------------------------------
lex = write("lexer.art", r'''
serve .port: 19106 [
    GET {//items/(?<n>[0-9]+)/}  $[n][ ~"items |n|" ]
    GET {//static/(?<f>.+)/}     $[f][ ~"static |f|" ]
    GET {//search/i}             -> "ci search"
]
''')
s = Server(lex, 19106)
run_cases("lexer", s, [
    ("GET", "/items/3",       None, None, 200, "items 3"),
    ("GET", "/static/a.css",  None, None, 200, "static a.css"),
    ("GET", "/SEARCH",        None, None, 200, "ci search"),
])
s.stop(); s.dump()

#----------------------------------------
# 2. function-form routes
#----------------------------------------
fn = write("fn.art", r'''
serve .port: 19102 $[req][
    p: req\path
    if p = "/str"    -> return "plain"
    if p = "/dict"   -> return #[body: "d" status: 201 headers: #["X-A": "1"]]
    if p = "/int"    -> return 42
    if p = "/null"   -> return null
    if p = "/err"    -> return 1 / 0
    if p = "/badst"  -> return #[body: "x" status: "abc"]
    if p = "/inthdr" -> return #[body: "x" headers: #["X-N": 5]]
    if p = "/q"      -> return req\query\a
    if p = "/form"   -> return req\body\a
    return "default"
]
''')
s = Server(fn, 19102)
run_cases("fn", s, [
    ("GET",    "/str",    None, None, 200, "plain"),
    ("GET",    "/dict",   None, None, 201, "d"),
    ("GET",    "/int",    None, None, 200, "42"),
    ("GET",    "/null",   None, None, None, None),
    ("GET",    "/err",    None, None, 500, None),
    ("GET",    "/badst",  None, None, None, None),
    ("GET",    "/inthdr", None, None, 200, "x"),
    ("GET",    "/q?a=hello", None, None, 200, "hello"),
    ("POST",   "/form",   "a=world", FORM, 200, "world"),
    ("HEAD",   "/str",    None, None, 200, None),
    ("OPTIONS","/str",    None, None, 200, "plain"),
    ("GET",    "/str",    None, None, 200, "plain"),
])
s.stop(); s.dump()

#----------------------------------------
# 3. load / parallel / big bodies
#----------------------------------------
load = write("load.art", r'''
serve.silent .port: 19103 [
    GET {//n/(?<k>[0-9]+)/} $[k][ ~"n=|k|" ]
    POST "/echo" $[data][ data ]
]
''')
s = Server(load, 19103)
from concurrent.futures import ThreadPoolExecutor
t0 = time.time()
with ThreadPoolExecutor(64) as ex:
    res = list(ex.map(lambda k: req(19103, "GET", f"/n/{k}", timeout=20), range(1500)))
bad = [(k, r[0], r[1][:40]) for k, r in enumerate(res) if r[0] != 200 or r[1] != f"n={k}"]
record("load", "1500 reqs / 64 parallel", not bad and s.alive(),
       f"{time.time()-t0:.1f}s, {len(bad)} bad {bad[:3]}")
big = "a" * 5_000_000
st, data, _ = req(19103, "POST", "/echo", "data=" + big, FORM, timeout=60)
record("load", "5MB form echo", st == 200 and len(data) == len(big), f"-> {st} len={len(data)}")
for raw in [b"GARBAGE\r\n\r\n",
            b"GET / HTTP/1.1\r\nContent-Length: 999999\r\n\r\nabc",
            b"POST /echo HTTP/1.1\r\nContent-Length: -5\r\n\r\n",
            b"POST /echo HTTP/1.1\r\nContent-Length: abc\r\n\r\n",
            b"BREW / HTTP/1.1\r\n\r\n"]:
    try:
        so = socket.create_connection(("127.0.0.1", 19103), timeout=2)
        so.sendall(raw)
        try: so.recv(100)
        except OSError: pass
        so.close()
    except OSError:
        pass
    time.sleep(0.2)
    record("load", f"malformed {raw[:30]!r}", s.alive(), "" if s.alive() else "SERVER DIED")
    if not s.alive(): s.start()
st, data, _ = req(19103, "GET", "/n/7")
record("load", "still serving after malformed", st == 200 and data == "n=7", f"-> {st} {data!r}")
s.stop(); s.dump()

#----------------------------------------
# 4. signals (POSIX)
#----------------------------------------
if not IS_WIN:
    sig = write("sig.art", 'serve.silent .port: 19104 [ GET "/" -> "ok" ]\n')
    for signame in ["SIGTERM", "SIGINT", "SIGHUP"]:
        s = Server(sig, 19104)
        req(19104, "GET", "/")
        s.proc.send_signal(getattr(signal, signame))
        try:
            s.proc.wait(timeout=5)
            record("signal", f"{signame} stops server", True, f"exit={s.proc.returncode}")
        except subprocess.TimeoutExpired:
            record("signal", f"{signame} stops server", False, "still running after 5s")
        s.stop()

#----------------------------------------
# 5. serve.async lifecycle
#----------------------------------------
asy = write("async.art", r'''
t: serve.async.silent .port: 19105 [ GET "/" -> "one" ]
pause 1500
print ["A" read "http://127.0.0.1:19105/"]
cancel t
pause 1000
t2: serve.async.silent .port: 19105 [ GET "/" -> "two" ]
pause 1500
print ["B" read "http://127.0.0.1:19105/"]
print ["C" read "http://127.0.0.1:19105/"]
cancel t2
print "done"
''')
p = subprocess.Popen([ARTURO, asy], stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True,
                     **({} if IS_WIN else {"start_new_session": True}))
try:
    out, _ = p.communicate(timeout=40)
    ok = "A one" in out and "B two" in out and "C two" in out and "done" in out
    record("async", "serve.async + cancel + rebind", ok, repr(out[-300:]))
except subprocess.TimeoutExpired:
    killtree(p)
    try: out, _ = p.communicate(timeout=5)
    except subprocess.TimeoutExpired: out = ""
    record("async", "serve.async + cancel + rebind", False, "TIMEOUT " + repr(out[-300:]))
time.sleep(1)
try:
    socket.create_connection(("127.0.0.1", 19105), timeout=1).close()
    record("async", "port freed after cancel", False, "something still listening on 19105")
except OSError:
    record("async", "port freed after cancel", True)

#----------------------------------------
# summary
#----------------------------------------
fails = [r for r in results if not r[2]]
lines = ["| | group | case | detail |", "|-|-|-|-|"]
for g, n, ok, d in results:
    lines.append(f"| {'✅' if ok else '❌'} | {g} | `{n}` | `{d.replace('|', '¦')[:120]}` |")
summ = os.environ.get("GITHUB_STEP_SUMMARY")
if summ:
    with open(summ, "a", encoding="utf-8") as f:
        f.write(f"### serve battle-test: {len(results)-len(fails)}/{len(results)} passed\n\n")
        f.write("\n".join(lines) + "\n")
print(f"\n{len(results)-len(fails)}/{len(results)} passed")
sys.exit(1 if fails else 0)
