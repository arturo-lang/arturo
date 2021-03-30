window.snippetId = "";
var editor = ace.edit("editor");
editor.setTheme("ace/theme/monokai");
editor.getSession().setMode("ace/mode/arturo");    

function execCode() {
    ajaxPost("https://arturo-lang.io/exec.php",

    function (result) {
        var got = JSON.parse(result);
        document.getElementById("terminal").innerHTML = got.text;
        window.snippetId = got.code;
        window.history.replaceState({code: got.code, text: got.text}, `${got.code} - Playground | Arturo programming language`, `https://arturo-lang.io/playground/?${got.code}`);
    }, {
        c:editor.getValue(),
        i:window.snippetId
    });
}

function getSnippet(cd) {
    ajaxPost("https://arturo-lang.io/get.php",
    
    function (result) {
        var got = JSON.parse(result);
        editor.setValue(got.text);
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