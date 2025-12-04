window.snippetId = "";
window.loadedCode = "";
window.loadedFromUrl = false;
window.loadedFromExample = false; // NEW: Track if current code is an unmodified example
window.terminalColumns = 80; // Default fallback

var editor = ace.edit("editor");
document.getElementsByTagName("textarea")[0].setAttribute("aria-label", "code snippet");
editor.setTheme("ace/theme/monokai");
editor.getSession().setMode("ace/mode/arturo");

// Calculate terminal width in columns
function calculateTerminalColumns() {
    var terminal = document.getElementById('terminal');
    if (!terminal) return 80;
    
    // Create a temporary span to measure character width
    var testSpan = document.createElement('span');
    testSpan.style.visibility = 'hidden';
    testSpan.style.position = 'absolute';
    testSpan.style.fontFamily = window.getComputedStyle(terminal).fontFamily;
    testSpan.style.fontSize = window.getComputedStyle(terminal).fontSize;
    testSpan.textContent = 'M';
    document.body.appendChild(testSpan);
    
    var charWidth = testSpan.offsetWidth;
    document.body.removeChild(testSpan);
    
    // Get terminal width in pixels
    var terminalWidth = terminal.offsetWidth;
    
    // Calculate columns (subtract padding)
    var columns = Math.floor((terminalWidth - 40) / charWidth);
    columns = columns - 3; // Fine-tune 
    
    // Clamp between reasonable values
    return Math.max(40, Math.min(200, columns));
}

// Update button states based on current editor state
function updateButtonStates() {
    var currentCode = editor.getValue();
    var runButton = document.getElementById('runbutton');
    var shareButton = document.getElementById('sharebutton');
    
    // Update run button state
    if (currentCode === window.previousCode) {
        runButton.classList.add('disabled');
    } else {
        runButton.classList.remove('disabled');
    }
    
    // Update share button state
    if (!currentCode.trim() || !window.snippetId) {
        shareButton.classList.add('disabled');
    } else {
        shareButton.classList.remove('disabled');
    }
}

// Add keyboard shortcut for code execution
editor.commands.addCommand({
    name: 'executeCode',
    bindKey: {win: 'Ctrl-Enter', mac: 'Command-Enter'},
    exec: function(editor) {
        var runbutton = document.getElementById('runbutton');
        
        if (runbutton.classList.contains('working') || runbutton.classList.contains('disabled')) {
            return;
        }
        
        runbutton.classList.add('hover-effect');
        setTimeout(function() {
            runbutton.classList.remove('hover-effect');
        }, 200);
        
        execCode();
    },
    readOnly: false
});

// Listen for editor changes to update button states
editor.getSession().on('change', function() {
    // NEW: If user modifies code from an example, it's no longer an unmodified example
    if (window.loadedFromExample && editor.getValue() !== window.loadedCode) {
        window.loadedFromExample = false;
    }
    updateButtonStates();
});

window.previousCode = "";
function execCode() {
    var runbutton = document.getElementById('runbutton');
    
    // Don't execute if disabled or already working
    if (runbutton.classList.contains('disabled') || runbutton.classList.contains('working')) {
        return;
    }
    
    if (!runbutton.innerHTML.includes("notch")) {
        var currentCode = editor.getValue();
        
        if (currentCode != previousCode) {
            previousCode = currentCode;
            
            // Determine whether to create new snippet or update existing
            var snippetToSend = "";
            
            // If it's an unmodified example, don't save to database
            if (window.loadedFromExample && currentCode === window.loadedCode) {
                snippetToSend = "SKIP_SAVE"; // Special flag to tell backend not to save
            }
            // If loaded from URL and modified, create new snippet
            else if (window.loadedFromUrl && currentCode !== window.loadedCode) {
                snippetToSend = "";
                window.loadedFromUrl = false;
            } 
            // Otherwise use existing snippet ID (empty string creates new)
            else {
                snippetToSend = window.snippetId;
            }
            
            runbutton.classList.add('working');
            document.getElementById("terminal_output").innerHTML = "";
            ajaxPost("http://188.245.97.105/%<[basePath]>%/backend/exec.php",

            function (result) {
                var got = JSON.parse(result);
                document.getElementById("terminal_output").innerHTML = got.text;
                
                // Only update snippetId if we actually saved (backend will return empty code if skipped)
                if (got.code && got.code !== "") {
                    window.snippetId = got.code;
                    window.loadedCode = currentCode;
                    window.loadedFromExample = false; // No longer an unmodified example
                    
                    // Update URL with snippet ID
                    window.history.replaceState(
                        {code: got.code, text: got.text}, 
                        `${got.code} - Playground | Arturo programming language`, 
                        `http://188.245.97.105/%<[basePath]>%/playground/${got.code}`
                    );
                } else {
                    // Example executed without saving - don't update URL
                    window.loadedCode = currentCode;
                }

                runbutton.classList.remove('working');
                updateButtonStates(); // Update states after execution
                window.scroll.animateScroll(document.querySelector("#terminal"), null, {updateURL: false});
            }, {
                c: currentCode,
                i: snippetToSend,
                cols: window.terminalColumns
            });
        }
    }
}

function getSnippet(cd) {
    ajaxPost("http://188.245.97.105/%<[basePath]>%/backend/get.php",
    
    function (result) {
        var got = JSON.parse(result);
        editor.setValue(got.text);
        window.loadedCode = got.text;
        window.snippetId = cd;
        window.loadedFromUrl = true;
        editor.clearSelection();
        editor.resize(true);
        editor.scrollToLine(1,0,true,true,function(){});
        editor.gotoLine(1,0,true);
        
        // Update button states after loading snippet
        window.previousCode = got.text;
        updateButtonStates();
    }, {
        i:cd
    });
}

function getExample(cd) {
    ajaxPost("http://188.245.97.105/%<[basePath]>%/backend/example.php",
    
    function (result) {
        var got = JSON.parse(result);
        editor.setValue(got.text+"\n");
        window.loadedCode = got.text+"\n";
        window.snippetId = "";
        window.loadedFromUrl = false;
        window.loadedFromExample = true;
        editor.clearSelection();
        editor.resize(true);
        editor.scrollToLine(1,0,true,true,function(){});
        editor.gotoLine(1,0,true);
        
        // Update button states after loading example
        window.previousCode = "";
        updateButtonStates();
    }, {
        i:cd
    });
}

function parse_query_string(query) {
    var vars = query.split("&");
    var query_string = {};
    for (var i = 0; i < vars.length; i++) {
        var pair = vars[i].split("=");
        var key = decodeURIComponent(pair[0]);
        var value = decodeURIComponent(pair[1]);
        if (typeof query_string[key] === "undefined") {
            query_string[key] = decodeURIComponent(value);
        } else if (typeof query_string[key] === "string") {
            var arr = [query_string[key], decodeURIComponent(value)];
            query_string[key] = arr;
        } else {
            query_string[key].push(decodeURIComponent(value));
        }
    }
    return query_string;
}

document.addEventListener("DOMContentLoaded", function() {
    // Calculate initial terminal width
    window.terminalColumns = calculateTerminalColumns();
    
    // Check for snippet ID in URL path (e.g., /playground/abc123)
    var pathParts = window.location.pathname.split('/');
    var snippetId = pathParts[pathParts.length - 1];
    
    if (snippetId && snippetId !== 'playground' && snippetId !== '') {
        getSnippet(snippetId);
    } 
    // Fallback to query string for examples (e.g., ?example=hello)
    else if (window.location.search != "") {
        var query = window.location.search.substring(1);
        var qs = parse_query_string(query);
        
        if (qs.example !== undefined) {
            getExample(qs.example);
            document.getElementById('scriptName').innerHTML = `${qs.example}.art`;
        }
    } else {
        // Initialize button states for empty editor
        updateButtonStates();
    }
});

// Recalculate terminal width on window resize
window.addEventListener('resize', function() {
    window.terminalColumns = calculateTerminalColumns();
});

function shareLink(){
    var shareButton = document.getElementById('sharebutton');
    
    // Don't share if button is disabled
    if (shareButton.classList.contains('disabled')) {
        return;
    }
    
    if (window.snippetId != "") {
        Bulma().alert({
            type: 'info',
            title: 'Share this script',
            body: `<input id='snippet-link' class='input is-info' value='http://188.245.97.105/%<[basePath]>%/playground/${window.snippetId}'>`,
            confirm: {
                label: 'Copy link',
                onClick: function(){
                    var copyText = document.getElementById("snippet-link");
                    copyText.select();
                    copyText.setSelectionRange(0, 99999);
                    document.execCommand("copy");
                    (window.getSelection ? window.getSelection() : document.selection).empty();
                    Bulma().alert({
                        type: 'success',
                        title: 'Copied',
                        body: 'Ready to go!'
                    });
                }
            },
            cancel: 'Close'
        });
    }
}

window.expanded = false;
function toggleExpand(){
    if (window.expanded) {
        window.expanded = false;
        document.querySelector(".doccols").style.display = "flex";
        document.querySelector("#expanderIcon").classList.remove("expanded");
        document.querySelector("#runbutton").classList.remove("expanded");
        document.querySelector("#sharebutton").classList.remove("expanded");
        document.querySelector("#expander").classList.remove("expanded");
        document.querySelector("#wordwrapper").classList.remove("expanded");
    } else {
        window.expanded = true;
        document.querySelector(".doccols").style.display = "inherit";
        document.querySelector("#expanderIcon").classList.add("expanded");
        document.querySelector("#runbutton").classList.add("expanded");
        document.querySelector("#sharebutton").classList.add("expanded");
        document.querySelector("#expander").classList.add("expanded");
        document.querySelector("#wordwrapper").classList.add("expanded");
    }
}

window.wordwrap = false;
function toggleWordWrap(){
    if (window.wordwrap) {
        window.wordwrap = false;
        editor.setOption("wrap", false);
        document.querySelector("#wordwrapperIcon").classList.remove("wrapped");
    } else {
        window.wordwrap = true;
        editor.setOption("wrap", true);
        document.querySelector("#wordwrapperIcon").classList.add("wrapped");
    }
}