// =============================================================================
// GLOBAL STATE VARIABLES
// =============================================================================

window.snippetId = "";
window.loadedCode = "";
window.previousCode = "";
window.loadedFromUrl = false;
window.loadedFromExample = false;
window.terminalColumns = 80;
window.commandLineArgs = "";
window.pageLoaded = false;
window.currentExampleName = "";
window.expanded = true; // Default to horizontal/2-column mode
window.wordwrap = false;
window.isExecuting = false;

// =============================================================================
// LOCAL STORAGE FOR SNIPPETS
// =============================================================================

function getLocalSnippets() {
    const stored = localStorage.getItem('playground-snippets');
    return stored ? JSON.parse(stored) : {};
}

function saveLocalSnippet(id, code, alias = '') {
    const snippets = getLocalSnippets();
    snippets[id] = {
        code: code,
        alias: alias,
        timestamp: Date.now()
    };
    localStorage.setItem('playground-snippets', JSON.stringify(snippets));
}

function deleteLocalSnippet(id) {
    const snippets = getLocalSnippets();
    delete snippets[id];
    localStorage.setItem('playground-snippets', JSON.stringify(snippets));
}

// =============================================================================
// ACE EDITOR INITIALIZATION
// =============================================================================

var editor = ace.edit("editor");
document.getElementsByTagName("textarea")[0].setAttribute("aria-label", "code snippet");
editor.setTheme("ace/theme/monokai");
editor.getSession().setMode("ace/mode/arturo");
editor.setShowPrintMargin(false);

// Add keyboard shortcut for execution
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

// Track editor changes
editor.getSession().on('change', function() {
    if (window.loadedFromExample && editor.getValue() !== window.loadedCode) {
        window.loadedFromExample = false;
        window.currentExampleName = "";
    }
    updateButtonStates();
});

// =============================================================================
// TERMINAL MANAGEMENT
// =============================================================================

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

function toggleTerminalInfo() {
    var info = document.getElementById('terminal-info');
    var button = document.getElementById('terminal-info-toggle');
    
    if (info.classList.contains('visible')) {
        info.classList.remove('visible');
        button.classList.remove('active');
        localStorage.setItem('playground-terminal-info', 'false');
    } else {
        info.classList.add('visible');
        button.classList.add('active');
        localStorage.setItem('playground-terminal-info', 'true');
    }
}

// =============================================================================
// CODE EXECUTION
// =============================================================================

function execCode() {
    var runbutton = document.getElementById('runbutton');
    
    if (runbutton.classList.contains('disabled') || runbutton.classList.contains('working')) {
        return;
    }
    
    if (!runbutton.innerHTML.includes("notch")) {
        var currentCode = editor.getValue();
        
        if (currentCode != previousCode) {
            previousCode = currentCode;
            
            var snippetToSend = "";
            var exampleName = "";
            
            if (window.loadedFromExample && currentCode === window.loadedCode) {
                snippetToSend = "SKIP_SAVE";
                exampleName = window.currentExampleName || "";
            }
            else {
                // Never save on execution - only when sharing
                snippetToSend = "SKIP_SAVE";
                window.loadedFromUrl = false;
                window.loadedFromExample = false;
                window.currentExampleName = "";
            }
            
            // Set editor to readonly during execution
            window.isExecuting = true;
            editor.setReadOnly(true);
            
            runbutton.classList.add('working');
            document.getElementById("terminal_output").innerHTML = "";
            
            const startTime = Date.now();
            var statusEl = document.getElementById('terminal-status');
            if (statusEl) {
                statusEl.style.display = 'flex';
                statusEl.innerHTML = '<span>Running...</span><span></span>';
            }
            
            var payload = {
                c: currentCode,
                i: snippetToSend,
                cols: window.terminalColumns,
                args: window.commandLineArgs,
                stream: true,
                example: exampleName
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
                            window.isExecuting = false;
                            editor.setReadOnly(false);
                            editor.focus();
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
                                        // Don't update snippet ID on execution
                                        // Only saveSnippet() will save and get an ID
                                        window.loadedCode = currentCode;
                                        
                                        const duration = ((Date.now() - startTime) / 1000).toFixed(2);
                                        const statusClass = data.result === 0 ? 'status-success' : 'status-error';
                                        const statusText = data.result === 0 ? 'Completed' : 'Error';
                                        
                                        if (statusEl) {
                                            statusEl.innerHTML = `
                                                <span class="${statusClass}">${statusText}</span>
                                                <span>Execution time: ${duration}s</span>
                                            `;
                                        }
                                        
                                        runbutton.classList.remove('working');
                                        window.isExecuting = false;
                                        editor.setReadOnly(false);
                                        editor.focus();
                                        updateButtonStates();
                                        window.scroll.animateScroll(document.querySelector("#terminal"), null, {updateURL: false});
                                    } else if (data.line) {
                                        var terminalOutput = document.getElementById("terminal_output");
                                        terminalOutput.innerHTML += data.line;
                                        // Auto-scroll to bottom
                                        terminalOutput.scrollTop = terminalOutput.scrollHeight;
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
                console.error('Error:', error);
                runbutton.classList.remove('working');
                window.isExecuting = false;
                editor.setReadOnly(false);
                editor.focus();
                updateButtonStates();
            });
        }
    }
}

// =============================================================================
// SNIPPET MANAGEMENT
// =============================================================================

function hasUnsavedChanges() {
    const currentCode = editor.getValue();
    return currentCode !== window.loadedCode;
}

function newSnippet() {
    // Check if button is disabled
    const newButton = document.getElementById('new-menuitem');
    if (newButton.classList.contains('disabled')) {
        return;
    }
    
    if (hasUnsavedChanges()) {
        if (!confirm('You have unsaved changes. Are you sure you want to create a new script?')) {
            return;
        }
    }
    
    editor.setValue('', -1);
    window.snippetId = "";
    window.loadedCode = "";
    window.loadedFromUrl = false;
    window.loadedFromExample = false;
    window.currentExampleName = "";
    document.getElementById("terminal_output").innerHTML = "";
    
    var statusEl = document.getElementById('terminal-status');
    if (statusEl) {
        statusEl.style.display = 'none';
    }
    
    updateButtonStates();
    showToast("New script");
}

function downloadSnippet() {
    // Check if button is disabled
    const downloadButton = document.getElementById('download-menuitem');
    if (downloadButton.classList.contains('disabled')) {
        return;
    }
    
    // Show confirmation dialog
    let filename = 'main.art';
    if (window.snippetId) {
        const snippets = getLocalSnippets();
        if (snippets[window.snippetId] && snippets[window.snippetId].alias) {
            filename = snippets[window.snippetId].alias + '.art';
        } else {
            filename = window.snippetId + '.art';
        }
    }
    
    const userFilename = prompt('Save as:', filename);
    if (!userFilename) {
        return; // User cancelled
    }
    
    // Ensure .art extension
    const finalFilename = userFilename.endsWith('.art') ? userFilename : userFilename + '.art';
    
    const code = editor.getValue();
    const blob = new Blob([code], { type: 'text/plain' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    
    a.href = url;
    a.download = finalFilename;
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
    
    showToast("Downloaded: " + finalFilename);
}

function saveSnippet() {
    // Check if button is disabled
    const saveButton = document.getElementById('save-menuitem');
    if (saveButton.classList.contains('disabled')) {
        return;
    }
    
    showToast("Saving...");
    
    var currentCode = editor.getValue();
    
    // Use existing snippet ID if we're updating
    var snippetToSend = window.snippetId || "";
    
    var payload = {
        c: currentCode,
        i: snippetToSend,
        cols: window.terminalColumns,
        args: window.commandLineArgs
    };
    
    fetch("http://188.245.97.105/%<[basePath]>%/backend/exec.php", {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
    })
    .then(response => response.json())
    .then(data => {
        if (data.code) {
            window.snippetId = data.code;
            window.loadedCode = currentCode;
            window.loadedFromUrl = true;
            window.loadedFromExample = false;
            window.currentExampleName = "";
            
            // Automatically save to local storage with empty alias (will show ID)
            saveLocalSnippet(data.code, currentCode, '');
            
            var shareLink = window.location.origin + window.location.pathname.replace(/\/[^\/]*$/, '/' + data.code);
            document.getElementById('snippet-link').value = shareLink;
            
            updateButtonStates();
            
            // Wait for toast to completely disappear before showing modal
            setTimeout(() => {
                showSaveModal();
            }, 1700);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        showToast("Save failed");
    });
}

function getSnippet(snippetId) {
    var payload = { i: snippetId };
    
    fetch("http://188.245.97.105/%<[basePath]>%/backend/get.php", {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
    })
    .then(response => response.json())
    .then(data => {
        editor.setValue(data.text, -1);
        window.snippetId = snippetId;
        window.loadedCode = data.text;
        window.loadedFromUrl = true;
        window.loadedFromExample = false;
        window.currentExampleName = "";
        updateButtonStates();
    })
    .catch(error => {
        console.error('Error:', error);
    });
}

function getExample(exampleName) {
    var payload = { c: '', i: 'SKIP_SAVE', example: exampleName };
    
    fetch("http://188.245.97.105/%<[basePath]>%/backend/exec.php", {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
    })
    .then(response => response.json())
    .then(data => {
        // For examples, we need to fetch the actual code from the examples directory
        // Since exec.php only executes, we'll load from getexamples.php structure
        fetch(`http://188.245.97.105/%<[basePath]>%/examples/${exampleName}.art`)
            .then(response => response.text())
            .then(code => {
                editor.setValue(code, -1);
                window.loadedCode = code;
                window.loadedFromExample = true;
                window.currentExampleName = exampleName;
                window.snippetId = "";
                window.loadedFromUrl = false;
                updateButtonStates();
            })
            .catch(error => {
                console.error('Error loading example:', error);
            });
    })
    .catch(error => {
        console.error('Error:', error);
    });
}

// =============================================================================
// MODAL MANAGEMENT
// =============================================================================

function showSaveModal() {
    document.getElementById('save-modal').classList.add('is-active');
    document.getElementById('snippet-link').select();
}

function closeSaveModal() {
    document.getElementById('save-modal').classList.remove('is-active');
}

function copyShareLink() {
    var linkInput = document.getElementById('snippet-link');
    linkInput.select();
    document.execCommand('copy');
    showToast("Link copied!");
}

function showArgsModal() {
    document.getElementById('cmdline-args').value = window.commandLineArgs;
    document.getElementById('args-modal').classList.add('is-active');
    document.getElementById('cmdline-args').focus();
}

function closeArgsModal() {
    document.getElementById('args-modal').classList.remove('is-active');
}

function saveArgs() {
    window.commandLineArgs = document.getElementById('cmdline-args').value;
    closeArgsModal();
    showToast("Arguments saved");
}

function showLoadModal() {
    loadExamplesList();
    document.getElementById('load-modal').classList.add('is-active');
    
    // Show examples tab by default
    showLoadTab('examples');
}

function closeLoadModal() {
    document.getElementById('load-modal').classList.remove('is-active');
}

function showLoadTab(tab) {
    const examplesTab = document.getElementById('load-examples-tab');
    const snippetsTab = document.getElementById('load-snippets-tab');
    const examplesContent = document.getElementById('examples-content');
    const snippetsContent = document.getElementById('snippets-content');
    
    if (tab === 'examples') {
        examplesTab.classList.add('is-active');
        snippetsTab.classList.remove('is-active');
        examplesContent.style.display = 'block';
        snippetsContent.style.display = 'none';
    } else {
        snippetsTab.classList.add('is-active');
        examplesTab.classList.remove('is-active');
        snippetsContent.style.display = 'block';
        examplesContent.style.display = 'none';
        loadUserSnippets();
    }
}

function loadExamplesList() {
    fetch("http://188.245.97.105/%<[basePath]>%/backend/getexamples.php")
        .then(response => response.json())
        .then(examples => {
            window.allExamples = examples;
            renderExamples(examples);
        })
        .catch(error => {
            console.error('Error loading examples:', error);
            document.getElementById('examples-list').innerHTML = '<div style="padding: 20px; text-align: center; color: #999;">Error loading examples</div>';
        });
}

function renderExamples(examples) {
    var list = document.getElementById('examples-list');
    var count = document.getElementById('examples-count');
    
    count.textContent = examples.length;
    
    if (examples.length === 0) {
        list.innerHTML = '<div style="padding: 20px; text-align: center; color: #999;">No examples found</div>';
        return;
    }
    
    var html = '<div style="padding: 8px;">';
    examples.forEach(function(example) {
        html += `
            <div class="example-item" onclick="loadExample('${example}')">
                <span class="example-name">${example}</span>
            </div>
        `;
    });
    html += '</div>';
    
    list.innerHTML = html;
}

function loadUserSnippets() {
    const snippets = getLocalSnippets();
    const list = document.getElementById('snippets-list');
    const keys = Object.keys(snippets);
    
    if (keys.length === 0) {
        list.innerHTML = '<div style="padding: 20px; text-align: center; color: #999;">No saved snippets</div>';
        return;
    }
    
    // Sort by timestamp (newest first)
    keys.sort((a, b) => snippets[b].timestamp - snippets[a].timestamp);
    
    let html = '<div style="padding: 8px;">';
    keys.forEach(id => {
        const snippet = snippets[id];
        const displayName = snippet.alias || id;
        const date = new Date(snippet.timestamp).toLocaleDateString();
        
        html += `
            <div class="snippet-item">
                <div class="snippet-item-main" onclick="loadLocalSnippet('${id}')">
                    <span class="snippet-name" id="snippet-name-${id}">${displayName}</span>
                    <span class="snippet-date">${date}</span>
                </div>
                <button class="snippet-edit" onclick="event.stopPropagation(); editSnippetAlias('${id}')" title="Edit name">✎</button>
                <button class="snippet-delete" onclick="event.stopPropagation(); deleteSnippet('${id}')" title="Delete">×</button>
            </div>
        `;
    });
    html += '</div>';
    
    list.innerHTML = html;
}

function editSnippetAlias(id) {
    const snippets = getLocalSnippets();
    const snippet = snippets[id];
    
    if (!snippet) return;
    
    const currentAlias = snippet.alias || id;
    const newAlias = prompt('Edit name:', currentAlias);
    
    if (newAlias === null) return; // User cancelled
    
    const trimmedAlias = newAlias.trim();
    
    // Update the alias (empty string if they clear it)
    saveLocalSnippet(id, snippet.code, trimmedAlias);
    
    // Refresh the list
    loadUserSnippets();
    
    if (trimmedAlias) {
        showToast('Renamed to: ' + trimmedAlias);
    } else {
        showToast('Name cleared');
    }
}

function loadExample(exampleName) {
    closeLoadModal();
    
    fetch(`http://188.245.97.105/%<[basePath]>%/examples/${exampleName}.art`)
        .then(response => response.text())
        .then(code => {
            editor.setValue(code, -1);
            window.loadedCode = code;
            window.loadedFromExample = true;
            window.currentExampleName = exampleName;
            window.snippetId = "";
            window.loadedFromUrl = false;
            updateButtonStates();
            showToast("Loaded: " + exampleName);
        })
        .catch(error => {
            console.error('Error loading example:', error);
            showToast("Failed to load example");
        });
}

function loadLocalSnippet(id) {
    const snippets = getLocalSnippets();
    const snippet = snippets[id];
    
    if (!snippet) {
        showToast("Snippet not found");
        return;
    }
    
    closeLoadModal();
    
    editor.setValue(snippet.code, -1);
    window.snippetId = id;
    window.loadedCode = snippet.code;
    window.loadedFromUrl = true;
    window.loadedFromExample = false;
    window.currentExampleName = "";
    updateButtonStates();
    
    const displayName = snippet.alias || id;
    showToast("Loaded: " + displayName);
}

function deleteSnippet(id) {
    if (!confirm('Delete this snippet?')) {
        return;
    }
    
    deleteLocalSnippet(id);
    loadUserSnippets();
    showToast("Snippet deleted");
}

function filterExamples() {
    var searchTerm = document.getElementById('examples-search').value.toLowerCase();
    
    if (!window.allExamples) return;
    
    var filtered = window.allExamples.filter(function(example) {
        return example.toLowerCase().includes(searchTerm);
    });
    
    renderExamples(filtered);
}

function loadSnippet() {
    showLoadModal();
}

// =============================================================================
// BUTTON STATE MANAGEMENT
// =============================================================================

function updateButtonStates() {
    const currentCode = editor.getValue();
    const isEmpty = currentCode.trim() === '';
    const hasChanges = currentCode !== window.loadedCode;
    
    // New button - disabled if editor is empty
    const newButton = document.getElementById('new-menuitem');
    if (isEmpty) {
        newButton.classList.add('disabled');
    } else {
        newButton.classList.remove('disabled');
    }
    
    // Run button - disabled if editor is empty or currently executing
    const runButton = document.getElementById('runbutton');
    if (isEmpty || window.isExecuting) {
        runButton.classList.add('disabled');
    } else {
        runButton.classList.remove('disabled');
    }
    
    // Save button - disabled if editor is empty
    const saveButton = document.getElementById('save-menuitem');
    if (isEmpty) {
        saveButton.classList.add('disabled');
    } else {
        saveButton.classList.remove('disabled');
    }
    
    // Download button - disabled if editor is empty
    const downloadButton = document.getElementById('download-menuitem');
    if (isEmpty) {
        downloadButton.classList.add('disabled');
    } else {
        downloadButton.classList.remove('disabled');
    }
}

// =============================================================================
// LAYOUT MANAGEMENT
// =============================================================================

function toggleExpand() {
    window.expanded = !window.expanded;
    
    var cols = document.querySelectorAll('.doccols .column');
    var expanderIcon = document.querySelector("#expanderIcon");
    var doccols = document.querySelector('.doccols');
    
    if (window.expanded) {
        // Horizontal layout - editor on left, terminal on right
        doccols.classList.add('horizontal');
        cols[0].style.flex = '0 0 50%';
        cols[1].style.flex = '0 0 50%';
        cols[1].style.display = 'block';
        expanderIcon.classList.add("expanded");
        showToast("Split horizontally");
        localStorage.setItem('playground-expanded', 'true');
    } else {
        // Vertical layout - editor on top, terminal on bottom
        doccols.classList.remove('horizontal');
        cols[0].style.flex = '0 0 50%';
        cols[1].style.flex = '0 0 50%';
        cols[1].style.display = 'block';
        expanderIcon.classList.remove("expanded");
        showToast("Split vertically");
        localStorage.setItem('playground-expanded', 'false');
    }
    
    // Recalculate terminal columns
    window.terminalColumns = calculateTerminalColumns();
    
    // Trigger editor resize
    editor.resize();
    
    // Update handle position after layout settles
    setTimeout(() => {
        const handle = document.querySelector('.resize-handle');
        if (handle && window.updateHandlePosition) {
            window.updateHandlePosition();
        }
    }, 50);
}

function toggleWordWrap() {
    window.wordwrap = !window.wordwrap;
    
    if (!window.wordwrap) {
        editor.setOption("wrap", false);
        document.querySelector("#wordwrapperIcon").classList.remove("wrapped");
        showToast("Word wrap: OFF");
        localStorage.setItem('playground-wordwrap', 'false');
    } else {
        editor.setOption("wrap", true);
        document.querySelector("#wordwrapperIcon").classList.add("wrapped");
        showToast("Word wrap: ON");
        localStorage.setItem('playground-wordwrap', 'true');
    }
}

// =============================================================================
// UI HELPERS
// =============================================================================

function showToast(message) {
    // Don't show toast on page load, only on user actions
    if (!window.pageLoaded) {
        return;
    }
    
    const toast = document.getElementById('toast-notification');
    
    if (!toast) return;
    
    toast.textContent = message;
    
    // Position toast at center-top of window
    toast.style.left = '50%';
    toast.style.top = '30%';
    
    // Trigger show
    setTimeout(() => toast.classList.add('show'), 10);
    
    // Auto-hide after 1.5 seconds
    setTimeout(() => {
        toast.classList.remove('show');
    }, 1500);
}

// =============================================================================
// UTILITY FUNCTIONS
// =============================================================================

function ajaxPost(url, callback, vars) {
    var xhr = new XMLHttpRequest();
    
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
            callback(xhr.responseText);
        }
    }
    
    xhr.open("POST", url, true);
    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    
    var params = "";
    for (var key in vars) {
        if (params != "") {
            params += "&";
        }
        params += key + "=" + encodeURIComponent(vars[key]);
    }
    
    xhr.send(params);
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

// =============================================================================
// INITIALIZATION - DOM CONTENT LOADED
// =============================================================================

window.addEventListener('DOMContentLoaded', function() {
    // Calculate terminal columns
    window.terminalColumns = calculateTerminalColumns();
    
    // Restore expanded state (default is true/horizontal)
    var savedExpanded = localStorage.getItem('playground-expanded');
    if (savedExpanded === 'false' && window.innerWidth > 768) {
        // User prefers vertical mode, toggle from default horizontal
        toggleExpand();
    }
    
    // Restore word wrap state
    var savedWordwrap = localStorage.getItem('playground-wordwrap');
    if (savedWordwrap === 'true') {
        editor.setOption("wrap", true);
        document.querySelector("#wordwrapperIcon").classList.add("wrapped");
        window.wordwrap = true;
    }
    
    // Restore terminal info state
    var savedTerminalInfo = localStorage.getItem('playground-terminal-info');
    if (savedTerminalInfo === 'true') {
        var info = document.getElementById('terminal-info');
        var button = document.getElementById('terminal-info-toggle');
        info.classList.add('visible');
        button.classList.add('active');
    }
    
    // Load snippet or example from URL
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
        }
    } else {
        updateButtonStates();
    }
    
    // Mark page as loaded after initial setup
    setTimeout(() => {
        window.pageLoaded = true;
    }, 100);
});

// =============================================================================
// INITIALIZATION - AFTER DOM READY
// =============================================================================

document.addEventListener('DOMContentLoaded', function() {
    // Setup resizable columns
    const doccols = document.querySelector('.doccols');
    const cols = doccols.querySelectorAll('.column');
    
    if (cols.length === 2) {
        const handle = document.createElement('div');
        handle.className = 'resize-handle';
        doccols.appendChild(handle);
        
        let isResizing = false;
        let minLeftWidth = 500; // Store calculated minimum - default 500px
        
        // Function to update handle position based on actual column size
        window.updateHandlePosition = function() {
            const isMobile = window.innerWidth <= 768;
            const isHorizontal = window.expanded && !isMobile;
            
            if (isHorizontal) {
                const col0Rect = cols[0].getBoundingClientRect();
                const doccolsRect = doccols.getBoundingClientRect();
                const percentage = ((col0Rect.width) / doccolsRect.width) * 100;
                handle.style.left = `${percentage}%`;
                handle.style.top = '';
            } else {
                const col0Rect = cols[0].getBoundingClientRect();
                const doccolsRect = doccols.getBoundingClientRect();
                const percentage = ((col0Rect.height) / doccolsRect.height) * 100;
                handle.style.top = `${percentage}%`;
                handle.style.left = '';
            }
        };
        
        // Media query to handle mobile layout changes
        const mobileMediaQuery = window.matchMedia('(max-width: 768px)');
        function handleMobileChange(e) {
            if (e.matches) {
                // Mobile: force vertical layout
                doccols.classList.remove('horizontal');
                cols[0].style.flex = '0 0 50%';
                cols[1].style.flex = '0 0 50%';
                setTimeout(window.updateHandlePosition, 50);
            } else {
                // Desktop: restore saved state
                const savedExpanded = localStorage.getItem('playground-expanded');
                if (savedExpanded === 'true') {
                    doccols.classList.add('horizontal');
                } else {
                    doccols.classList.remove('horizontal');
                }
                setTimeout(window.updateHandlePosition, 50);
            }
        }
        mobileMediaQuery.addListener(handleMobileChange);
        
        handle.addEventListener('mousedown', function(e) {
            isResizing = true;
            handle.classList.add('resizing');
            
            // Use fixed 500px minimum for horizontal dragging
            minLeftWidth = 500;
            
            const isMobile = window.innerWidth <= 768;
            const isHorizontal = window.expanded && !isMobile;
            document.body.style.cursor = isHorizontal ? 'col-resize' : 'row-resize';
            e.preventDefault();
        });
        
        document.addEventListener('mousemove', function(e) {
            if (!isResizing) return;
            
            const containerRect = doccols.getBoundingClientRect();
            const isMobile = window.innerWidth <= 768;
            const isHorizontal = window.expanded && !isMobile;
            
            if (isHorizontal) {
                // Horizontal layout - resize left/right
                const offsetX = e.clientX - containerRect.left;
                
                const minRightWidth = 200;
                const maxLeftWidth = containerRect.width - minRightWidth;
                
                // Clamp the offset to respect minimum widths
                const clampedOffsetX = Math.max(minLeftWidth, Math.min(maxLeftWidth, offsetX));
                const percentage = (clampedOffsetX / containerRect.width) * 100;
                
                cols[0].style.flex = `0 0 ${percentage}%`;
                cols[1].style.flex = `0 0 ${100 - percentage}%`;
                
                // Update handle position directly without requestAnimationFrame
                const col0Width = cols[0].getBoundingClientRect().width;
                const handlePercentage = (col0Width / containerRect.width) * 100;
                handle.style.left = `${handlePercentage}%`;
                
                window.terminalColumns = calculateTerminalColumns();
                editor.resize();
            } else {
                // Vertical layout - resize top/bottom
                const offsetY = e.clientY - containerRect.top;
                
                // Calculate minimum heights
                const minTopHeight = 200;
                const minBottomHeight = 150;
                const maxTopHeight = containerRect.height - minBottomHeight;
                
                // Clamp the offset to respect minimum heights
                const clampedOffsetY = Math.max(minTopHeight, Math.min(maxTopHeight, offsetY));
                const percentage = (clampedOffsetY / containerRect.height) * 100;
                
                cols[0].style.flex = `0 0 ${percentage}%`;
                cols[1].style.flex = `0 0 ${100 - percentage}%`;
                
                // Update handle position directly without requestAnimationFrame
                const col0Height = cols[0].getBoundingClientRect().height;
                const handlePercentage = (col0Height / containerRect.height) * 100;
                handle.style.top = `${handlePercentage}%`;
                
                window.terminalColumns = calculateTerminalColumns();
                editor.resize();
            }
        });
        
        document.addEventListener('mouseup', function() {
            if (isResizing) {
                isResizing = false;
                handle.classList.remove('resizing');
                document.body.style.cursor = '';
                // Final position update only
                window.updateHandlePosition();
            }
        });
        
        // Initial handle position
        setTimeout(window.updateHandlePosition, 100);
        
        // Update on window resize
        window.addEventListener('resize', window.updateHandlePosition);
    }
    
    // Setup event listener for args dialog Enter key
    var argsInput = document.getElementById('cmdline-args');
    if (argsInput) {
        argsInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                saveArgs();
            }
        });
    }
    
    // Setup event listener for examples search
    var examplesSearch = document.getElementById('examples-search');
    if (examplesSearch) {
        examplesSearch.addEventListener('input', filterExamples);
    }
    
    // Initial button state update
    updateButtonStates();
});

// =============================================================================
// WINDOW RESIZE HANDLER
// =============================================================================

window.addEventListener('resize', function() {
    window.terminalColumns = calculateTerminalColumns();
    editor.resize();
});