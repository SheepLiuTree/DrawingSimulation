import QtQuick 2.15

Rectangle {
    id: root
    property string text: ""
    property bool isPressed: false
    property color activeColor: "#a6e3a1"
    property color inactiveColor: "#45475a"
    property color textColor: "#cdd6f4"

    signal pressed()
    signal released()

    width: 100
    implicitHeight: 35

    color: isPressed ? activeColor : inactiveColor
    radius: 6

    Behavior on color {
        ColorAnimation { duration: 100 }
    }

    Text {
        anchors.centerIn: parent
        text: root.text
        font.pixelSize: 13
        color: root.isPressed ? "#1e1e2e" : root.textColor
        font.family: "Segoe UI"
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onPressed: {
            root.isPressed = true
            root.pressed()
        }

        onReleased: {
            root.isPressed = false
            root.released()
        }

        onCanceled: {
            root.isPressed = false
            root.released()
        }
    }
}
