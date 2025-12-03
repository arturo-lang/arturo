window.snippetId = "";
window.loadedCode = ""; // Track what code was originally loaded
var editor = ace.edit("editor");
document.getElementsByTagName("textarea")[0].setAttribute("aria-label", "code snippet");
editor.setTheme("ace/theme/monokai");
editor.getSession().setMode("ace/mode/arturo");

// Add keyboard shortcut for code execution
editor.commands.addCommand({
    name: 'executeCode',
    bindKey: {win: 'Ctrl-Enter', mac: 'Command-Enter'},
    exec: function(editor) {
        var runbutton = document.getElementById('runbutton');
        
        // Don't execute if already processing
        if (runbutton.classList.contains('working')) {
            return;
        }
        
        // Simulate button hover effect
        runbutton.classList.add('hover-effect');
        
        // Remove effect after a short delay
        setTimeout(function() {
            runbutton.classList.remove('hover-effect');
        }, 200);
        
        execCode();
    },
    readOnly: false
});

window.previousCode = "";
function execCode() {
    var runbutton = document.getElementById('runbutton');
    if (!runbutton.innerHTML.includes("notch")) {
        var currentCode = editor.getValue();
        
        if (currentCode != previousCode) {
            previousCode = currentCode;
            
            // Only send snippet ID if code hasn't changed from what was loaded
            // Practically, this means:
            // - If user loaded abc123 and didn't change it -> reuse abc123
            // - If user loaded abc123 and did change it -> create new snippet
            // - If working on own snippet -> keep reusing it
            var snippetToSend = (currentCode === window.loadedCode) ? window.snippetId : "";
            
            runbutton.classList.add('working');
            document.getElementById("terminal_output").innerHTML = "";
            ajaxPost("http://188.245.97.105/%<[basePath]>%/backend/exec.php",

            function (result) {
                var got = JSON.parse(result);
                document.getElementById("terminal_output").innerHTML = got.text;
                window.snippetId = got.code;
                window.loadedCode = currentCode; // Update what we consider "loaded"
                window.history.replaceState({code: got.code, text: got.text}, `${got.code} - Playground | Arturo programming language`, `http://188.245.97.105/%<[basePath]>%/%playground/?${got.code}`);

                runbutton.classList.remove('working');

                window.scroll.animateScroll(document.querySelector("#terminal"));
            }, {
                c: currentCode,
                i: snippetToSend
            });
        }
    }
}

function getSnippet(cd) {
    ajaxPost("http://188.245.97.105/%<[basePath]>%/backend/get.php",
    
    function (result) {
        var got = JSON.parse(result);
        editor.setValue(got.text);
        window.loadedCode = got.text; // Remember original code
        window.snippetId = cd;
        editor.clearSelection();
        editor.resize(true);
        editor.scrollToLine(1,0,true,true,function(){});
        editor.gotoLine(1,0,true);
    }, {
        i:cd
    });
}

function getExample(cd) {
    ajaxPost("http://188.245.97.105/%<[basePath]>%/backend/example.php",
    
    function (result) {
        var got = JSON.parse(result);
        editor.setValue(got.text+"\n");
        window.loadedCode = got.text+"\n"; // Remember original code
        window.snippetId = ""; // Examples start fresh
        editor.clearSelection();
        editor.resize(true);
        editor.scrollToLine(1,0,true,true,function(){});
        editor.gotoLine(1,0,true);
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
      // If first entry with this name
      if (typeof query_string[key] === "undefined") {
        query_string[key] = decodeURIComponent(value);
        // If second entry with this name
      } else if (typeof query_string[key] === "string") {
        var arr = [query_string[key], decodeURIComponent(value)];
        query_string[key] = arr;
        // If third or later entry with this name
      } else {
        query_string[key].push(decodeURIComponent(value));
      }
    }
    return query_string;
  }
  

document.addEventListener("DOMContentLoaded", function() {
    if (window.location.search != "") {
        var query = window.location.search.substring(1);
        var qs = parse_query_string(query);

        if (qs.example !== undefined){
            getExample(qs.example);
            document.getElementById('scriptName').innerHTML = `${qs.example}.art`;
        }
        else {
            var code = window.location.search.replace("?","");
            getSnippet(code);
        }
    }
});

function shareLink(){
    if (window.snippetId!=""){
        Bulma().alert({
            type: 'info',
            title: 'Share this script',
            body:  `<input id='snippet-link' class='input is-info' value='http://188.245.97.105/%<[basePath]>%/playground?${window.snippetId}'>`,
            confirm: {
                label: 'Copy link',
                onClick: function(){
                    var copyText = document.getElementById("snippet-link");
                    copyText.select();
                    copyText.setSelectionRange(0, 99999);
                    document.execCommand("copy");
                    (window.getSelection ? window.getSelection() : document.selection).empty()
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
    if (window.expanded){
        window.expanded = false;
        document.querySelector(".doccols").style.display = "flex";
        document.querySelector("#expanderIcon").classList.remove("expanded");
        document.querySelector("#runbutton").classList.remove("expanded");
        document.querySelector("#sharebutton").classList.remove("expanded");
        document.querySelector("#expander").classList.remove("expanded");
        document.querySelector("#wordwrapper").classList.remove("expanded");
    }
    else {
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
    if (window.wordwrap){
        window.wordwrap = false;
        editor.setOption("wrap", false);
        document.querySelector("#wordwrapperIcon").classList.remove("fa-align-justify");
        document.querySelector("#wordwrapperIcon").classList.add("fa-align-left");
    }
    else {
        window.wordwrap = true;
        editor.setOption("wrap", true);
        document.querySelector("#wordwrapperIcon").classList.remove("fa-align-left");
        document.querySelector("#wordwrapperIcon").classList.add("fa-align-justify");
    }
}