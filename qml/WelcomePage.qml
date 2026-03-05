import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15

Rectangle {
    id: root
    color: "#1e1e2e"
    anchors.fill: parent

    ScrollView {
        anchors.fill: parent
        clip: true
        contentWidth: availableWidth

        Column {
            width: parent.width
            spacing: 24
            topPadding: 80
            leftPadding: 40
            rightPadding: 40
            bottomPadding: 40

            Rectangle {
                width: parent.width - 80
                height: 120
                radius: 16
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: "#89b4fa" }
                    GradientStop { position: 1.0; color: "#74c7ec" }
                }

                layer.enabled: true
                layer.effect: DropShadow {
                    horizontalOffset: 0
                    verticalOffset: 4
                    radius: 16
                    samples: 25
                    color: "#40000000"
                }

                Rectangle {
                    anchors.fill: parent
                    radius: 16
                    color: "#00000000"

                    Column {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.margins: 24
                        spacing: 8

                        Text {
                            text: "400V备自投图纸仿真"
                            font.pixelSize: 22
                            color: "#1e1e2e"
                            font.family: "Segoe UI"
                            font.bold: true
                        }

                        Text {
                            text: "模拟400V备自投系统的完整工作流程，包括主备电源切换逻辑、保护动作及故障处理机制"
                            font.pixelSize: 14
                            color: "#313244"
                            font.family: "Segoe UI"
                            wrapMode: Text.WordWrap
                            lineHeight: 1.4
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onEntered: {
                            parent.parent.scale = 1.02
                            parent.parent.opacity = 0.95
                        }
                        onExited: {
                            parent.parent.scale = 1.0
                            parent.parent.opacity = 1.0
                        }
                        onClicked: {
                            root.startSimulation()
                        }
                    }

                    Behavior on scale {
                        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                    }

                    Behavior on opacity {
                        NumberAnimation { duration: 200 }
                    }
                }
            }

            Rectangle {
                width: parent.width - 80
                height: 120
                radius: 16
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: "#a6e3a1" }
                    GradientStop { position: 1.0; color: "#94e2d5" }
                }

                layer.enabled: true
                layer.effect: DropShadow {
                    horizontalOffset: 0
                    verticalOffset: 4
                    radius: 16
                    samples: 25
                    color: "#40000000"
                }

                Rectangle {
                    anchors.fill: parent
                    radius: 16
                    color: "#00000000"

                    Column {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.margins: 24
                        spacing: 8

                        Text {
                            text: "400V抽屉仿真"
                            font.pixelSize: 22
                            color: "#1e1e2e"
                            font.family: "Segoe UI"
                            font.bold: true
                        }

                        Text {
                            text: "仿真400V抽屉式开关柜的操作流程，包括抽屉推进、抽出、试验位置及运行位置的切换"
                            font.pixelSize: 14
                            color: "#313244"
                            font.family: "Segoe UI"
                            wrapMode: Text.WordWrap
                            lineHeight: 1.4
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onEntered: {
                            parent.parent.scale = 1.02
                            parent.parent.opacity = 0.95
                        }
                        onExited: {
                            parent.parent.scale = 1.0
                            parent.parent.opacity = 1.0
                        }
                        onClicked: {
                            root.startSimulation()
                        }
                    }

                    Behavior on scale {
                        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                    }

                    Behavior on opacity {
                        NumberAnimation { duration: 200 }
                    }
                }
            }

            Rectangle {
                width: parent.width - 80
                height: 120
                radius: 16
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: "#f9e2af" }
                    GradientStop { position: 1.0; color: "#fab387" }
                }

                layer.enabled: true
                layer.effect: DropShadow {
                    horizontalOffset: 0
                    verticalOffset: 4
                    radius: 16
                    samples: 25
                    color: "#40000000"
                }

                Rectangle {
                    anchors.fill: parent
                    radius: 16
                    color: "#00000000"

                    Column {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.margins: 24
                        spacing: 8

                        Text {
                            text: "400V框架断路器仿真"
                            font.pixelSize: 22
                            color: "#1e1e2e"
                            font.family: "Segoe UI"
                            font.bold: true
                        }

                        Text {
                            text: "模拟400V框架断路器的合闸、分闸操作，以及保护特性曲线和故障脱扣功能"
                            font.pixelSize: 14
                            color: "#313244"
                            font.family: "Segoe UI"
                            wrapMode: Text.WordWrap
                            lineHeight: 1.4
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onEntered: {
                            parent.parent.scale = 1.02
                            parent.parent.opacity = 0.95
                        }
                        onExited: {
                            parent.parent.scale = 1.0
                            parent.parent.opacity = 1.0
                        }
                        onClicked: {
                            root.startSimulation()
                        }
                    }

                    Behavior on scale {
                        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                    }

                    Behavior on opacity {
                        NumberAnimation { duration: 200 }
                    }
                }
            }
        }
    }

    signal startSimulation()
}
