window.snippetId = "";
var editor = ace.edit("editor");
document.getElementsByTagName("textarea")[0].setAttribute("aria-label", "code snippet");
editor.setTheme("ace/theme/monokai");
editor.getSession().setMode("ace/mode/arturo"); 

window.previousCode = "";
function execCode() {
    var runbutton = document.getElementById('runbutton');
    if (!runbutton.innerHTML.includes("notch")) {
        if (editor.getValue()!=previousCode) {
            previousCode = editor.getValue();
            runbutton.innerHTML = `<i class='fas fa-circle-notch fa-spin'></i>`;
            runbutton.classList.add('working');
            document.getElementById("terminal_output").innerHTML = "";
            ajaxPost("https://arturo-lang.io/exec.php",

            function (result) {
                var got = JSON.parse(result);
                document.getElementById("terminal_output").innerHTML = got.text;
                window.snippetId = got.code;
                window.history.replaceState({code: got.code, text: got.text}, `${got.code} - Playground | Arturo programming language`, `https://arturo-lang.io/playground/?${got.code}`);

                runbutton.innerHTML = `<i class='far fa-play-circle'></i>`;
                runbutton.classList.remove('working');

                window.scroll.animateScroll(document.querySelector("#terminal"));
            }, {
                c:editor.getValue(),
                i:window.snippetId
            });
        }
    }
}

function getSnippet(cd) {
    ajaxPost("https://arturo-lang.io/get.php",
    
    function (result) {
        var got = JSON.parse(result);
        editor.setValue(got.text);
        editor.clearSelection();
        editor.resize(true);
        editor.scrollToLine(1,0,true,true,function(){});
        editor.gotoLine(1,0,true);
    }, {
        i:cd
    });
}

function getExample(cd) {
    ajaxPost("https://arturo-lang.io/example.php",
    
    function (result) {
        var got = JSON.parse(result);
        editor.setValue(got.text+"\n");
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
            body:  `<input id='snippet-link' class='input is-info' value='http://arturo-lang.io/playground?${window.snippetId}'>`,
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
        document.querySelector("#expanderIcon").classList.remove("fa-compress-alt");
        document.querySelector("#expanderIcon").classList.add("fa-expand-alt");
        document.querySelector("#runbutton").classList.remove("expanded");
        document.querySelector("#sharebutton").classList.remove("expanded");
        document.querySelector("#expander").classList.remove("expanded");
        document.querySelector("#wordwrapper").classList.remove("expanded");
    }
    else {
        window.expanded = true;
        document.querySelector(".doccols").style.display = "inherit";
        document.querySelector("#expanderIcon").classList.remove("fa-expand-alt");
        document.querySelector("#expanderIcon").classList.add("fa-compress-alt");
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