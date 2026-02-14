import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root
    color: "#1e1e2e"
    anchors.fill: parent

    Flow {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 20
        anchors.topMargin: 70
        spacing: 20
        width: parent.width - 40

        Rectangle {
            width: 280
            height: 60
            color: "#89b4fa"
            radius: 8

            Text {
                anchors.centerIn: parent
                text: "400V备自投图纸仿真"
                font.pixelSize: 18
                color: "#1e1e2e"
                font.family: "Segoe UI"
                font.bold: true
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.color = "#b4befe"
                }
                onExited: {
                    parent.color = "#89b4fa"
                }
                onClicked: {
                    root.startSimulation()
                }
            }
        }

        Rectangle {
            width: 280
            height: 60
            color: "#89b4fa"
            radius: 8

            Text {
                anchors.centerIn: parent
                text: "400V抽屉仿真"
                font.pixelSize: 18
                color: "#1e1e2e"
                font.family: "Segoe UI"
                font.bold: true
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.color = "#b4befe"
                }
                onExited: {
                    parent.color = "#89b4fa"
                }
                onClicked: {
                    root.startSimulation()
                }
            }
        }

        Rectangle {
            width: 280
            height: 60
            color: "#89b4fa"
            radius: 8

            Text {
                anchors.centerIn: parent
                text: "400V框架断路器仿真"
                font.pixelSize: 18
                color: "#1e1e2e"
                font.family: "Segoe UI"
                font.bold: true
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.color = "#b4befe"
                }
                onExited: {
                    parent.color = "#89b4fa"
                }
                onClicked: {
                    root.startSimulation()
                }
            }
        }
    }

    signal startSimulation()
}
