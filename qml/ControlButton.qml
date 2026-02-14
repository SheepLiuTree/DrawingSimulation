import QtQuick 2.15

Rectangle {
    id: root
    property string text: ""
    property bool isActive: false
    property color activeColor: "#a6e3a1"
    property color inactiveColor: "#f38ba8"
    property color textColor: "#1e1e2e"

    signal clicked()

    width: 100
    height: 35
    color: isActive ? activeColor : inactiveColor
    radius: 6

    Text {
        anchors.centerIn: parent
        text: root.text
        font.pixelSize: 13
        color: root.textColor
        font.family: "Segoe UI"
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onPressed: {
            root.color = Qt.darker(root.color, 1.1)
        }

        onReleased: {
            root.color = root.isActive ? root.activeColor : root.inactiveColor
        }

        onClicked: {
            root.clicked()
        }
    }
}
