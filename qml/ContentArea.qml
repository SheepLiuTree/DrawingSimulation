import QtQuick 2.15
import QtQuick.Layouts 1.15

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
            color: "#d1d1d1"
            radius: 12
            border.color: "#45475a"
            border.width: 1
            clip: true

            property real scaleValue: 0.05
            property real minScale: 0.05
            property real maxScale: 100.0

            Flickable {
                id: flickable
                anchors.fill: parent
                contentWidth: Math.max(svgImage.width * leftPanel.scaleValue, flickable.width)
                contentHeight: Math.max(svgImage.height * leftPanel.scaleValue, flickable.height)
                clip: true
                boundsBehavior: Flickable.StopAtBounds

                Item {
                    id: svgContainer
                    transformOrigin: Item.TopLeft
                    width: Math.max(svgImage.width * leftPanel.scaleValue, flickable.width)
                    height: Math.max(svgImage.height * leftPanel.scaleValue, flickable.height)

                Image {
                    id: svgImage
                    source: "qrc:/svg/400.svg"
                    anchors.centerIn: parent
                    sourceSize.width: 20000
                    sourceSize.height: 20000
                    scale: leftPanel.scaleValue
                    smooth: true
                    mipmap: true
                    asynchronous: true
                    cache: true
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
                        var newScale = oldScale + delta * 0.1

                        newScale = Math.max(leftPanel.minScale,
                                            Math.min(leftPanel.maxScale, newScale))

                        if (newScale === oldScale)
                            return

                        var scaleRatio = newScale / oldScale

                        // 鼠标在 Flickable 内坐标
                        var mx = wheel.x
                        var my = wheel.y

                        // ⭐ 核心修补公式（固定锚点在鼠标）
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

        Rectangle {
            id: centerPanel
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#2a2a3e"
            radius: 12
            border.color: "#45475a"
            border.width: 1
            
            Rectangle {
                anchors.centerIn: parent
                width: 200
                height: 100
                color: "#313244"
                radius: 8
                
                Text {
                    anchors.centerIn: parent
                    text: qsTr("Center Panel")
                    font.pixelSize: 16
                    color: "#cdd6f4"
                    font.family: "Segoe UI"
                }
            }
        }

        Rectangle {
            id: rightPanel
            Layout.preferredWidth: parent.width * 0.15
            Layout.fillHeight: true
            color: "#252535"
            radius: 12
            border.color: "#45475a"
            border.width: 1
            
            Rectangle {
                anchors.centerIn: parent
                width: 100
                height: 100
                color: "#313244"
                radius: 8
                
                Text {
                    anchors.centerIn: parent
                    text: qsTr("Right")
                    font.pixelSize: 16
                    color: "#cdd6f4"
                    font.family: "Segoe UI"
                }
            }
        }
    }
}
