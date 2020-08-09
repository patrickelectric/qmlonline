class QmlOnline {
    constructor(div) {
        this.div = document.getElementById(div)
        this.canvas = undefined
        this.img = undefined
        this.status = undefined
        this.figure = undefined
        this.config = undefined
        this.qtLoader = undefined

        var self = this
        this.defaultConfig = {
            qmlMessage: function (msg) {
                console.log(`qml: ${msg}`)
                self.config && self.config.qmlMessage && self.config.qmlMessage(msg)
            },
            qmlError: function (error) {
                console.log(`qml error: ${JSON.stringify(error)}`)
                console.log(`${self.config}`)
                self.config && self.config.qmlError && self.config.qmlError(error)
            },
            posInit: function () {
                self.config && self.config.posInit && self.config.posInit()
            },
        };
    }

    init() {
        /*
            <figure style="overflow:visible;" id="qtspinner">
                <center style="margin-top:1.5em;">
                    <img id="webasm_load_image" ;
                        style="max-height: 400px; object-fit: contain; display: block; margin-left: auto; margin-right: auto;">
                    </img>
                    <strong>Qt for WebAssembly: qmlonline</strong>
                    <div id="qtstatus"></div>
                    <noscript>JavaScript is disabled. Please enable JavaScript to use this application.</noscript>
                </center>
            </figure>
        */
        this.figure = document.createElement("figure")
        this.figure.style = "overflow:visible;"
        this.figure.id = "qt-spinner"

        const center = document.createElement("center")
        center.style = "margin-top:1.5em;"

        this.img = document.createElement("img")
        this.img.id = "webasm-load-image"
        this.img.style = "max-height: 400px; object-fit: contain; display: block; margin-left: auto; margin-right: auto;"
        center.appendChild(this.img)

        const strong = document.createElement("strong")
        strong.body = "Qt for WebAssembly: qmlonline"
        center.appendChild(strong)

        this.status = document.createElement("div")
        this.status.id = "qt-status"
        center.appendChild(this.status)

        const noScript = document.createElement("noscript")
        noScript.body = "JavaScript is disabled. Please enable JavaScript to use this application."
        center.appendChild(noScript)

        this.figure.appendChild(center)
        this.div.appendChild(this.figure)

        /*
            <canvas id="qtcanvas" oncontextmenu="event.preventDefault()"
                contenteditable="true" style="height: 100%; width: 100%;"></canvas>
        */
        this.canvas = document.createElement("canvas")
        this.canvas.id = "qt-canvas"
        this.canvas.setAttribute("oncontextmenu", "event.preventDefault()")
        this.canvas.setAttribute("contenteditable", "true")
        this.canvas.style = "height: 100%; width: 100%;"
        this.div.appendChild(this.canvas)

        this.loadKonqi()
        this.loadWebASM()
    }

    registerCall(userConfig) {
        this.config = userConfig
    }

    loadKonqi() {
        const images = [
            "https://community.kde.org/images.community/thumb/4/40/Mascot_konqi.png/360px-Mascot_konqi.png",
            "https://community.kde.org/images.community/thumb/c/ce/Mascot_konqi-dev-kde.png/424px-Mascot_konqi-dev-kde.png",
            "https://community.kde.org/images.community/thumb/f/fb/Mascot_konqi-app-dev-katie.png/424px-Mascot_konqi-app-dev-katie.png",
            "https://community.kde.org/images.community/thumb/1/11/Mascot_konqi-dev-qt.png/424px-Mascot_konqi-dev-qt.png",
            "https://community.kde.org/images.community/thumb/5/50/Mascot_konqi-base-framework.png/526px-Mascot_konqi-base-framework.png",
            "https://community.kde.org/images.community/thumb/a/af/Mascot_konqi-base-plasma.png/520px-Mascot_konqi-base-plasma.png",
            "https://community.kde.org/images.community/thumb/7/79/Mascot_konqi-app-dev.png/651px-Mascot_konqi-app-dev.png",
            "https://community.kde.org/images.community/thumb/f/f4/Mascot_konqi-support-document.png/571px-Mascot_konqi-support-document.png",
            "https://community.kde.org/images.community/thumb/9/99/Mascot_konqi-app-hardware.png/424px-Mascot_konqi-app-hardware.png",
        ];
        this.img.src = images[Math.floor(Math.random() * images.length)];
    }

    loadWebASM() {
        const self = this
        var qtLoader
        qtLoader = QtLoader({
            path: "https://qmlonline.kde.org/",
            canvasElements: [self.canvas],
            showLoader: function (loaderStatus) {
                self.figure.style.display = 'block';
                self.canvas.style.display = 'none';
                self.status.innerHTML = loaderStatus + "...";
            },
            showError: function (errorText) {
                self.status.innerHTML = errorText;
                self.figure.style.display = 'block';
                self.canvas.style.display = 'none';
            },
            showExit: function () {
                self.status.innerHTML = "Application exit";
                if (qtLoader.exitCode !== undefined)
                    self.status.innerHTML += " with code " + qtLoader.exitCode;
                if (qtLoader.exitText !== undefined)
                    self.status.innerHTML += " (" + qtLoader.exitText + ")";
                self.figure.style.display = 'block';
                self.canvas.style.display = 'none';
                console.log("exit", qtLoader.exitCode)
            },
            showCanvas: function () {
                self.figure.style.display = 'none';
                self.canvas.style.display = 'block';
                Module.instantiateWasm = function (imports, successCallback) {
                    console.log('instantiateWasm: instantiating asynchronously');
                };
            },
        });
        qtLoader.loadEmscriptenModule("qmlonline");
        this.qtLoader = qtLoader

        // TODO: Find a better way to set the initial code and wait for the webassembly to start
        var intervalID = setInterval(
            function () {
                console.log("Waiting for webassembly to load...")

                if (Module && !Module.printErr) {
                    Module.printErr = function (text) {
                        // qml message
                        let match = /qml:\ (.*)/.exec(text)
                        if (match) {
                            self.defaultConfig.qmlMessage(match[1])
                        }

                        //const match = /qrc:\/userItem:(?<line_number>\d+): (?<error_message>.*)/.exec(lines[i])
                        match = /qrc:\/userItem:(\d+): (.*)/.exec(text)

                        if (match) {
                            let line_number = match[1]
                            let error_message = match[2]

                            self.defaultConfig.qmlError({
                                row: line_number - 1,
                                column: 0,
                                text: error_message,
                                type: "error"
                            });
                        }

                        //const match = /qrc:\/userItem:(?<line_number>\d+):(?<column_number>\d+): (?<error_message>.*)/
                        match = /qrc:\/userItem:(\d+):(\d+): (.*)/.exec(text)

                        if (match) {
                            let line_number = match[1]
                            let column_number = match[2]
                            let error_message = match[3]

                            self.defaultConfig.qmlError({
                                row: line_number - 1,
                                column: column_number,
                                text: error_message,
                                type: "error"
                            });
                        }
                    }
                }

                if (Module.self !== undefined) {
                    clearInterval(intervalID);
                    Module.self().setCode(
                        "import QtQuick 2.7; \
import QtQuick.Controls 2.3; \
Rectangle { \
color: 'red'; \
anchors.fill: parent; \
Text { \
    text: 'WEEEEEEEEEE'; \
    font.pixelSize: 50; \
    color: 'white'; \
    anchors.centerIn: parent; \
    RotationAnimator on rotation { \
        running: true; \
        loops: Animation.Infinite; \
        from: 0; \
        to: 360; \
        duration: 1500; \
    } \
} \
}")
                }
                self.defaultConfig.posInit()
            },
        100);
    }

    setCode(code) {
        Module && Module.self && Module.self().setCode(code)
    }

    buildInfo() {
        if (Module && Module.Version) {
            return new Module.Version()
        }
        return undefined
    }

    resizeCanvas() {
        this.qtLoader && this.qtLoader.resizeCanvasElement(this.canvas);
    }
}