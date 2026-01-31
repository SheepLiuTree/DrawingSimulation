import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "qml"

Window {
    id: rootWindow
    width: 1200
    height: 800
    minimumWidth: 800
    minimumHeight: 600
    visible: true
    title: qsTr("Drawing Simulation")
    color: "#1e1e2e"
    flags: Qt.FramelessWindowHint | Qt.Window

    property int borderWidth: 8
    property int titleBarHeight: 48
    property int cornerSize: 16

    Rectangle {
        id: mainContainer
        anchors.fill: parent
        color: "#1e1e2e"

        CustomTitleBar {
            id: titleBar
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: rootWindow.titleBarHeight
            window: rootWindow
        }

        ContentArea {
            id: contentArea
            anchors.top: titleBar.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
        }

        ResizeHandle {
            id: leftHandle
            anchors.left: parent.left
            anchors.top: titleBar.bottom
            anchors.bottom: parent.bottom
            width: rootWindow.borderWidth
            window: rootWindow
            resizeEdge: "left"
        }

        ResizeHandle {
            id: rightHandle
            anchors.right: parent.right
            anchors.top: titleBar.bottom
            anchors.bottom: parent.bottom
            width: rootWindow.borderWidth
            window: rootWindow
            resizeEdge: "right"
        }

        ResizeHandle {
            id: topHandle
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: rootWindow.borderWidth
            window: rootWindow
            resizeEdge: "top"
        }

        ResizeHandle {
            id: bottomHandle
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: rootWindow.borderWidth
            window: rootWindow
            resizeEdge: "bottom"
        }

        ResizeHandle {
            id: topLeftHandle
            anchors.top: parent.top
            anchors.left: parent.left
            width: rootWindow.cornerSize
            height: rootWindow.cornerSize
            window: rootWindow
            resizeEdge: "topLeft"
        }

        ResizeHandle {
            id: topRightHandle
            anchors.top: parent.top
            anchors.right: parent.right
            width: rootWindow.cornerSize
            height: rootWindow.cornerSize
            window: rootWindow
            resizeEdge: "topRight"
        }

        ResizeHandle {
            id: bottomLeftHandle
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            width: rootWindow.cornerSize
            height: rootWindow.cornerSize
            window: rootWindow
            resizeEdge: "bottomLeft"
        }

        ResizeHandle {
            id: bottomRightHandle
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            width: rootWindow.cornerSize
            height: rootWindow.cornerSize
            window: rootWindow
            resizeEdge: "bottomRight"
        }
    }
}
