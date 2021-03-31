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
        editor.gotoLine(1);
    }, {
        i:cd
    });
}

document.addEventListener("DOMContentLoaded", function() {
    if (window.location.search != "") {
        var code = window.location.search.replace("?","");
        getSnippet(code);
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