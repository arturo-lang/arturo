// Initialize the main wrapper &
// set up callbacks
if (typeof arturo === 'undefined') {
    arturo = {}
}

// call backend method 
// with given arguments
arturo.call = function (method){
    return window.callback("call", JSON.stringify({
        "method": method,
        "args": Array.prototype.slice.call(arguments, 1)
    }))
},

// execute arbitrary arturo code 
// in backend
arturo.exec = function (code){
    return window.callback("exec", JSON.stringify(code))
}