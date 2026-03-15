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
            property real minScale: 1.25
            property real maxScale: 20.0
            antialiasing: true

            Flickable {
                id: flickable
                anchors.fill: parent
                contentWidth: Math.max(mainDrawing.width, flickable.width)
                contentHeight: Math.max(mainDrawing.height, flickable.height)
                clip: true
                boundsBehavior: Flickable.StopAtBounds
                antialiasing: true

                Item {
                    id: svgContainer
                    transformOrigin: Item.TopLeft
                    width: Math.max(mainDrawing.width, flickable.width)
                    height: Math.max(mainDrawing.height, flickable.height)
                    antialiasing: true

                    Drawing_1 {
                        id: mainDrawing
                        anchors.centerIn: parent
                        width: implicitWidth * leftPanel.scaleValue
                        height: implicitHeight * leftPanel.scaleValue
                        viewScale: leftPanel.scaleValue
                        antialiasing: true

                        sw_1QF: true
                        sw_2QF: true
                        sw_3QF: false

                        sw_LVI1_ABC: true
                        sw_LVI1_DC220: true
                        sw_LVI1_ZK02: true
                        sw_LVI1_ZK03: true
                        sw_LVI1_ZK04: true
                        sw_LVI1_ZK15: true
                        sw_LVI1_ZK1: true
                        sw_LVI1_ZK2: true
                        sw_1QF_StoredEnergy: 3

                        sw_LVI2_ABC: true
                        sw_LVI2_DC220: true
                        sw_LVI2_ZK02: true
                        sw_LVI2_ZK03: true
                        sw_LVI2_ZK04: true
                        sw_LVI2_ZK15: true
                        sw_LVI2_ZK1: true
                        sw_LVI2_ZK2: true
                        sw_2QF_StoredEnergy: 3

                        sw_3QF_StoredEnergy: 3

                        sw_LVC_ZK1: true
                        sw_PLC_ZK10: true

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
        width: 1000
        height: 900
        x: root.Window.window ? root.Window.window.x + root.Window.window.width - width - 20 : 100
        y: root.Window.window ? root.Window.window.y + 20 : 100
        color: "transparent"
        visible: root.visible
        flags: Qt.Window | Qt.FramelessWindowHint
        modality: Qt.NonModal

        property bool isMinimized: false
        property real originalHeight: 900
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
                        width: 60
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

                RowLayout {
                    anchors.fill: parent
                    spacing: 10

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: "#646679"
                        radius: 6

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 10
                            spacing: 10

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                text: "LVI1"
                                font.pixelSize: 14
                                color: "#cdd6f4"
                                font.family: "Segoe UI"
                            }

                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 150
                                color: "transparent"
                                border.color: "#45475a"
                                border.width: 1
                                radius: 4

                                Text {
                                    anchors.top: parent.top
                                    anchors.left: parent.left
                                    anchors.margins: 5
                                    text: "柜后"
                                    font.pixelSize: 12
                                    color: "#cdd6f4"
                                    font.family: "Segoe UI"
                                }

                                RowLayout {
                                    anchors.top: parent.top
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    anchors.bottom: parent.bottom
                                    anchors.topMargin: 25
                                    anchors.leftMargin: 10
                                    anchors.rightMargin: 10
                                    anchors.bottomMargin: 10
                                    spacing: 10

                                    Repeater {
                                        model: 3

                                        ColumnLayout {
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            Layout.preferredWidth: 0
                                            spacing: 5

                                            Text {
                                                Layout.alignment: Qt.AlignHCenter
                                                text: index === 0 ? "ZK02" : index === 1 ? "ZK03" : "ZK04"
                                                font.pixelSize: 14
                                                color: "#cdd6f4"
                                                font.family: "Segoe UI"
                                            }

                                            Image {
                                                Layout.fillWidth: true
                                                Layout.fillHeight: true
                                                source: "qrc:/img/kk_2p.png"
                                                fillMode: Image.PreserveAspectFit
                                                sourceSize: Qt.size(width, height)
                                            }

                                            ToggleSwitch {
                                                Layout.alignment: Qt.AlignHCenter
                                                Layout.preferredWidth: 30
                                                Layout.preferredHeight: 50
                                                type: 2
                                                state: index === 0 ? (mainDrawing.sw_LVI1_ZK02 ? 2 : 1) : index === 1 ? (mainDrawing.sw_LVI1_ZK03 ? 2 : 1) : (mainDrawing.sw_LVI1_ZK04 ? 2 : 1)
                                                labels: ["分", "合"]
                                                onToggleStateChanged: function(newState) {
                                                    if (index === 0) {
                                                        mainDrawing.sw_LVI1_ZK02 = (newState === 2)
                                                    } else if (index === 1) {
                                                        mainDrawing.sw_LVI1_ZK03 = (newState === 2)
                                                    } else {
                                                        mainDrawing.sw_LVI1_ZK04 = (newState === 2)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 150
                                color: "transparent"
                                border.color: "#45475a"
                                border.width: 1
                                radius: 4

                                Text {
                                    anchors.top: parent.top
                                    anchors.left: parent.left
                                    anchors.margins: 5
                                    text: "柜前二次室"
                                    font.pixelSize: 12
                                    color: "#cdd6f4"
                                    font.family: "Segoe UI"
                                }

                                RowLayout {
                                    anchors.top: parent.top
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    anchors.bottom: parent.bottom
                                    anchors.topMargin: 25
                                    anchors.leftMargin: 10
                                    anchors.rightMargin: 10
                                    anchors.bottomMargin: 10
                                    spacing: 10

                                    Repeater {
                                        model: 3

                                        ColumnLayout {
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            Layout.preferredWidth: 0
                                            spacing: 5

                                            Text {
                                                Layout.alignment: Qt.AlignHCenter
                                                text: index === 0 ? "ZK15" : index === 1 ? "ZK1" : "ZK2"
                                                font.pixelSize: 14
                                                color: "#cdd6f4"
                                                font.family: "Segoe UI"
                                            }

                                            Image {
                                                Layout.fillWidth: true
                                                Layout.fillHeight: true
                                                source: index === 0 ? "qrc:/img/kk_3p.png" : "qrc:/img/kk_2p.png"
                                                fillMode: Image.PreserveAspectFit
                                                sourceSize: Qt.size(width, height)
                                            }

                                            ToggleSwitch {
                                                Layout.alignment: Qt.AlignHCenter
                                                Layout.preferredWidth: 30
                                                Layout.preferredHeight: 60
                                                type: 2
                                                state: index === 0 ? (mainDrawing.sw_LVI1_ZK15 ? 2 : 1) : index === 1 ? (mainDrawing.sw_LVI1_ZK1 ? 2 : 1) : (mainDrawing.sw_LVI1_ZK2 ? 2 : 1)
                                                labels: ["分", "合"]
                                                onToggleStateChanged: function(newState) {
                                                    if (index === 0) {
                                                        mainDrawing.sw_LVI1_ZK15 = (newState === 2)
                                                    } else if (index === 1) {
                                                        mainDrawing.sw_LVI1_ZK1 = (newState === 2)
                                                    } else {
                                                        mainDrawing.sw_LVI1_ZK2 = (newState === 2)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                color: "transparent"
                                border.color: "#45475a"
                                border.width: 1
                                radius: 4

                                Text {
                                    anchors.top: parent.top
                                    anchors.left: parent.left
                                    anchors.margins: 5
                                    text: "柜前面板"
                                    font.pixelSize: 12
                                    color: "#cdd6f4"
                                    font.family: "Segoe UI"
                                }

                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.topMargin: 25
                                    anchors.leftMargin: 10
                                    anchors.rightMargin: 10
                                    anchors.bottomMargin: 10
                                    spacing: 10

                                    RowLayout {
                                        Layout.fillWidth: true
                                        spacing: 20

                                        Repeater {
                                            model: 4

                                            ColumnLayout {
                                                Layout.fillWidth: true
                                                Layout.fillHeight: true
                                                Layout.preferredWidth: 0
                                                spacing: 5

                                                Text {
                                                    Layout.alignment: Qt.AlignHCenter
                                                    text: index === 0 ? "HG" : index === 1 ? "HR" : index === 2 ? "HW" : "HY"
                                                    font.pixelSize: 14
                                                    color: "#cdd6f4"
                                                    font.family: "Segoe UI"
                                                }

                                                IndicatorLight {
                                                    Layout.alignment: Qt.AlignHCenter
                                                    Layout.preferredWidth: 30
                                                    Layout.preferredHeight: 30
                                                    isOn: index === 0 ? mainDrawing.q_LVI1_HG_isPower : index === 1 ? mainDrawing.q_LVI1_HR_isPower : index === 2 ? mainDrawing.q_LVI1_HW_isPower : mainDrawing.q_LVI1_HY_isPower
                                                    onColor: index === 0 ? "#00FF00" : index === 1 ? "#FF0000" : index === 2 ? "#FFFF00" : "#ffffff"
                                                    offColor: "#45475a"
                                                    glowColor: index === 0 ? "#a6e3a1" : index === 1 ? "#f38ba8" : index === 2 ? "#f9e2af" : "#ffffff"
                                                }

                                                Text {
                                                    Layout.alignment: Qt.AlignHCenter
                                                    text: index === 0 ? "分闸\n指示" : index === 1 ? "合闸\n指示" : index === 2 ? "储能\n指示" : "故障\n指示"
                                                    font.pixelSize: 12
                                                    color: "#cdd6f4"
                                                    font.family: "Segoe UI"
                                                    horizontalAlignment: Text.AlignHCenter
                                                }
                                            }
                                        }
                                    }

                                    RowLayout {
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 30
                                        spacing: 10

                                        ColumnLayout {
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            spacing: 5

                                            Text {
                                                Layout.alignment: Qt.AlignHCenter
                                                text: "SB1"
                                                font.pixelSize: 12
                                                color: "#cdd6f4"
                                                font.family: "Segoe UI"
                                            }

                                            JogButton {
                                                Layout.fillWidth: true
                                                Layout.fillHeight: true
                                                Layout.minimumHeight: 30
                                                Layout.maximumHeight: 30
                                                text: "合闸按钮"
                                                onPressed: {
                                                    mainDrawing.sw_LVI1_SB1 = true
                                                }
                                                onReleased: {
                                                    mainDrawing.sw_LVI1_SB1 = false
                                                }
                                            }
                                        }

                                        ColumnLayout {
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            spacing: 5

                                            Text {
                                                Layout.alignment: Qt.AlignHCenter
                                                text: "SB2"
                                                font.pixelSize: 12
                                                color: "#cdd6f4"
                                                font.family: "Segoe UI"
                                            }

                                            JogButton {
                                                Layout.fillWidth: true
                                                Layout.fillHeight: true
                                                Layout.minimumHeight: 30
                                                Layout.maximumHeight: 30
                                                text: "分闸按钮"
                                                onPressed: {
                                                    mainDrawing.sw_LVI1_SB2 = true
                                                }
                                                onReleased: {
                                                    mainDrawing.sw_LVI1_SB2 = false
                                                }
                                            }
                                        }
                                    }

                                    Image {
                                        Layout.alignment: Qt.AlignHCenter
                                        Layout.preferredWidth: 160
                                        Layout.preferredHeight: 160
                                        source: "qrc:/img/QF.png"
                                        fillMode: Image.PreserveAspectFit
                                        sourceSize: Qt.size(width, height)
                                    }

                                    RowLayout {
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 120
                                        spacing: 20

                                        ColumnLayout {
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            spacing: 5

                                            ToggleSwitch {
                                                Layout.alignment: Qt.AlignHCenter
                                                Layout.preferredWidth: 90
                                                Layout.preferredHeight: 80
                                                type: 2
                                                state: mainDrawing.sw_LVI1_ManualFault ? 2 : 1
                                                labels: ["正常", "故障"]
                                                onToggleStateChanged: function(newState) {
                                                    mainDrawing.sw_1QF_Malfunction = (newState === 2)
                                                }
                                            }

                                            Text {
                                                Layout.alignment: Qt.AlignHCenter
                                                text: "手动故障"
                                                font.pixelSize: 12
                                                color: "#cdd6f4"
                                                font.family: "Segoe UI"
                                            }
                                        }

                                        ColumnLayout {
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            spacing: 5

                                            ToggleSwitch {
                                                Layout.alignment: Qt.AlignHCenter
                                                Layout.preferredWidth: 90
                                                Layout.preferredHeight: 80
                                                type: 3
                                                state: mainDrawing.sw_1QF_Location
                                                labels: ["工作位", "试验位", "隔离位"]
                                                onToggleStateChanged: function(newState) {
                                                    mainDrawing.sw_1QF_Location = newState
                                                }
                                            }

                                            Text {
                                                Layout.alignment: Qt.AlignHCenter
                                                text: "断路器位置"
                                                font.pixelSize: 12
                                                color: "#cdd6f4"
                                                font.family: "Segoe UI"
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: "#646679"
                        radius: 6

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 10
                            spacing: 10

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                text: "LVC"
                                font.pixelSize: 14
                                color: "#cdd6f4"
                                font.family: "Segoe UI"
                            }
                            
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 150
                                color: "transparent"
                                border.color: "#45475a"
                                border.width: 1
                                radius: 4

                                Text {
                                    anchors.top: parent.top
                                    anchors.left: parent.left
                                    anchors.margins: 5
                                    text: "柜前二次室"
                                    font.pixelSize: 12
                                    color: "#cdd6f4"
                                    font.family: "Segoe UI"
                                }

                                RowLayout {
                                    anchors.top: parent.top
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    anchors.bottom: parent.bottom
                                    anchors.topMargin: 25
                                    anchors.leftMargin: 10
                                    anchors.rightMargin: 10
                                    anchors.bottomMargin: 10
                                    spacing: 10

                                    Repeater {
                                        model: 2

                                        ColumnLayout {
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            spacing: 5

                                            Text {
                                                Layout.alignment: Qt.AlignHCenter
                                                text: index === 0 ? "ZK1" : "ZK10"
                                                font.pixelSize: 14
                                                color: "#cdd6f4"
                                                font.family: "Segoe UI"
                                            }

                                            Image {
                                                Layout.fillWidth: true
                                                Layout.fillHeight: true
                                                source: "qrc:/img/kk_2p.png"
                                                fillMode: Image.PreserveAspectFit
                                                sourceSize: Qt.size(width, height)
                                            }

                                            ToggleSwitch {
                                                Layout.alignment: Qt.AlignHCenter
                                                Layout.preferredWidth: 30
                                                Layout.preferredHeight: 60
                                                type: 2
                                                state: index === 0 ? (mainDrawing.sw_LVC_ZK1 ? 2 : 1) : (mainDrawing.sw_PLC_ZK10 ? 2 : 1)
                                                labels: ["分", "合"]
                                                onToggleStateChanged: function(newState) {
                                                    if (index === 0) {
                                                        mainDrawing.sw_LVC_ZK1 = (newState === 2)
                                                    } else if (index === 1) {
                                                        mainDrawing.sw_PLC_ZK10 = (newState === 2)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                color: "transparent"
                                border.color: "#45475a"
                                border.width: 1
                                radius: 4

                                Text {
                                    anchors.top: parent.top
                                    anchors.left: parent.left
                                    anchors.margins: 5
                                    text: "柜前面板"
                                    font.pixelSize: 12
                                    color: "#cdd6f4"
                                    font.family: "Segoe UI"
                                }
                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.topMargin: 25
                                    anchors.leftMargin: 10
                                    anchors.rightMargin: 10
                                    anchors.bottomMargin: 10
                                    spacing: 10

                                    RowLayout {
                                        Layout.fillWidth: true
                                        spacing: 30

                                        Repeater {
                                            model: 2

                                            ColumnLayout {
                                                Layout.fillWidth: true
                                                Layout.fillHeight: true
                                                spacing: 5
                                                
                                                ToggleSwitch {
                                                    Layout.alignment: Qt.AlignHCenter
                                                    Layout.preferredWidth: index === 0 ? 50 : 90
                                                    Layout.preferredHeight: 90
                                                    type: index === 0 ? 2 : 3
                                                    state: index === 0 ? (mainDrawing.sw_LVC_isRemote ? 1 : 2) : mainDrawing.sw_LVC_ControlMode
                                                    labels: index === 0 ? ["远方", "就地"] : ["自投自复", "手投手复", "自投手复"]
                                                    onToggleStateChanged: function(newState) {
                                                        if (index === 0) {
                                                            mainDrawing.sw_LVC_isRemote = (newState === 1)
                                                        } else if (index === 1) {
                                                            mainDrawing.sw_LVC_ControlMode = newState
                                                        }
                                                    }
                                                }
                                                Text {
                                                    Layout.alignment: Qt.AlignHCenter
                                                    text: index === 0 ? "远方/就地" : "控制方式"
                                                    font.pixelSize: 14
                                                    color: "#cdd6f4"
                                                    font.family: "Segoe UI"
                                                }
                                            }
                                        }
                                    }

                                    RowLayout {
                                        Layout.fillWidth: true
                                        spacing: 20

                                        Repeater {
                                            model: 4

                                            ColumnLayout {
                                                Layout.fillWidth: true
                                                Layout.fillHeight: true
                                                Layout.preferredWidth: 0
                                                spacing: 5

                                                Text {
                                                    Layout.alignment: Qt.AlignHCenter
                                                    text: index === 0 ? "HG" : index === 1 ? "HR" : index === 2 ? "HW" : "HY"
                                                    font.pixelSize: 14
                                                    color: "#cdd6f4"
                                                    font.family: "Segoe UI"
                                                }

                                                IndicatorLight {
                                                    Layout.alignment: Qt.AlignHCenter
                                                    Layout.preferredWidth: 30
                                                    Layout.preferredHeight: 30
                                                    isOn: index === 0 ? mainDrawing.q_LVC_HG_isPower : index === 1 ? mainDrawing.q_LVC_HR_isPower : index === 2 ? mainDrawing.q_LVC_HW_isPower : mainDrawing.q_LVC_HY_isPower
                                                    onColor: index === 0 ? "#00FF00" : index === 1 ? "#FF0000" : index === 2 ? "#FFFF00" : "#ffffff"
                                                    offColor: "#45475a"
                                                    glowColor: index === 0 ? "#a6e3a1" : index === 1 ? "#f38ba8" : index === 2 ? "#f9e2af" : "#ffffff"
                                                }

                                                Text {
                                                    Layout.alignment: Qt.AlignHCenter
                                                    text: index === 0 ? "分闸\n指示" : index === 1 ? "合闸\n指示" : index === 2 ? "储能\n指示" : "故障\n指示"
                                                    font.pixelSize: 12
                                                    color: "#cdd6f4"
                                                    font.family: "Segoe UI"
                                                    horizontalAlignment: Text.AlignHCenter
                                                }
                                            }
                                        }
                                    }

                                    RowLayout {
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 30
                                        spacing: 10

                                        ColumnLayout {
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            spacing: 5

                                            Text {
                                                Layout.alignment: Qt.AlignHCenter
                                                text: "SB1"
                                                font.pixelSize: 12
                                                color: "#cdd6f4"
                                                font.family: "Segoe UI"
                                            }

                                            JogButton {
                                                Layout.fillWidth: true
                                                Layout.fillHeight: true
                                                Layout.minimumHeight: 30
                                                Layout.maximumHeight: 30
                                                text: "合闸按钮"
                                                onPressed: {
                                                    mainDrawing.sw_LVC_SB1 = true
                                                }
                                                onReleased: {
                                                    mainDrawing.sw_LVC_SB1 = false
                                                }
                                            }
                                        }

                                        ColumnLayout {
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            spacing: 5

                                            Text {
                                                Layout.alignment: Qt.AlignHCenter
                                                text: "SB2"
                                                font.pixelSize: 12
                                                color: "#cdd6f4"
                                                font.family: "Segoe UI"
                                            }

                                            JogButton {
                                                Layout.fillWidth: true
                                                Layout.fillHeight: true
                                                Layout.minimumHeight: 30
                                                Layout.maximumHeight: 30
                                                text: "分闸按钮"
                                                onPressed: {
                                                    mainDrawing.sw_LVC_SB2 = true
                                                }
                                                onReleased: {
                                                    mainDrawing.sw_LVC_SB2 = false
                                                }
                                            }
                                        }
                                    }

                                    Image {
                                        Layout.alignment: Qt.AlignHCenter
                                        Layout.preferredWidth: 160
                                        Layout.preferredHeight: 160
                                        source: "qrc:/img/QF.png"
                                        fillMode: Image.PreserveAspectFit
                                        sourceSize: Qt.size(width, height)
                                    }

                                    RowLayout {
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 120
                                        spacing: 20

                                        ColumnLayout {
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            spacing: 5

                                            ToggleSwitch {
                                                Layout.alignment: Qt.AlignHCenter
                                                Layout.preferredWidth: 90
                                                Layout.preferredHeight: 80
                                                type: 2
                                                state: mainDrawing.sw_LVC_ManualFault ? 2 : 1
                                                labels: ["正常", "故障"]
                                                onToggleStateChanged: function(newState) {
                                                    mainDrawing.sw_3QF_Malfunction = (newState === 2)
                                                }
                                            }

                                            Text {
                                                Layout.alignment: Qt.AlignHCenter
                                                text: "手动故障"
                                                font.pixelSize: 12
                                                color: "#cdd6f4"
                                                font.family: "Segoe UI"
                                            }
                                        }

                                        ColumnLayout {
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            spacing: 5

                                            ToggleSwitch {
                                                Layout.alignment: Qt.AlignHCenter
                                                Layout.preferredWidth: 90
                                                Layout.preferredHeight: 80
                                                type: 3
                                                state: mainDrawing.sw_3QF_Location
                                                labels: ["工作位", "试验位", "隔离位"]
                                                onToggleStateChanged: function(newState) {
                                                    mainDrawing.sw_3QF_Location = newState
                                                }
                                            }

                                            Text {
                                                Layout.alignment: Qt.AlignHCenter
                                                text: "断路器位置"
                                                font.pixelSize: 12
                                                color: "#cdd6f4"
                                                font.family: "Segoe UI"
                                            }
                                        }
                                    }
                                }                                
                            }
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: "#646679"
                        radius: 6

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 10
                            spacing: 10

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                Layout.topMargin: 8
                                text: "LVI2"
                                font.pixelSize: 14
                                color: "#cdd6f4"
                                font.family: "Segoe UI"
                            }

                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 150
                                color: "transparent"
                                border.color: "#45475a"
                                border.width: 1
                                radius: 4

                                Text {
                                    anchors.top: parent.top
                                    anchors.left: parent.left
                                    anchors.margins: 5
                                    text: "柜后"
                                    font.pixelSize: 12
                                    color: "#cdd6f4"
                                    font.family: "Segoe UI"
                                }

                                RowLayout {
                                    anchors.top: parent.top
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    anchors.bottom: parent.bottom
                                    anchors.topMargin: 25
                                    anchors.leftMargin: 10
                                    anchors.rightMargin: 10
                                    anchors.bottomMargin: 10
                                    spacing: 10

                                    Repeater {
                                        model: 3

                                        ColumnLayout {
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            spacing: 5

                                            Text {
                                                Layout.alignment: Qt.AlignHCenter
                                                text: index === 0 ? "ZK02" : index === 1 ? "ZK03" : "ZK04"
                                                font.pixelSize: 14
                                                color: "#cdd6f4"
                                                font.family: "Segoe UI"
                                            }

                                            Image {
                                                Layout.fillWidth: true
                                                Layout.fillHeight: true
                                                source: "qrc:/img/kk_2p.png"
                                                fillMode: Image.PreserveAspectFit
                                                sourceSize: Qt.size(width, height)
                                            }

                                            ToggleSwitch {
                                                Layout.alignment: Qt.AlignHCenter
                                                Layout.preferredWidth: 30
                                                Layout.preferredHeight: 50
                                                type: 2
                                                state: index === 0 ? (mainDrawing.sw_LVI2_ZK02 ? 2 : 1) : index === 1 ? (mainDrawing.sw_LVI2_ZK03 ? 2 : 1) : (mainDrawing.sw_LVI2_ZK04 ? 2 : 1)
                                                labels: ["分", "合"]
                                                onToggleStateChanged: function(newState) {
                                                    if (index === 0) {
                                                        mainDrawing.sw_LVI2_ZK02 = (newState === 2)
                                                    } else if (index === 1) {
                                                        mainDrawing.sw_LVI2_ZK03 = (newState === 2)
                                                    } else {
                                                        mainDrawing.sw_LVI2_ZK04 = (newState === 2)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 150
                                color: "transparent"
                                border.color: "#45475a"
                                border.width: 1
                                radius: 4

                                Text {
                                    anchors.top: parent.top
                                    anchors.left: parent.left
                                    anchors.margins: 5
                                    text: "柜前二次室"
                                    font.pixelSize: 12
                                    color: "#cdd6f4"
                                    font.family: "Segoe UI"
                                }

                                RowLayout {
                                    anchors.top: parent.top
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    anchors.bottom: parent.bottom
                                    anchors.topMargin: 25
                                    anchors.leftMargin: 10
                                    anchors.rightMargin: 10
                                    anchors.bottomMargin: 10
                                    spacing: 10

                                    Repeater {
                                        model: 3

                                        ColumnLayout {
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            spacing: 5

                                            Text {
                                                Layout.alignment: Qt.AlignHCenter
                                                text: index === 0 ? "ZK15" : index === 1 ? "ZK1" : "ZK2"
                                                font.pixelSize: 14
                                                color: "#cdd6f4"
                                                font.family: "Segoe UI"
                                            }

                                            Image {
                                                Layout.fillWidth: true
                                                Layout.fillHeight: true
                                                source: index === 0 ? "qrc:/img/kk_3p.png" : "qrc:/img/kk_2p.png"
                                                fillMode: Image.PreserveAspectFit
                                                sourceSize: Qt.size(width, height)
                                            }

                                            ToggleSwitch {
                                                Layout.alignment: Qt.AlignHCenter
                                                Layout.preferredWidth: 30
                                                Layout.preferredHeight: 60
                                                type: 2
                                                state: index === 0 ? (mainDrawing.sw_LVI2_ZK15 ? 2 : 1) : index === 1 ? (mainDrawing.sw_LVI2_ZK1 ? 2 : 1) : (mainDrawing.sw_LVI2_ZK2 ? 2 : 1)
                                                labels: ["分", "合"]
                                                onToggleStateChanged: function(newState) {
                                                    if (index === 0) {
                                                        mainDrawing.sw_LVI2_ZK15 = (newState === 2)
                                                    } else if (index === 1) {
                                                        mainDrawing.sw_LVI2_ZK1 = (newState === 2)
                                                    } else {
                                                        mainDrawing.sw_LVI2_ZK2 = (newState === 2)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                color: "transparent"
                                border.color: "#45475a"
                                border.width: 1
                                radius: 4

                                Text {
                                    anchors.top: parent.top
                                    anchors.left: parent.left
                                    anchors.margins: 5
                                    text: "柜前面板"
                                    font.pixelSize: 12
                                    color: "#cdd6f4"
                                    font.family: "Segoe UI"
                                }

                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.topMargin: 25
                                    anchors.leftMargin: 10
                                    anchors.rightMargin: 10
                                    anchors.bottomMargin: 10
                                    spacing: 10

                                    RowLayout {
                                        Layout.fillWidth: true
                                        spacing: 20

                                        Repeater {
                                            model: 4

                                            ColumnLayout {
                                                Layout.fillWidth: true
                                                Layout.fillHeight: true
                                                Layout.preferredWidth: 0
                                                spacing: 5

                                                Text {
                                                    Layout.alignment: Qt.AlignHCenter
                                                    text: index === 0 ? "HG" : index === 1 ? "HR" : index === 2 ? "HW" : "HY"
                                                    font.pixelSize: 14
                                                    color: "#cdd6f4"
                                                    font.family: "Segoe UI"
                                                }

                                                IndicatorLight {
                                                    Layout.alignment: Qt.AlignHCenter
                                                    Layout.preferredWidth: 30
                                                    Layout.preferredHeight: 30
                                                    isOn: index === 0 ? mainDrawing.q_LVI2_HG_isPower : index === 1 ? mainDrawing.q_LVI2_HR_isPower : index === 2 ? mainDrawing.q_LVI2_HW_isPower : mainDrawing.q_LVI2_HY_isPower
                                                    onColor: index === 0 ? "#00FF00" : index === 1 ? "#FF0000" : index === 2 ? "#FFFF00" : "#ffffff"
                                                    offColor: "#45475a"
                                                    glowColor: index === 0 ? "#a6e3a1" : index === 1 ? "#f38ba8" : index === 2 ? "#f9e2af" : "#ffffff"
                                                }

                                                Text {
                                                    Layout.alignment: Qt.AlignHCenter
                                                    text: index === 0 ? "分闸\n指示" : index === 1 ? "合闸\n指示" : index === 2 ? "储能\n指示" : "故障\n指示"
                                                    font.pixelSize: 12
                                                    color: "#cdd6f4"
                                                    font.family: "Segoe UI"
                                                    horizontalAlignment: Text.AlignHCenter
                                                }
                                            }
                                        }
                                    }

                                    RowLayout {
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 30
                                        spacing: 10

                                        ColumnLayout {
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            spacing: 5

                                            Text {
                                                Layout.alignment: Qt.AlignHCenter
                                                text: "SB1"
                                                font.pixelSize: 12
                                                color: "#cdd6f4"
                                                font.family: "Segoe UI"
                                            }

                                            JogButton {
                                                Layout.fillWidth: true
                                                Layout.fillHeight: true
                                                Layout.minimumHeight: 30
                                                Layout.maximumHeight: 30
                                                text: "合闸按钮"
                                                onPressed: {
                                                    mainDrawing.sw_LVI2_SB1 = true
                                                }
                                                onReleased: {
                                                    mainDrawing.sw_LVI2_SB1 = false
                                                }
                                            }
                                        }

                                        ColumnLayout {
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            spacing: 5

                                            Text {
                                                Layout.alignment: Qt.AlignHCenter
                                                text: "SB2"
                                                font.pixelSize: 12
                                                color: "#cdd6f4"
                                                font.family: "Segoe UI"
                                            }

                                            JogButton {
                                                Layout.fillWidth: true
                                                Layout.fillHeight: true
                                                Layout.minimumHeight: 30
                                                Layout.maximumHeight: 30
                                                text: "分闸按钮"
                                                onPressed: {
                                                    mainDrawing.sw_LVI2_SB2 = true
                                                }
                                                onReleased: {
                                                    mainDrawing.sw_LVI2_SB2 = false
                                                }
                                            }
                                        }
                                    }

                                    Image {
                                        Layout.alignment: Qt.AlignHCenter
                                        Layout.preferredWidth: 160
                                        Layout.preferredHeight: 160
                                        source: "qrc:/img/QF.png"
                                        fillMode: Image.PreserveAspectFit
                                        sourceSize: Qt.size(width, height)
                                    }

                                    RowLayout {
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 120
                                        spacing: 20

                                        ColumnLayout {
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            spacing: 5

                                            ToggleSwitch {
                                                Layout.alignment: Qt.AlignHCenter
                                                Layout.preferredWidth: 90
                                                Layout.preferredHeight: 80
                                                type: 2
                                                state: mainDrawing.sw_LVI2_ManualFault ? 2 : 1
                                                labels: ["正常", "故障"]
                                                onToggleStateChanged: function(newState) {
                                                    mainDrawing.sw_2QF_Malfunction = (newState === 2)
                                                }
                                            }

                                            Text {
                                                Layout.alignment: Qt.AlignHCenter
                                                text: "手动故障"
                                                font.pixelSize: 12
                                                color: "#cdd6f4"
                                                font.family: "Segoe UI"
                                            }
                                        }

                                        ColumnLayout {
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            spacing: 5

                                            ToggleSwitch {
                                                Layout.alignment: Qt.AlignHCenter
                                                Layout.preferredWidth: 90
                                                Layout.preferredHeight: 80
                                                type: 3
                                                state: mainDrawing.sw_2QF_Location
                                                labels: ["工作位", "试验位", "隔离位"]
                                                onToggleStateChanged: function(newState) {
                                                    mainDrawing.sw_2QF_Location = newState
                                                }
                                            }

                                            Text {
                                                Layout.alignment: Qt.AlignHCenter
                                                text: "断路器位置"
                                                font.pixelSize: 12
                                                color: "#cdd6f4"
                                                font.family: "Segoe UI"
                                            }
                                        }
                                    }
                                }
                            }                        
                        }
                    }
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: "#646679"
                        radius: 6

                        Text {
                            anchors.top: parent.top
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.topMargin: 8
                            text: "面板"
                            font.pixelSize: 14
                            color: "#cdd6f4"
                            font.family: "Segoe UI"
                        }
                    }
                }
            }
        }
    }
}
