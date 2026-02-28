import QtQuick 2.15

Rectangle {
    id: root
    property bool isOn: false
    property color onColor: "#a6e3a1"
    property color offColor: "#45475a"
    property color glowColor: "#a6e3a1"
    property real glowIntensity: 0.3

    width: 30
    height: 30
    color: isOn ? onColor : offColor
    radius: width / 2

    Behavior on color {
        ColorAnimation { duration: 200 }
    }

    Rectangle {
        anchors.fill: parent
        radius: parent.radius
        color: "transparent"
        border.color: root.isOn ? Qt.rgba(root.glowColor.r, root.glowColor.g, root.glowColor.b, root.glowIntensity) : "transparent"
        border.width: 4
        visible: root.isOn
    }

    Rectangle {
        anchors.centerIn: parent
        width: parent.width * 0.6
        height: parent.height * 0.6
        radius: width / 2
        color: root.isOn ? Qt.lighter(root.onColor, 0.3) : Qt.darker(root.offColor, 0.2)
        visible: root.isOn
    }
}