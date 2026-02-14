import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import "../drawings"

Rectangle {
    id: root
    color: "#252535"

    RowLayout {
        anchors.fill: parent
        spacing: 10

        Rectangle {
            id: leftPanel
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#ffffff"
            radius: 12
            border.color: "#45475a"
            border.width: 1
            clip: true

            property real scaleValue: 1
            property real minScale: 0.75
            property real maxScale: 20.0
            antialiasing: true

            Flickable {
                id: flickable
                anchors.fill: parent
                contentWidth: Math.max(mainDrawing.width * leftPanel.scaleValue, flickable.width)
                contentHeight: Math.max(mainDrawing.height * leftPanel.scaleValue, flickable.height)
                clip: true
                boundsBehavior: Flickable.StopAtBounds
                antialiasing: true

                Item {
                    id: svgContainer
                    transformOrigin: Item.TopLeft
                    width: Math.max(mainDrawing.width * leftPanel.scaleValue, flickable.width)
                    height: Math.max(mainDrawing.height * leftPanel.scaleValue, flickable.height)
                    antialiasing: true

                    Drawing_1 {
                        id: mainDrawing
                        anchors.centerIn: parent
                        scale: leftPanel.scaleValue
                        antialiasing: true
                    }
                }

            }

            MouseArea {
                    id: wheelArea
                    anchors.fill: parent
                    acceptedButtons: Qt.NoButton

                    onWheel: function(wheel) {
                        var oldScale = leftPanel.scaleValue
                        var delta = wheel.angleDelta.y / 120
                        var newScale = oldScale + delta * 0.5

                        newScale = Math.max(leftPanel.minScale,
                                            Math.min(leftPanel.maxScale, newScale))

                        if (newScale === oldScale)
                            return

                        var scaleRatio = newScale / oldScale

                        var mx = wheel.x
                        var my = wheel.y

                        flickable.contentX =
                                (flickable.contentX + mx) * scaleRatio - mx
                        flickable.contentY =
                                (flickable.contentY + my) * scaleRatio - my

                        leftPanel.scaleValue = newScale

                        flickable.returnToBounds()
                    }
                }


            Rectangle {
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.margins: 10
                width: 120
                height: 30
                color: "#313244"
                radius: 6

                Row {
                    anchors.centerIn: parent
                    spacing: 8

                    Text {
                        text: "缩放: " + (leftPanel.scaleValue * 100).toFixed(0) + "%"
                        font.pixelSize: 12
                        color: "#cdd6f4"
                        font.family: "Segoe UI"
                    }
                }
            }

            Rectangle {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.margins: 10
                width: 80
                height: 30
                color: "#313244"
                radius: 6

                Row {
                    anchors.centerIn: parent
                    spacing: 8

                    Rectangle {
                        width: 24
                        height: 24
                        color: "#313244"
                        radius: 4
                        Text {
                            anchors.centerIn: parent
                            text: "-"
                            font.pixelSize: 14
                            color: "#cdd6f4"
                            font.family: "Segoe UI"
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                leftPanel.scaleValue = Math.max(leftPanel.minScale, leftPanel.scaleValue - 0.1)
                            }
                        }
                    }

                    Rectangle {
                        width: 24
                        height: 24
                        color: "#313244"
                        radius: 4
                        Text {
                            anchors.centerIn: parent
                            text: "+"
                            font.pixelSize: 14
                            color: "#cdd6f4"
                            font.family: "Segoe UI"
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                leftPanel.scaleValue = Math.min(leftPanel.maxScale, leftPanel.scaleValue + 0.1)
                            }
                        }
                    }
                }
            }
        }
    }

    Window {
        id: controlWindow
        width: 600
        height: 680
        x: root.Window.window ? root.Window.window.x + root.Window.window.width - width - 20 : 100
        y: root.Window.window ? root.Window.window.y + 20 : 100
        color: "transparent"
        visible: root.visible
        flags: Qt.Window | Qt.FramelessWindowHint
        modality: Qt.NonModal

        property bool isMinimized: false
        property real originalHeight: 680
        property real minimizedHeight: 35

        Rectangle {
            anchors.fill: parent
            color: "#313244"
            radius: 8
            border.color: "#45475a"
            border.width: 1

            MouseArea {
                id: dragArea
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: 30
                cursorShape: Qt.OpenHandCursor

                property real pressX: 0
                property real pressY: 0

                onPressed: function(mouse) {
                    cursorShape = Qt.ClosedHandCursor
                    pressX = mouse.x
                    pressY = mouse.y
                }

                onReleased: {
                    cursorShape = Qt.OpenHandCursor
                }

                onPositionChanged: function(mouse) {
                    if (pressed) {
                        controlWindow.x = controlWindow.x + mouse.x - pressX
                        controlWindow.y = controlWindow.y + mouse.y - pressY
                    }
                }

                Row {
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 5

                    Text {
                        text: "控制面板"
                        font.pixelSize: 13
                        color: "#cdd6f4"
                        font.family: "Segoe UI"
                    }
                }

                Row {
                    anchors.right: parent.right
                    anchors.rightMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 5

                    Rectangle {
                        width: 20
                        height: 20
                        color: "#45475a"
                        radius: 3

                        Text {
                            anchors.centerIn: parent
                            text: controlWindow.isMinimized ? "+" : "-"
                            font.pixelSize: 12
                            color: "#cdd6f4"
                            font.family: "Segoe UI"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                controlWindow.isMinimized = !controlWindow.isMinimized
                                controlWindow.height = controlWindow.isMinimized ? controlWindow.minimizedHeight : controlWindow.originalHeight
                            }
                        }
                    }
                }
            }

            Item {
                anchors.top: dragArea.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 10
                visible: !controlWindow.isMinimized

                Column {
                    anchors.centerIn: parent
                    spacing: 10

                    ControlButton {
                        text: mainDrawing.sw_LVI1_DC220 ? "DC220: 开" : "DC220: 关"
                        isActive: mainDrawing.sw_LVI1_DC220
                        onClicked: {
                            mainDrawing.sw_LVI1_DC220 = !mainDrawing.sw_LVI1_DC220
                        }
                    }

                    ControlButton {
                        text: mainDrawing.sw_LVI1_ZK02 ? "ZK02: 开" : "ZK02: 关"
                        isActive: mainDrawing.sw_LVI1_ZK02
                        onClicked: {
                            mainDrawing.sw_LVI1_ZK02 = !mainDrawing.sw_LVI1_ZK02
                        }
                    }

                    ControlButton {
                        text: mainDrawing.sw_LVI1_ZK03 ? "ZK03: 开" : "ZK03: 关"
                        isActive: mainDrawing.sw_LVI1_ZK03
                        onClicked: {
                            mainDrawing.sw_LVI1_ZK03 = !mainDrawing.sw_LVI1_ZK03
                        }
                    }

                    ControlButton {
                        text: mainDrawing.sw_LVI1_ZK04 ? "ZK04: 开" : "ZK04: 关"
                        isActive: mainDrawing.sw_LVI1_ZK04
                        onClicked: {
                            mainDrawing.sw_LVI1_ZK04 = !mainDrawing.sw_LVI1_ZK04
                        }
                    }

                    ControlButton {
                        text: mainDrawing.sw_LVI1_ZK2 ? "ZK2: 开" : "ZK2: 关"
                        isActive: mainDrawing.sw_LVI1_ZK2
                        onClicked: {
                            mainDrawing.sw_LVI1_ZK2 = !mainDrawing.sw_LVI1_ZK2
                        }
                    }

                    ControlButton {
                        text: mainDrawing.sw_LVI1_ZK15 ? "ZK15: 开" : "ZK15: 关"
                        isActive: mainDrawing.sw_LVI1_ZK15
                        onClicked: {
                            mainDrawing.sw_LVI1_ZK15 = !mainDrawing.sw_LVI1_ZK15
                        }
                    }

                    ControlButton {
                        text: mainDrawing.sw_LVI1_ZK1 ? "ZK1: 开" : "ZK1: 关"
                        isActive: mainDrawing.sw_LVI1_ZK1
                        onClicked: {
                            mainDrawing.sw_LVI1_ZK1 = !mainDrawing.sw_LVI1_ZK1
                        }
                    }

                    ControlButton {
                        text: mainDrawing.sw_LVI1_ABC ? "ABC: 开" : "ABC: 关"
                        isActive: mainDrawing.sw_LVI1_ABC
                        onClicked: {
                            mainDrawing.sw_LVI1_ABC = !mainDrawing.sw_LVI1_ABC
                        }
                    }

                    ControlButton {
                        text: mainDrawing.sw_LVC_isRemote ? "远方" : "就地"
                        isActive: mainDrawing.sw_LVC_isRemote
                        onClicked: {
                            mainDrawing.sw_LVC_isRemote = !mainDrawing.sw_LVC_isRemote
                        }
                    }

                    Row {
                        spacing: 10

                        JogButton {
                            text: "SB1"
                            onPressed: {
                                mainDrawing.sw_LVI1_SB1 = true
                            }
                            onReleased: {
                                mainDrawing.sw_LVI1_SB1 = false
                            }
                        }

                        JogButton {
                            text: "SB2"
                            onPressed: {
                                mainDrawing.sw_LVI1_SB2 = true
                            }
                            onReleased: {
                                mainDrawing.sw_LVI1_SB2 = false
                            }
                        }
                    }
                }
            }
        }
    }
}
