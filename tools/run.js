#!/usr/bin/env node
//----------------------------------------------------
// Node.js script to be used for executing 
// Arturo scripts, via the command-line, 
// using our Web/JS binary
//
// Example:
//    node tools/run.js <path-to-arturo-script>
// Or:
//    ./tools/run.js <path-to-arturo-script>
//----------------------------------------------------

// module imports
const fs = require('fs');

// the path to our Web-mode Arturo "binary"
var arturoBinary = './bin/arturo.js';
if (process.argv.length == 4 && process.argv[3] == "--mini") {
    arturoBinary = "./bin/arturo.min.js"
}

// the path to the Arturo script we want to execute
// e.g. the unit-test file
let scriptToExecute = process.argv[2];

// read the Arturo JS script and execute it
// into the global namespace; after this,
// A$ is available anywhere!
fs.readFile(arturoBinary, 'utf8', (err, data) => {
    if (err) { console.error(err); return; }
    (1, eval)(data);
    executeScript();
});

// finally, execute given Arturo script
function executeScript(){
    fs.readFile(scriptToExecute, 'utf8', (err, data) => {
        if (err) { console.error(err); return; }
        // The "magic" function that calls directly
        // our VM's `run`
        A$(data);
    })
}