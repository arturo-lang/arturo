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
window.expanded = true;
window.wordwrap = false;
window.isExecuting = false;
window.isReadOnly = false;
window.cooldownActive = false;
window.creatorIpMatches = false;
window.hasUnsavedChanges = false;

// =============================================================================
// SESSION OWNERSHIP MANAGEMENT
// =============================================================================

function getMySnippets() {
    const stored = localStorage.getItem('my-snippets');
    return stored ? JSON.parse(stored) : {};
}

function addMySnippet(id, alias = '') {
    const snippets = getMySnippets();
    snippets[id] = {
        alias: alias,
        created: Date.now()
    };
    localStorage.setItem('my-snippets', JSON.stringify(snippets));
}

function updateSnippetAlias(id, alias) {
    const snippets = getMySnippets();
    if (snippets[id]) {
        snippets[id].alias = alias;
        localStorage.setItem('my-snippets', JSON.stringify(snippets));
    }
}

function ownsSnippet(id) {
    const snippets = getMySnippets();
    return snippets.hasOwnProperty(id);
}

function removeMySnippet(id) {
    const snippets = getMySnippets();
    delete snippets[id];
    localStorage.setItem('my-snippets', JSON.stringify(snippets));
}

// =============================================================================
// LOCAL STORAGE FOR SNIPPETS (deprecated - keeping for migration)
// =============================================================================

function getLocalSnippets() {
    const stored = localStorage.getItem('playground-snippets');
    return stored ? JSON.parse(stored) : {};
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
        window.currentExampleName = "";
    }
    
    // Track if there are unsaved changes
    window.hasUnsavedChanges = (editor.getValue().trim() !== window.loadedCode.trim());
    
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
    
    if (runbutton.classList.contains('disabled') || runbutton.classList.contains('working') || window.cooldownActive) {
        return;
    }
    
    var currentCode = editor.getValue();
    
    var exampleName = "";
    if (window.loadedFromExample && currentCode === window.loadedCode) {
        exampleName = window.currentExampleName || "";
    }
    
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
                    
                    startCooldown();
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
                                const elapsed = ((Date.now() - startTime) / 1000).toFixed(2);
                                if (statusEl) {
                                    let statusMsg = '';
                                    let statusColor = '';
                                    
                                    // Get terminal output to analyze errors
                                    const terminalOutput = document.getElementById("terminal_output").textContent || '';
                                    
                                    if (data.result === 0) {
                                        // Successful execution
                                        statusMsg = 'Success';
                                        statusColor = '#50fa7b';
                                    } else if (data.result === 124 || data.result === 137 || terminalOutput.includes('timed out') || terminalOutput.includes('timeout') || elapsed > 10 ) {
                                        // Timeout: 124 = timeout, 137 = killed (timeout --kill-after), or timeout in output
                                        statusMsg = 'Timeout';
                                        statusColor = '#ffb86c';
                                    } else if (terminalOutput.includes('<script>') || terminalOutput.includes('Error')) {
                                        // Arturo runtime error
                                        statusMsg = 'Runtime Error';
                                        statusColor = '#ff5555';
                                    } else {
                                        // Generic error
                                        statusMsg = 'Error';
                                        statusColor = '#ff5555';
                                    }
                                    
                                    const icon = data.result === 0 ? '✓' : 
                                                (data.result === 124 || data.result === 137) ? '⏱' : '✗';
                                    
                                    statusEl.innerHTML = `<span style="color: ${statusColor};">${icon} ${statusMsg}</span><span>${elapsed}s</span>`;
                                }
                                
                                if (data.error) {
                                    showToast(data.error, 'error');
                                }
                            } else if (data.line) {
                                // Filter out jail execution errors - don't show to user
                                const lineText = data.line.replace(/<[^>]*>/g, ''); // Strip HTML to check text
                                if (!lineText.startsWith('jail: /bin/sh')) {
                                    document.getElementById("terminal_output").innerHTML += data.line;
                                    var terminal = document.getElementById("terminal");
                                    terminal.scrollTop = terminal.scrollHeight;
                                }
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
        runbutton.classList.remove('working');
        window.isExecuting = false;
        editor.setReadOnly(false);
        console.error('Execution error:', error);
        showToast('Execution failed: ' + error.message, 'error');
        
        startCooldown();
        updateButtonStates();
    });
}

function startCooldown() {
    window.cooldownActive = true;
    updateButtonStates();
    
    setTimeout(() => {
        window.cooldownActive = false;
        updateButtonStates();
    }, 5000);
}

// =============================================================================
// SNIPPET MANAGEMENT
// =============================================================================

function newSnippet() {
    if (window.isExecuting) return;
    
    // Warn if there are unsaved changes
    if (window.hasUnsavedChanges && editor.getValue().trim() !== "") {
        if (!confirm("Start a new snippet? Current code will be lost if not saved.")) {
            return;
        }
    }
    
    editor.setValue("");
    window.snippetId = "";
    window.loadedCode = "";
    window.previousCode = "";
    window.loadedFromUrl = false;
    window.loadedFromExample = false;
    window.currentExampleName = "";
    window.isReadOnly = false;
    window.creatorIpMatches = false;
    window.hasUnsavedChanges = false;
    
    document.getElementById("terminal_output").innerHTML = "";
    var statusEl = document.getElementById('terminal-status');
    if (statusEl) statusEl.style.display = 'none';
    
    updateButtonStates();
    editor.focus();
    
    window.history.pushState({}, '', window.location.pathname.split('/').slice(0, -1).join('/') + '/');
}

function saveSnippet() {
    if (window.isExecuting) return;
    
    const currentCode = editor.getValue();
    if (!currentCode.trim()) {
        showToast('Nothing to save', 'error');
        return;
    }
    
    const canUpdate = window.snippetId && ownsSnippet(window.snippetId) && window.creatorIpMatches;
    const idToSend = canUpdate ? window.snippetId : '';
    
    fetch("http://188.245.97.105/%<[basePath]>%/backend/save.php", {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            c: currentCode,
            i: idToSend
        })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            const wasUpdate = (window.snippetId === data.id && !data.forked);
            
            window.snippetId = data.id;
            window.creatorIpMatches = true;
            window.loadedCode = editor.getValue(); // Update loaded code
            window.hasUnsavedChanges = false; // Clear unsaved flag
            addMySnippet(data.id);
            window.loadedFromUrl = false;
            window.isReadOnly = false;
            
            // Force button state update after a small delay to ensure everything is set
            setTimeout(() => {
                updateButtonStates();
            }, 50);
            
            window.history.pushState({}, '', window.location.pathname.split('/').slice(0, -1).join('/') + '/' + data.id);
            
            if (wasUpdate) {
                // Just re-saved existing snippet - show toast only
                showToast('Snippet updated');
            } else {
                // New snippet or fork - show toast, then modal after delay
                if (data.forked) {
                    showToast('Forked as new snippet');
                } else {
                    showToast('Snippet saved');
                }
                
                // Show modal after toast disappears
                setTimeout(() => {
                    const fullUrl = window.location.origin + window.location.pathname.split('/').slice(0, -1).join('/') + '/' + data.id;
                    document.getElementById('snippet-link').value = fullUrl;
                    document.getElementById('save-modal').classList.add('is-active');
                }, 3200);
            }
        } else {
            showToast('Failed to save: ' + (data.error || 'Unknown error'), 'error');
        }
    })
    .catch(error => {
        console.error('Save error:', error);
        showToast('Save failed: ' + error.message, 'error');
    });
}

function downloadSnippet() {
    if (window.isExecuting) return;
    
    const currentCode = editor.getValue();
    if (!currentCode.trim()) {
        showToast('Nothing to download', 'error');
        return;
    }
    
    const blob = new Blob([currentCode], { type: 'text/plain' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'script.art';
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
    
    showToast('Script downloaded');
}

function getSnippet(id) {
    fetch("http://188.245.97.105/%<[basePath]>%/backend/get.php", {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ i: id })
    })
    .then(response => response.json())
    .then(data => {
        if (data.text && !data.text.startsWith("# Snippet not found")) {
            editor.setValue(data.text, -1);
            window.snippetId = id;
            window.loadedCode = data.text;
            window.previousCode = "";
            window.loadedFromUrl = true;
            window.loadedFromExample = false;
            window.currentExampleName = "";
            window.hasUnsavedChanges = false;
            
            const hasLocalOwnership = ownsSnippet(id);
            
            if (!hasLocalOwnership) {
                window.isReadOnly = true;
                window.creatorIpMatches = false;
                
                fetch("http://188.245.97.105/%<[basePath]>%/backend/visit.php", {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ i: id })
                }).catch(err => console.error('Visit tracking failed:', err));
            } else {
                fetch("http://188.245.97.105/%<[basePath]>%/backend/visit.php", {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ i: id })
                })
                .then(response => response.json())
                .then(visitData => {
                    if (visitData.success && visitData.ip_match) {
                        window.isReadOnly = false;
                        window.creatorIpMatches = true;
                    } else {
                        window.isReadOnly = true;
                        window.creatorIpMatches = false;
                    }
                    updateButtonStates();
                })
                .catch(err => {
                    console.error('Visit tracking failed:', err);
                    window.isReadOnly = true;
                    window.creatorIpMatches = false;
                    updateButtonStates();
                });
            }
            
            updateButtonStates();
            editor.focus();
        } else {
            // Snippet not found - redirect to clean playground
            showToast('Snippet not found', 'error');
            window.history.pushState({}, '', window.location.pathname.split('/').slice(0, -1).join('/') + '/');
        }
    })
    .catch(error => {
        console.error('Load error:', error);
        showToast('Failed to load snippet', 'error');
    });
}

// =============================================================================
// BUTTON STATE MANAGEMENT
// =============================================================================

function updateButtonStates() {
    const hasContent = editor.getValue().trim() !== "";
    const isExecuting = window.isExecuting;
    
    const runButton = document.getElementById('runbutton');
    const saveMenuItem = document.getElementById('save-menuitem');
    const downloadMenuItem = document.getElementById('download-menuitem');
    
    // Run button: disabled during execution OR cooldown
    if (isExecuting || window.cooldownActive) {
        runButton.classList.add('disabled');
    } else {
        if (hasContent) {
            runButton.classList.remove('disabled');
        } else {
            runButton.classList.add('disabled');
        }
    }
    
    // Save/Download: only disabled during execution, NOT during cooldown
    if (isExecuting) {
        if (saveMenuItem) saveMenuItem.classList.add('disabled');
        if (downloadMenuItem) downloadMenuItem.classList.add('disabled');
    } else {
        // Save button logic: disabled if no content OR no unsaved changes
        const canSave = hasContent && window.hasUnsavedChanges;
        
        if (saveMenuItem) {
            if (canSave) {
                saveMenuItem.classList.remove('disabled');
            } else {
                saveMenuItem.classList.add('disabled');
            }
        }
        
        // Download is always enabled if there's content
        if (downloadMenuItem) {
            if (hasContent) {
                downloadMenuItem.classList.remove('disabled');
            } else {
                downloadMenuItem.classList.add('disabled');
            }
        }
    }
    
    if (saveMenuItem) {
        const saveLink = saveMenuItem.querySelector('a');
        const saveLabel = saveMenuItem.querySelector('.item-label');
        if (saveLink && saveLabel) {
            if (window.isReadOnly && hasContent) {
                saveLabel.textContent = 'Fork';
                saveLink.title = 'Fork and save as new snippet';
            } else if (window.snippetId && ownsSnippet(window.snippetId) && window.creatorIpMatches && hasContent) {
                saveLabel.textContent = 'Update';
                saveLink.title = 'Update this snippet';
            } else {
                saveLabel.textContent = 'Save';
                saveLink.title = 'Save and share';
            }
        }
    }
}

// =============================================================================
// MODAL MANAGEMENT
// =============================================================================

function closeSaveModal() {
    document.getElementById('save-modal').classList.remove('is-active');
}

function copyShareLink() {
    var linkInput = document.getElementById('snippet-link');
    linkInput.select();
    linkInput.setSelectionRange(0, 99999);
    
    if (navigator.clipboard && navigator.clipboard.writeText) {
        navigator.clipboard.writeText(linkInput.value).then(function() {
            closeSaveModal();
            setTimeout(() => {
                showToast('Link copied to clipboard!');
            }, 100);
        }).catch(function() {
            // Fallback to execCommand
            document.execCommand('copy');
            closeSaveModal();
            setTimeout(() => {
                showToast('Link copied to clipboard!');
            }, 100);
        });
    } else {
        // Fallback for older browsers
        document.execCommand('copy');
        closeSaveModal();
        setTimeout(() => {
            showToast('Link copied to clipboard!');
        }, 100);
    }
}

function showArgsModal() {
    document.getElementById('cmdline-args').value = window.commandLineArgs;
    document.getElementById('args-modal').classList.add('is-active');
    setTimeout(() => document.getElementById('cmdline-args').focus(), 100);
}

function closeArgsModal() {
    document.getElementById('args-modal').classList.remove('is-active');
}

function saveArgs() {
    window.commandLineArgs = document.getElementById('cmdline-args').value;
    closeArgsModal();
    editor.focus();
}

// =============================================================================
// LOAD MODAL
// =============================================================================

function loadSnippet() {
    if (window.isExecuting) return;
    
    document.getElementById('load-modal').classList.add('is-active');
    showLoadTab('examples');
    loadExamplesList();
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
        examplesTab.classList.remove('is-active');
        snippetsTab.classList.add('is-active');
        examplesContent.style.display = 'none';
        snippetsContent.style.display = 'block';
        loadMySnippets();
    }
}

function loadExamplesList() {
    fetch("http://188.245.97.105/%<[basePath]>%/backend/getexamples.php")
    .then(response => response.json())
    .then(data => {
        window.examplesList = data;
        displayExamples(data);
    })
    .catch(error => console.error('Error loading examples:', error));
}

function displayExamples(examples) {
    const list = document.getElementById('examples-list');
    const count = document.getElementById('examples-count');
    
    if (count) count.textContent = examples.length;
    
    if (examples.length === 0) {
        list.innerHTML = '<div style="padding: 20px; text-align: center; color: #999;">No examples found</div>';
        return;
    }
    
    list.innerHTML = examples.map(ex => `
        <div class="example-item" onclick="selectExample('${ex.replace(/'/g, "\\'")}')">
            <span class="example-name">${ex}</span>
        </div>
    `).join('');
}

function filterExamples() {
    const search = document.getElementById('examples-search').value.toLowerCase();
    if (!window.examplesList) return;
    
    const filtered = window.examplesList.filter(ex => ex.toLowerCase().includes(search));
    displayExamples(filtered);
}

function selectExample(name) {
    getExample(name);
    closeLoadModal();
}

function getExample(name) {
    fetch("http://188.245.97.105/%<[basePath]>%/backend/example.php", {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ i: name })
    })
    .then(response => response.json())
    .then(data => {
        if (data.text && !data.text.startsWith("# Example not found")) {
            editor.setValue(data.text, -1);
            window.loadedCode = data.text;
            window.previousCode = "";
            window.loadedFromExample = true;
            window.currentExampleName = name;
            window.loadedFromUrl = false;
            window.snippetId = "";
            window.isReadOnly = false;
            window.creatorIpMatches = false;
            
            document.getElementById("terminal_output").innerHTML = "";
            var statusEl = document.getElementById('terminal-status');
            if (statusEl) statusEl.style.display = 'none';
            
            updateButtonStates();
            editor.focus();
        }
    })
    .catch(error => console.error('Error loading example:', error));
}

function loadMySnippets() {
    const list = document.getElementById('snippets-list');
    const mySnippets = getMySnippets();
    const ids = Object.keys(mySnippets).sort((a, b) => mySnippets[b].created - mySnippets[a].created);
    
    if (ids.length === 0) {
        list.innerHTML = '<div style="padding: 20px; text-align: center; color: #999;">No saved snippets yet</div>';
        return;
    }
    
    list.innerHTML = ids.map(id => {
        const snippet = mySnippets[id];
        const alias = snippet.alias || id;
        const date = new Date(snippet.created).toLocaleDateString();
        
        return `
            <div class="snippet-item">
                <div class="snippet-info" onclick="if (!event.target.classList.contains('snippet-alias-input')) selectMySnippet('${id}')">
                    <span class="snippet-alias" id="alias-${id}" ondblclick="event.stopPropagation(); startEditAlias('${id}')">${escapeHtml(alias)}</span>
                    <span class="snippet-meta">${id} • ${date}</span>
                </div>
                <div class="snippet-actions">
                    <button class="snippet-edit" onclick="event.stopPropagation(); startEditAlias('${id}')" title="Edit alias">✎</button>
                    <button class="snippet-delete" onclick="event.stopPropagation(); deleteMySnippet('${id}')" title="Delete">✕</button>
                </div>
            </div>
        `;
    }).join('');
}

function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

function startEditAlias(id) {
    const snippets = getMySnippets();
    const currentAlias = snippets[id]?.alias || id;
    const aliasSpan = document.getElementById('alias-' + id);
    
    if (!aliasSpan || aliasSpan.querySelector('input')) return;
    
    const input = document.createElement('input');
    input.type = 'text';
    input.value = currentAlias;
    input.className = 'snippet-alias-input';
    input.style.cssText = 'width: 100%; font-size: 14px; padding: 2px 4px; border: 1px solid #667eea; border-radius: 3px; outline: none;';
    
    const saveEdit = () => {
        const newAlias = input.value.trim();
        if (newAlias && newAlias !== currentAlias) {
            updateSnippetAlias(id, newAlias);
        }
        loadMySnippets();
    };
    
    input.addEventListener('blur', saveEdit);
    input.addEventListener('keydown', (e) => {
        if (e.key === 'Enter') {
            saveEdit();
        } else if (e.key === 'Escape') {
            loadMySnippets();
        }
    });
    
    aliasSpan.textContent = '';
    aliasSpan.appendChild(input);
    input.focus();
    input.select();
}

function selectMySnippet(id) {
    getSnippet(id);
    closeLoadModal();
}

function deleteMySnippet(id) {
    if (confirm('Delete this snippet from your list?')) {
        removeMySnippet(id);
        deleteLocalSnippet(id);
        loadMySnippets();
    }
}

// =============================================================================
// TOAST NOTIFICATIONS
// =============================================================================

function showToast(message, type = 'info') {
    const toast = document.getElementById('toast-notification');
    toast.textContent = message;
    toast.className = 'toast-' + type + ' show';
    
    setTimeout(() => {
        toast.classList.remove('show');
    }, 3000);
}

// =============================================================================
// LAYOUT MANAGEMENT
// =============================================================================

function toggleExpand() {
    if (window.isExecuting) return;
    
    const doccols = document.querySelector('.doccols');
    const expanderIcon = document.getElementById('expanderIcon');
    const isMobile = window.innerWidth <= 768;
    
    if (isMobile) return;
    
    window.expanded = !window.expanded;
    
    if (window.expanded) {
        doccols.classList.add('horizontal');
        expanderIcon.classList.remove('compressed');
        expanderIcon.classList.add('expanded');

        showToast("Layout: column mode");
    } else {
        doccols.classList.remove('horizontal');
        expanderIcon.classList.add('compressed');
        expanderIcon.classList.remove('expanded');
        
        showToast("Layout: stack mode");
    }
    
    localStorage.setItem('playground-expanded', window.expanded);
    
    setTimeout(() => {
        window.terminalColumns = calculateTerminalColumns();
        editor.resize();
        if (window.updateHandlePosition) {
            window.updateHandlePosition();
        }
    }, 50);
}

function toggleWordWrap() {
    if (window.isExecuting) return;
    
    window.wordwrap = !window.wordwrap;
    editor.getSession().setUseWrapMode(window.wordwrap);
    
    const icon = document.querySelector("#wordwrapperIcon");
    if (window.wordwrap) {
        icon.classList.add("wrapped");
        localStorage.setItem('playground-wordwrap', 'true');

        showToast("Wordwrap: on");
    } else {
        icon.classList.remove("wrapped");
        localStorage.setItem('playground-wordwrap', 'false');

        showToast("Wordwrap: off");
    }
}

// =============================================================================
// UTILITY FUNCTIONS
// =============================================================================

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
// INITIALIZATION - ON LOAD
// =============================================================================

window.addEventListener('load', function() {
    window.terminalColumns = calculateTerminalColumns();
    
    // Warn before leaving page if there are unsaved changes
    window.addEventListener('beforeunload', function(e) {
        if (window.hasUnsavedChanges && editor.getValue().trim() !== '') {
            e.preventDefault();
            e.returnValue = ''; // Modern browsers ignore custom message
            return '';
        }
    });
    
    const savedExpanded = localStorage.getItem('playground-expanded');
    if (savedExpanded === 'false') {
        window.expanded = false;
        document.querySelector('.doccols').classList.remove('horizontal');
        document.querySelector("#expanderIcon").classList.add('compressed');
        document.querySelector("#expanderIcon").classList.remove('expanded');
    } else {
        window.expanded = true;
        document.querySelector('.doccols').classList.add('horizontal');
        document.querySelector("#expanderIcon").classList.remove('compressed');
        document.querySelector("#expanderIcon").classList.add('expanded');
    }
    
    const savedWordwrap = localStorage.getItem('playground-wordwrap');
    if (savedWordwrap === 'true') {
        editor.getSession().setUseWrapMode(true);
        document.querySelector("#wordwrapperIcon").classList.add("wrapped");
        window.wordwrap = true;
    }
    
    const savedTerminalInfo = localStorage.getItem('playground-terminal-info');
    if (savedTerminalInfo === 'true') {
        const info = document.getElementById('terminal-info');
        const button = document.getElementById('terminal-info-toggle');
        info.classList.add('visible');
        button.classList.add('active');
    }
    
    const pathParts = window.location.pathname.split('/');
    const snippetId = pathParts[pathParts.length - 1];
    
    if (snippetId && snippetId !== 'playground' && snippetId !== '') {
        getSnippet(snippetId);
    } 
    else if (window.location.search != "") {
        const query = window.location.search.substring(1);
        const qs = parse_query_string(query);
        
        if (qs.example !== undefined) {
            getExample(qs.example);
        }
    } else {
        updateButtonStates();
    }
    
    setTimeout(() => {
        window.pageLoaded = true;
    }, 100);
});

// =============================================================================
// INITIALIZATION - AFTER DOM READY
// =============================================================================

document.addEventListener('DOMContentLoaded', function() {
    const doccols = document.querySelector('.doccols');
    const cols = doccols.querySelectorAll('.column');
    
    if (cols.length === 2) {
        const handle = document.createElement('div');
        handle.className = 'resize-handle';
        doccols.appendChild(handle);
        
        let isResizing = false;
        let minLeftWidth = 500;
        
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
        
        const mobileMediaQuery = window.matchMedia('(max-width: 768px)');
        function handleMobileChange(e) {
            if (e.matches) {
                doccols.classList.remove('horizontal');
                cols[0].style.flex = '0 0 50%';
                cols[1].style.flex = '0 0 50%';
                setTimeout(window.updateHandlePosition, 50);
            } else {
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
                const offsetX = e.clientX - containerRect.left;
                const minRightWidth = 200;
                const maxLeftWidth = containerRect.width - minRightWidth;
                const clampedOffsetX = Math.max(minLeftWidth, Math.min(maxLeftWidth, offsetX));
                const percentage = (clampedOffsetX / containerRect.width) * 100;
                
                cols[0].style.flex = `0 0 ${percentage}%`;
                cols[1].style.flex = `0 0 ${100 - percentage}%`;
                
                const col0Width = cols[0].getBoundingClientRect().width;
                const handlePercentage = (col0Width / containerRect.width) * 100;
                handle.style.left = `${handlePercentage}%`;
                
                window.terminalColumns = calculateTerminalColumns();
                editor.resize();
            } else {
                const offsetY = e.clientY - containerRect.top;
                const minTopHeight = 200;
                const minBottomHeight = 150;
                const maxTopHeight = containerRect.height - minBottomHeight;
                const clampedOffsetY = Math.max(minTopHeight, Math.min(maxTopHeight, offsetY));
                const percentage = (clampedOffsetY / containerRect.height) * 100;
                
                cols[0].style.flex = `0 0 ${percentage}%`;
                cols[1].style.flex = `0 0 ${100 - percentage}%`;
                
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
                window.updateHandlePosition();
            }
        });
        
        setTimeout(window.updateHandlePosition, 100);
        window.addEventListener('resize', window.updateHandlePosition);
    }
    
    const argsInput = document.getElementById('cmdline-args');
    if (argsInput) {
        argsInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                saveArgs();
            }
        });
    }
    
    const examplesSearch = document.getElementById('examples-search');
    if (examplesSearch) {
        examplesSearch.addEventListener('input', filterExamples);
    }
    
    updateButtonStates();
});

// =============================================================================
// WINDOW RESIZE HANDLER
// =============================================================================

window.addEventListener('resize', function() {
    window.terminalColumns = calculateTerminalColumns();
    editor.resize();
});