// Initialize the main wrapper & set up callbacks
if (typeof arturo === 'undefined') {
    arturo = {
        // call backend method with given arguments
        call: (method, ...args) => {
            return window.callback("call", JSON.stringify({
                "method": method,
                "args": args
            }))
        },

        // execute arbitrary arturo code in backend
        exec: (code) => {
            return window.callback("exec", JSON.stringify(code))
        },

        // window state management
        // this could be part of Águila!!
        window: {
            // Minimized state
            get minimized() {
                return JSON.parse(arturo.exec("window\\minimized?"))
            },
            set minimized(value) {
                arturo.exec(`window\\minimized?: ${value}`)
            },

            // Minimizable state
            get minimizable() {
                return JSON.parse(arturo.exec("window\\minimizable?"))
            },
            set minimizable(value) {
                arturo.exec(`window\\minimizable?: ${value}`)
            },

            // Maximized state
            get maximized() {
                return JSON.parse(arturo.exec("window\\maximized?"))
            },
            set maximized(value) {
                arturo.exec(`window\\maximized?: ${value}`)
            },

            // Maximizable state
            get maximizable() {
                return JSON.parse(arturo.exec("window\\maximizable?"))
            },
            set maximizable(value) {
                arturo.exec(`window\\maximizable?: ${value}`)
            },

            // Closable state
            get closable() {
                return JSON.parse(arturo.exec("window\\closable?"))
            },
            set closable(value) {
                arturo.exec(`window\\closable?: ${value}`)
            },

            // Focused state
            get focused() {
                return JSON.parse(arturo.exec("window\\focused?"))
            },
            set focused(value) {
                arturo.exec(`window\\focused?: ${value}`)
            },

            // Visible state
            get visible() {
                return JSON.parse(arturo.exec("window\\visible?"))
            },
            set visible(value) {
                arturo.exec(`window\\visible?: ${value}`)
            },

            // Fullscreen state
            get fullscreen() {
                return JSON.parse(arturo.exec("window\\fullscreen?"))
            },
            set fullscreen(value) {
                arturo.exec(`window\\fullscreen?: ${value}`)
            }
        }
    }
}