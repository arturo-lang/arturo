window.snippetId = "";
var editor = ace.edit("editor");
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