import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root
    property var window
    property bool showBackButton: false

    signal backClicked()

    color: "#181825"
    gradient: Gradient {
        orientation: Gradient.Horizontal
        GradientStop { position: 0.0; color: "#181825" }
        GradientStop { position: 1.0; color: "#1e1e2e" }
    }

    Rectangle {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 1
        color: "#313244"
    }

    MouseArea {
        id: dragArea
        anchors.fill: parent
        property point clickPos: "0,0"
        z: 0
        
        onPressed: function(mouse) {
            clickPos = Qt.point(mouse.x, mouse.y)
        }
        
        onPositionChanged: function(mouse) {
            if (pressed && root.window.visibility !== Window.Maximized) {
                var delta = Qt.point(mouse.x - clickPos.x, mouse.y - clickPos.y)
                root.window.x += delta.x
                root.window.y += delta.y
            }
        }
        
        onDoubleClicked: {
            if (root.window.visibility === Window.Maximized) {
                root.window.showNormal()
            } else {
                root.window.showMaximized()
            }
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 12
        anchors.rightMargin: 8
        spacing: 12
        z: 10

        Rectangle {
            id: appIcon
            width: 32
            height: 32
            radius: 8
            color: "#89b4fa"
            Layout.alignment: Qt.AlignVCenter

            Text {
                anchors.centerIn: parent
                text: "DS"
                font.pixelSize: 14
                font.bold: true
                color: "#1e1e2e"
                font.family: "Segoe UI"
            }
        }

        Text {
            id: windowTitle
            text: window ? window.title : ""
            font.pixelSize: 13
            color: "#cdd6f4"
            font.family: "Segoe UI"
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
            elide: Text.ElideRight
        }

        Rectangle {
            id: backButton
            width: 32
            height: 32
            radius: 8
            color: "#313244"
            Layout.alignment: Qt.AlignVCenter
            visible: root.showBackButton
            z: 20

            Text {
                anchors.centerIn: parent
                text: "←"
                font.pixelSize: 18
                color: "#cdd6f4"
                font.family: "Segoe UI"
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.color = "#45475a"
                }
                onExited: {
                    parent.color = "#313244"
                }
                onClicked: {
                    root.backClicked()
                }
            }
        }

        WindowControlButton {
            id: minimizeButton
            Layout.alignment: Qt.AlignVCenter
            buttonType: "minimize"
            window: root.window
            z: 20
        }

        WindowControlButton {
            id: maximizeButton
            Layout.alignment: Qt.AlignVCenter
            buttonType: "maximize"
            window: root.window
            z: 20
        }

        WindowControlButton {
            id: closeButton
            Layout.alignment: Qt.AlignVCenter
            buttonType: "close"
            window: root.window
            z: 20
        }
    }
}
