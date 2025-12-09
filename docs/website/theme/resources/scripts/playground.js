window.snippetId = "";
window.loadedCode = "";
window.loadedFromUrl = false;
window.loadedFromExample = false;
window.terminalColumns = 80;
window.commandLineArgs = "";
window.pageLoaded = false;

var editor = ace.edit("editor");
document.getElementsByTagName("textarea")[0].setAttribute("aria-label", "code snippet");
editor.setTheme("ace/theme/monokai");
editor.getSession().setMode("ace/mode/arturo");

function calculateTerminalColumns() {
    var terminal = document.getElementById('terminal');
    if (!terminal) return 80;
    
    var testSpan = document.createElement('span');
    testSpan.style.visibility = 'hidden';
    testSpan.style.position = 'absolute';
    testSpan.style.fontFamily = window.getComputedStyle(terminal).fontFamily;
    testSpan.style.fontSize = window.getComputedStyle(terminal).fontSize;
    testSpan.textContent = 'M';
    document.body.appendChild(testSpan);
    
    var charWidth = testSpan.offsetWidth;
    document.body.removeChild(testSpan);
    
    var terminalWidth = terminal.offsetWidth;
    
    var columns = Math.floor((terminalWidth - 40) / charWidth);
    columns = columns - 3;
    
    return Math.max(40, Math.min(200, columns));
}

function updateButtonStates() {
    var currentCode = editor.getValue();
    var runButton = document.getElementById('runbutton');
    var shareButton = document.getElementById('sharebutton');
    
    if (currentCode === window.previousCode) {
        runButton.classList.add('disabled');
    } else {
        runButton.classList.remove('disabled');
    }
    
    if (!currentCode.trim() || !window.snippetId) {
        shareButton.classList.add('disabled');
    } else {
        shareButton.classList.remove('disabled');
    }
}

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

editor.getSession().on('change', function() {
    if (window.loadedFromExample && editor.getValue() !== window.loadedCode) {
        window.loadedFromExample = false;
    }
    updateButtonStates();
});

window.previousCode = "";
function execCode() {
    const startTime = Date.now();
    document.getElementById('terminal-status').style.display = 'flex';
    document.getElementById('terminal-status').innerHTML = '<div class="status-left"><span>Running...</span></div>';

    var runbutton = document.getElementById('runbutton');
    
    if (runbutton.classList.contains('disabled') || runbutton.classList.contains('working')) {
        return;
    }
    
    if (!runbutton.innerHTML.includes("notch")) {
        var currentCode = editor.getValue();
        
        if (currentCode != previousCode) {
            previousCode = currentCode;
            
            var snippetToSend = "";
            
            if (window.loadedFromExample && currentCode === window.loadedCode) {
                snippetToSend = "SKIP_SAVE";
            }
            else if (window.loadedFromUrl && currentCode !== window.loadedCode) {
                snippetToSend = "";
                window.loadedFromUrl = false;
            } 
            else {
                snippetToSend = window.snippetId;
            }
            
            runbutton.classList.add('working');
            document.getElementById("terminal_output").innerHTML = "";
            
            var payload = {
                c: currentCode,
                i: snippetToSend,
                cols: window.terminalColumns,
                args: window.commandLineArgs,
                stream: true
            };
            
            fetch("http://188.245.97.105/%<[basePath]>%/backend/exec.php", {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(payload)
            })
            .then(response => {
                const reader = response.body.getReader();
                const decoder = new TextDecoder();
                
                function read() {
                    reader.read().then(({ done, value }) => {
                        if (done) {
                            runbutton.classList.remove('working');
                            updateButtonStates();
                            return;
                        }
                        
                        const chunk = decoder.decode(value, { stream: true });
                        const lines = chunk.split('\n');
                        
                        lines.forEach(line => {
                            if (line.startsWith('data: ')) {
                                try {
                                    const data = JSON.parse(line.substring(6));
                                    
                                    if (data.done) {
                                        const duration = ((Date.now() - startTime) / 1000).toFixed(2);
                                        const statusClass = data.result === 0 ? 'status-success' : 'status-error';
                                        const statusText = data.result === 0 ? 'Completed' : 'Error';
                                        
                                        document.getElementById('terminal-status').innerHTML = `
                                            <div class="status-left">
                                                <span class="${statusClass}">${statusText}</span>
                                                <span>Execution time: ${duration}s</span>
                                            </div>
                                        `;
                                        
                                        if (data.code && data.code !== "") {
                                            window.snippetId = data.code;
                                            window.loadedCode = currentCode;
                                            window.loadedFromExample = false;
                                            
                                            window.history.replaceState(
                                                {code: data.code}, 
                                                `${data.code} - Playground | Arturo programming language`, 
                                                `http://188.245.97.105/%<[basePath]>%/playground/${data.code}`
                                            );
                                        } else {
                                            window.loadedCode = currentCode;
                                        }
                                        
                                        runbutton.classList.remove('working');
                                        updateButtonStates();
                                        window.scroll.animateScroll(document.querySelector("#terminal"), null, {updateURL: false});
                                    } else if (data.line) {
                                        document.getElementById("terminal_output").innerHTML += data.line;
                                    }
                                } catch (e) {
                                    console.error('Parse error:', e);
                                }
                            }
                        });
                        
                        read();
                    });
                }
                
                read();
            })
            .catch(error => {
                document.getElementById("terminal_output").innerHTML = `<span class="error">Error: ${error.message}</span>`;
                runbutton.classList.remove('working');
                updateButtonStates();
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
        
        window.previousCode = "";
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
    window.terminalColumns = calculateTerminalColumns();
    
    var savedExpanded = localStorage.getItem('playground-expanded');
    if (savedExpanded === 'true' && window.innerWidth > 768) {
        toggleExpand();
    }
    
    var savedWordwrap = localStorage.getItem('playground-wordwrap');
    if (savedWordwrap === 'true') {
        editor.setOption("wrap", true);
        document.querySelector("#wordwrapperIcon").classList.add("wrapped");
        window.wordwrap = true;
    }
    
    var savedTerminalInfo = localStorage.getItem('playground-terminal-info');
    if (savedTerminalInfo === 'true') {
        var info = document.getElementById('terminal-info');
        var button = document.getElementById('terminal-info-toggle');
        info.style.display = 'block';
        button.style.background = 'rgba(255,255,255,0.15)';
        button.style.color = '#aaa';
    }
    
    var pathParts = window.location.pathname.split('/');
    var snippetId = pathParts[pathParts.length - 1];
    
    if (snippetId && snippetId !== 'playground' && snippetId !== '') {
        getSnippet(snippetId);
    } 
    else if (window.location.search != "") {
        var query = window.location.search.substring(1);
        var qs = parse_query_string(query);
        
        if (qs.example !== undefined) {
            getExample(qs.example);
            document.getElementById('scriptName').innerHTML = `${qs.example}.art`;
        }
    } else {
        updateButtonStates();
    }
    
    // Mark page as loaded after initial setup
    setTimeout(() => {
        window.pageLoaded = true;
    }, 100);
});

window.addEventListener('resize', function() {
    window.terminalColumns = calculateTerminalColumns();
});

function shareLink(){
    var shareButton = document.getElementById('sharebutton');
    
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
    if (window.innerWidth <= 768) {
        return;
    }
    
    if (window.expanded) {
        window.expanded = false;
        document.querySelector(".doccols").style.display = "flex";
        document.querySelector(".doccols").classList.remove("expanded");
        document.querySelector("#expanderIcon").classList.remove("expanded");
        document.querySelector("#runbutton").classList.remove("expanded");
        document.querySelector("#sharebutton").classList.remove("expanded");
        document.querySelector("#expander").classList.remove("expanded");
        document.querySelector("#wordwrapper").classList.remove("expanded");
        document.querySelector("#argsbutton").classList.remove("expanded");
        document.querySelector("#examplesbutton").classList.remove("expanded");
        localStorage.setItem('playground-expanded', 'false');
    } else {
        window.expanded = true;
        document.querySelector(".doccols").style.display = "inherit";
        document.querySelector(".doccols").classList.add("expanded");
        document.querySelector("#expanderIcon").classList.add("expanded");
        document.querySelector("#runbutton").classList.add("expanded");
        document.querySelector("#sharebutton").classList.add("expanded");
        document.querySelector("#expander").classList.add("expanded");
        document.querySelector("#wordwrapper").classList.add("expanded");
        document.querySelector("#argsbutton").classList.add("expanded");
        document.querySelector("#examplesbutton").classList.add("expanded");
        localStorage.setItem('playground-expanded', 'true');
    }
}

window.wordwrap = false;
function toggleWordWrap(){
    if (window.wordwrap) {
        window.wordwrap = false;
        editor.setOption("wrap", false);
        document.querySelector("#wordwrapperIcon").classList.remove("wrapped");
        showToast("Word wrap: OFF");
        localStorage.setItem('playground-wordwrap', 'false');
    } else {
        window.wordwrap = true;
        editor.setOption("wrap", true);
        document.querySelector("#wordwrapperIcon").classList.add("wrapped");
        showToast("Word wrap: ON");
        localStorage.setItem('playground-wordwrap', 'true');
    }
}

function toggleTerminalInfo() {
    var info = document.getElementById('terminal-info');
    var button = document.getElementById('terminal-info-toggle');
    
    if (info.style.display === 'none') {
        info.style.display = 'block';
        button.style.background = 'rgba(255,255,255,0.15)';
        button.style.color = '#aaa';
        localStorage.setItem('playground-terminal-info', 'true');
    } else {
        info.style.display = 'none';
        button.style.background = 'rgba(255,255,255,0.1)';
        button.style.color = '#888';
        localStorage.setItem('playground-terminal-info', 'false');
    }
}

function showToast(message) {
    // Don't show toast on page load, only on user actions
    if (!window.pageLoaded) {
        return;
    }
    
    let toast = document.getElementById('toast-notification');
    
    if (!toast) {
        toast = document.createElement('div');
        toast.id = 'toast-notification';
        toast.style.cssText = `
            position: fixed;
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
    
    // Calculate position based on expanded state
    const left = window.expanded ? '50%' : '25%';
    const top = 'calc(52px + (100vh - 52px)/2 - 30px)';
    
    toast.style.left = left;
    toast.style.top = top;
    toast.textContent = message;
    toast.style.opacity = '1';
    toast.style.transform = 'translateX(-50%) translateY(-3px)';
    
    setTimeout(() => {
        toast.style.opacity = '0';
        toast.style.transform = 'translateX(-50%)';
    }, 1500);
}

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
    
    setTimeout(() => {
        const input = document.getElementById("cmdline-args");
        if (input) input.focus();
    }, 50);
}

function showExamplesDialog() {
    ajaxPost("http://188.245.97.105/%<[basePath]>%/backend/getexamples.php",
    function (result) {
        var examples = JSON.parse(result);
        
        var examplesHtml = `
            <div class="field" style="margin-bottom: 12px;">
                <div class="control">
                    <input id="examples-search" class="input is-small" type="text" placeholder="Search examples..." style="font-size: 13px;">
                </div>
                <p class="help" style="font-size: 11px; color: #999; margin-top: 4px;">
                    <span id="examples-count">${examples.length}</span> examples available
                </p>
            </div>
            <div id="examples-list" style="max-height: 400px; overflow-y: auto; border: 1px solid #e8e8e8; border-radius: 4px;">
        `;
        
        if (examples && examples.length > 0) {
            examples.forEach(function(example) {
                var displayName = example.replace(/_/g, ' ').replace(/\b\w/g, l => l.toUpperCase());
                examplesHtml += `
                    <div class="example-item" data-name="${example.toLowerCase()}" data-display="${displayName.toLowerCase()}" 
                         style="padding: 12px 16px; border-bottom: 1px solid #f0f0f0; cursor: pointer; transition: background-color 0.12s;" 
                         onmouseover="this.style.backgroundColor='#f5f5f5'" 
                         onmouseout="this.style.backgroundColor='white'"
                         onclick="loadExampleFromDialog('${example}')">
                        <div style="font-weight: 600; color: #363636; font-size: 14px;">${displayName}</div>
                    </div>
                `;
            });
        } else {
            examplesHtml += '<div style="padding: 32px; text-align: center; color: #999;">No examples available</div>';
        }
        
        examplesHtml += '</div>';
        
        Bulma().alert({
            type: 'info',
            title: 'Load Example',
            body: examplesHtml,
            cancel: 'Close'
        });
        
        setTimeout(() => {
            var searchInput = document.getElementById('examples-search');
            if (searchInput) {
                searchInput.focus();
                searchInput.addEventListener('input', function() {
                    var query = this.value.toLowerCase();
                    var items = document.querySelectorAll('.example-item');
                    var visibleCount = 0;
                    
                    items.forEach(function(item) {
                        var name = item.getAttribute('data-name');
                        var display = item.getAttribute('data-display');
                        
                        if (name.includes(query) || display.includes(query)) {
                            item.style.display = '';
                            visibleCount++;
                        } else {
                            item.style.display = 'none';
                        }
                    });
                    
                    document.getElementById('examples-count').textContent = visibleCount;
                });
            }
        }, 50);
    }, {});
}

function loadExampleFromDialog(exampleName) {
    var modal = document.querySelector('.modal.is-active');
    if (modal) {
        modal.classList.remove('is-active');
        document.documentElement.classList.remove('is-clipped');
    }
    
    setTimeout(() => {
        getExample(exampleName);
        document.getElementById('scriptName').innerHTML = `${exampleName}.art`;
        showToast(`Loaded: ${exampleName}`);
    }, 100);
}