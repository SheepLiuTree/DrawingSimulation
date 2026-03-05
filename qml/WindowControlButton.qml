import QtQuick 2.15
import QtQuick.Window 2.15

Rectangle {
    id: root
    property string buttonType: "close"
    property var window
    width: 46
    height: 32
    color: "transparent"
    radius: 0

    property color hoverColor: buttonType === "close" ? "#f38ba8" : 
                              buttonType === "maximize" ? "#a6e3a1" : "#89b4fa"
    property color pressColor: buttonType === "close" ? "#eba0ac" : 
                               buttonType === "maximize" ? "#94e2d5" : "#74c7ec"
    property color iconColor: "#cdd6f4"

    Connections {
        target: window
        function onVisibilityChanged() {
            iconCanvas.requestPaint()
            buttonBackground.color = "transparent"
            root.iconColor = "#cdd6f4"
        }
    }

    Rectangle {
        id: buttonBackground
        anchors.fill: parent
        color: "transparent"
        radius: 0

        Behavior on color {
            ColorAnimation { duration: 150 }
        }
    }

    Canvas {
        id: iconCanvas
        anchors.centerIn: parent
        width: 14
        height: 14

        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)
            ctx.strokeStyle = root.iconColor
            ctx.lineWidth = 1.5
            ctx.lineCap = "round"

            if (buttonType === "minimize") {
                ctx.beginPath()
                ctx.moveTo(2, 7)
                ctx.lineTo(12, 7)
                ctx.stroke()
            } else if (buttonType === "maximize") {
                var isMax = window && window.visibility === Window.Maximized
                if (isMax) {
                    ctx.strokeRect(3, 5, 8, 6)
                    ctx.beginPath()
                    ctx.moveTo(5, 3)
                    ctx.lineTo(5, 5)
                    ctx.moveTo(5, 3)
                    ctx.lineTo(7, 3)
                    ctx.stroke()
                } else {
                    ctx.strokeRect(2, 2, 10, 10)
                }
            } else if (buttonType === "close") {
                ctx.beginPath()
                ctx.moveTo(3, 3)
                ctx.lineTo(11, 11)
                ctx.moveTo(11, 3)
                ctx.lineTo(3, 11)
                ctx.stroke()
            }
        }
    }

    MouseArea {
        id: buttonMouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onEntered: {
            buttonBackground.color = root.hoverColor
            root.iconColor = "#1e1e2e"
        }

        onExited: {
            buttonBackground.color = "transparent"
            root.iconColor = "#cdd6f4"
        }

        onPressed: {
            buttonBackground.color = root.pressColor
        }

        onReleased: {
            if (containsMouse) {
                buttonBackground.color = root.hoverColor
            } else {
                buttonBackground.color = "transparent"
            }
        }

        onClicked: {
            if (buttonType === "minimize") {
                window.showMinimized()
            } else if (buttonType === "maximize") {
                if (window.visibility === Window.Maximized) {
                    window.showNormal()
                } else {
                    window.showMaximized()
                }
            } else if (buttonType === "close") {
                window.close()
            }
        }
    }
}
