window.snippetId = "";
window.loadedCode = "";
window.loadedFromUrl = false;
window.loadedFromExample = false; // NEW: Track if current code is an unmodified example
window.terminalColumns = 80; // Default fallback
window.commandLineArgs = ""; // Store command-line arguments

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
                    cols: window.terminalColumns,
                    args: window.commandLineArgs
                }
            );
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
        document.querySelector("#argsbutton").classList.remove("expanded");
        document.querySelector("#examplesbutton").classList.remove("expanded");
    } else {
        window.expanded = true;
        document.querySelector(".doccols").style.display = "inherit";
        document.querySelector("#expanderIcon").classList.add("expanded");
        document.querySelector("#runbutton").classList.add("expanded");
        document.querySelector("#sharebutton").classList.add("expanded");
        document.querySelector("#expander").classList.add("expanded");
        document.querySelector("#wordwrapper").classList.add("expanded");
        document.querySelector("#argsbutton").classList.add("expanded");
        document.querySelector("#examplesbutton").classList.add("expanded");
    }
}

window.wordwrap = false;
function toggleWordWrap(){
    if (window.wordwrap) {
        window.wordwrap = false;
        editor.setOption("wrap", false);
        document.querySelector("#wordwrapperIcon").classList.remove("wrapped");
        showToast("Word wrap: OFF");
    } else {
        window.wordwrap = true;
        editor.setOption("wrap", true);
        document.querySelector("#wordwrapperIcon").classList.add("wrapped");
        showToast("Word wrap: ON");
    }
}

function toggleTerminalInfo() {
    var info = document.getElementById('terminal-info');
    var button = document.getElementById('terminal-info-toggle');
    
    if (info.style.display === 'none') {
        info.style.display = 'block';
        button.style.background = 'rgba(255,255,255,0.15)';
        button.style.color = '#aaa';
    } else {
        info.style.display = 'none';
        button.style.background = 'rgba(255,255,255,0.1)';
        button.style.color = '#888';
    }
}

// Show toast notification
function showToast(message) {
    let toast = document.getElementById('toast-notification');
    
    // Create toast element if it doesn't exist
    if (!toast) {
        toast = document.createElement('div');
        toast.id = 'toast-notification';
        toast.style.cssText = `
            position: fixed;
            left: 25%;
            top: calc(52px + (100vh - 52px)/2 - 30px);
            transform: translateX(-50%);
            background: rgba(45, 45, 45, 0.95);
            color: white;
            padding: 10px 20px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 500;
            letter-spacing: 0.2px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
            z-index: 10000;
            opacity: 0;
            pointer-events: none;
            transition: opacity 0.2s ease, transform 0.2s ease;
        `;
        document.body.appendChild(toast);
    }
    
    // Set message and show
    toast.textContent = message;
    toast.style.opacity = '1';
    toast.style.transform = 'translateX(-50%) translateY(-3px)';
    
    // Hide after 1.5 seconds
    setTimeout(() => {
        toast.style.opacity = '0';
        toast.style.transform = 'translateX(-50%)';
    }, 1500);
}

// Show command-line arguments dialog
function showArgsDialog() {
    Bulma().alert({
        type: 'info',
        title: 'Command-line Arguments',
        body: `
            <div class="field">
                <label class="label" style="font-size: 14px; font-weight: 600;">Arguments</label>
                <div class="control">
                    <input id='cmdline-args' class='input' type='text' placeholder='e.g., arg1 arg2 arg3' value='${window.commandLineArgs}' style="font-size: 14px;">
                </div>
                <p class="help" style="font-size: 12px;">Space-separated arguments passed to your script</p>
            </div>
        `,
        confirm: {
            label: 'Save',
            onClick: function(){
                var argsInput = document.getElementById("cmdline-args");
                if (argsInput) {
                    window.commandLineArgs = argsInput.value.trim();
                    showToast(window.commandLineArgs ? "Arguments saved" : "Arguments cleared");
                }
            }
        },
        cancel: 'Cancel'
    });
    
    // Apply minimal modal styling
    setTimeout(() => {
        applyModalStyling();
        const input = document.getElementById("cmdline-args");
        if (input) input.focus();
    }, 50);
}

// Load and show examples dialog
function showExamplesDialog() {
    // Show loading state
    Bulma().alert({
        type: 'info',
        title: 'Load Example',
        body: '<div class="has-text-centered" style="padding: 32px;"><div class="loader"></div><p style="margin-top: 16px; color: #666;">Loading examples...</p></div>',
        cancel: 'Close'
    });
    
    applyModalStyling();
    
    // Fetch examples list
    ajaxPost("http://188.245.97.105/%<[basePath]>%/backend/getexamples.php",
    function (result) {
        var examples = JSON.parse(result);
        
        // Build examples list HTML with search
        var examplesHtml = `
            <div class="field" style="margin-bottom: 12px;">
                <div class="control">
                    <input id="examples-search" class="input is-small" type="text" placeholder="Search examples..." style="font-size: 13px;">
                </div>
            </div>
            <div id="examples-list" style="max-height: 400px; overflow-y: auto; border: 1px solid #e8e8e8; border-radius: 4px;">
        `;
        
        if (examples && examples.length > 0) {
            examples.forEach(function(example) {
                var displayName = example.replace(/_/g, ' ').replace(/\b\w/g, l => l.toUpperCase());
                examplesHtml += `
                    <div class="example-item" data-name="${example.toLowerCase()}" data-display="${displayName.toLowerCase()}" 
                         style="padding: 10px 12px; border-bottom: 1px solid #f0f0f0; cursor: pointer; transition: background-color 0.12s;" 
                         onmouseover="this.style.backgroundColor='#f5f5f5'" 
                         onmouseout="this.style.backgroundColor='white'"
                         onclick="loadExampleFromDialog('${example}')">
                        <div style="font-weight: 600; color: #363636; font-size: 14px;">${displayName}</div>
                        <div style="font-size: 11px; color: #999; font-family: 'Fira Code Arturo', monospace; margin-top: 2px;">${example}.art</div>
                    </div>
                `;
            });
        } else {
            examplesHtml += '<div style="padding: 32px; text-align: center; color: #999;">No examples available</div>';
        }
        
        examplesHtml += '</div>';
        
        // Show examples dialog
        Bulma().alert({
            type: 'info',
            title: 'Load Example',
            body: examplesHtml,
            cancel: 'Close'
        });
        
        // Setup search functionality and styling
        setTimeout(() => {
            applyModalStyling();
            
            var searchInput = document.getElementById('examples-search');
            if (searchInput) {
                searchInput.focus();
                searchInput.addEventListener('input', function() {
                    var query = this.value.toLowerCase();
                    var items = document.querySelectorAll('.example-item');
                    
                    items.forEach(function(item) {
                        var name = item.getAttribute('data-name');
                        var display = item.getAttribute('data-display');
                        
                        if (name.includes(query) || display.includes(query)) {
                            item.style.display = '';
                        } else {
                            item.style.display = 'none';
                        }
                    });
                });
            }
        }, 50);
    }, {});
}

// Load example from dialog selection
function loadExampleFromDialog(exampleName) {
    // Close the modal first
    var modal = document.querySelector('.modal.is-active');
    if (modal) {
        modal.classList.remove('is-active');
        document.documentElement.classList.remove('is-clipped');
    }
    
    // Then load the example
    setTimeout(() => {
        getExample(exampleName);
        document.getElementById('scriptName').innerHTML = `${exampleName}.art`;
        showToast(`Loaded: ${exampleName}`);
    }, 100);
}

function applyModalStyling() {
    var style = document.getElementById('custom-modal-style');
    if (!style) {
        style = document.createElement('style');
        style.id = 'custom-modal-style';
        style.textContent = `
            .modal-card-head {
                background-color: #f8f8f8 !important;
                padding: 12px 16px !important;
                border-bottom: 1px solid #e0e0e0 !important;
            }
            .modal-card-title {
                font-size: 16px !important;
                font-weight: 600 !important;
                color: #333 !important;
            }
            .modal-card-body {
                padding: 16px !important;
            }
            .modal-card-foot {
                background-color: #f8f8f8 !important;
                padding: 12px 16px !important;
                border-top: 1px solid #e0e0e0 !important;
            }
            .button.is-info {
                background-color: #666 !important;
                border-color: #666 !important;
            }
            .button.is-info:hover {
                background-color: #555 !important;
                border-color: #555 !important;
            }
        `;
        document.head.appendChild(style);
    }
}