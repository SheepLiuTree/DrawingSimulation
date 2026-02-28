import QtQuick 2.15

Rectangle {
    id: root
    property int type: 2
    property int state: 1
    property var labels: []

    signal toggleStateChanged(int newState)

    width: 35
    height: type === 2 ? 80 : 120
    color: "#45475a"
    radius: 17.5

    Column {
        anchors.fill: parent
        anchors.margins: 3
        spacing: 3

        Repeater {
            model: root.type

            Rectangle {
                width: root.width - 6
                height: (root.height - (root.type - 1) * 3 - 6) / root.type
                radius: (root.width - 6) / 2
                color: index + 1 === root.state ? "#a6e3a1" : "#313244"

                Text {
                    anchors.centerIn: parent
                    text: root.labels.length > index ? root.labels[index] : (index + 1).toString()
                    font.pixelSize: 14
                    color: index + 1 === root.state ? "#1e1e2e" : "#cdd6f4"
                    font.family: "Segoe UI"
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        if (root.type === 2) {
                            root.state = root.state === 1 ? 2 : 1
                        } else {
                            if (root.state === 1) {
                                root.state = 2
                            } else if (root.state === 2) {
                                if (index === 0) {
                                    root.state = 1
                                } else {
                                    root.state = 3
                                }
                            } else if (root.state === 3) {
                                root.state = 2
                            }
                        }
                        root.toggleStateChanged(root.state)
                    }
                }
            }
        }
    }
}
