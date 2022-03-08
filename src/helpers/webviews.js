// Initialize the main wrapper &
// set up callbacks
if (typeof arturo === 'undefined') {
    arturo = {
        // call backend method 
        // with given arguments
        call: (method, ...args)=>{
            return window.callback("call", JSON.stringify({
                "method": method,
                "args": args
            }))
        },

        // execute arbitrary arturo code 
        // in backend
        exec: (code)=>{
            return window.callback("exec", JSON.stringify(code))
        },

        // invoke a specific backend action
        invoke: (action)=>{
            return window.callback("action", JSON.stringify(action))
        }
    }
}

// setup events
window.onload = ()=>{
    return window.callback("event", JSON.stringify("load"))
}
window.onerror = ()=>{
    return window.callback("event", JSON.stringify("error"))
}