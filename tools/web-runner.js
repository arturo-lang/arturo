#!/usr/bin/env node
//----------------------------------------------------
// Runs an Arturo script using our Web/JS build,
// the same way a web page would: the whole
// "binary" is evaluated in the global scope
// and then we call `A$`
//
// Works both with Node.js & Deno:
//    node tools/web-runner.js <script>
//    deno run --allow-read --allow-env --allow-run tools/web-runner.js <script>
//
// Or, for inline code:
//    node tools/web-runner.js -e 'print "hello"'
//
// The build to use can be set via ARTURO_JS
// (default: bin/arturo.js)
//
// To give up on scripts that take too long, set
// ARTURO_JS_TIMEOUT (in seconds): the script then
// runs in a child process that gets killed if needed
//----------------------------------------------------

const isDeno = typeof Deno !== 'undefined';

const args = isDeno ? Deno.args : process.argv.slice(2);
const getEnv = (k) => isDeno ? Deno.env.get(k) : process.env[k];
const readFile = isDeno
    ? (f) => Deno.readTextFileSync(f)
    : (f) => require('fs').readFileSync(f, 'utf8');
const writeOut = isDeno
    ? (s) => Deno.stdout.writeSync(new TextEncoder().encode(s))
    : (s) => process.stdout.write(s);
const quit = isDeno
    ? (c) => Deno.exit(c)
    : (c) => process.exit(c);

if (args.length < 1 || (args[0] == '-e' && args.length < 2)) {
    console.log("usage: web-runner.js <script> | -e <code>");
    quit(1);
}

const timeout = parseInt(getEnv('ARTURO_JS_TIMEOUT') || '0');
const tookTooLong = () => {
    writeOut("Timeout: script took more than " + timeout + "s\n");
    quit(1);
};

if (timeout > 0 && !getEnv('ARTURO_JS_CHILD')) {
    if (isDeno) {
        const child = new Deno.Command(Deno.execPath(), {
            args: ['run', '--allow-read', '--allow-env', '--allow-run', Deno.mainModule, ...args],
            env: { ARTURO_JS_CHILD: '1' },
            stdout: 'inherit',
            stderr: 'inherit',
            signal: AbortSignal.timeout(timeout * 1000)
        }).spawn();
        child.status.then((s) => s.signal ? tookTooLong() : quit(s.code));
    } else {
        const r = require('child_process').spawnSync(process.execPath, [__filename, ...args], {
            env: { ...process.env, ARTURO_JS_CHILD: '1' },
            stdio: 'inherit',
            timeout: timeout * 1000
        });
        if (r.error && r.error.code === 'ETIMEDOUT') tookTooLong();
        quit(r.status === null ? 1 : r.status);
    }
} else {
    runScript();
}

function runScript() {
    // as with `arturo --no-color`, we don't want colors
    // in the output (Web builds always emit them, for now)
    // and errors go to the same output as everything else
    const ansi = /\x1b\[[0-9;]*m/g;
    const clean = (a) => a.map((x) => typeof x === 'string' ? x.replace(ansi, '') : x);
    const log = console.log;
    console.log = (...a) => log(...clean(a));
    console.error = (...a) => log(...clean(a));

    // load the Arturo "binary" into the global namespace
    (0, eval)(readFile(getEnv('ARTURO_JS') || 'bin/arturo.js'));

    // and run the script
    const code = args[0] == '-e' ? args[1] : readFile(args[0]);

    try {
        globalThis['A$'](code);
    } catch (e) {
        // anything uncaught on the JS side
        writeOut("JS Exception: " + ((e && e.message) || e) + "\n");
        quit(1);
    }
}
