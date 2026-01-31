import QtQuick 2.15
import QtQuick.Window 2.15

MouseArea {
    id: root
    property var window
    property string resizeEdge: "right"
    property int borderWidth: 8
    property int cornerSize: 16

    property point startPos: Qt.point(0, 0)
    property point startGeometry: Qt.point(0, 0)
    property int startWidth: 0
    property int startHeight: 0

    hoverEnabled: true
    cursorShape: {
        if (resizeEdge === "left" || resizeEdge === "right") return Qt.SizeHorCursor
        if (resizeEdge === "top" || resizeEdge === "bottom") return Qt.SizeVerCursor
        if (resizeEdge === "topLeft" || resizeEdge === "bottomRight") return Qt.SizeFDiagCursor
        if (resizeEdge === "topRight" || resizeEdge === "bottomLeft") return Qt.SizeBDiagCursor
        return Qt.ArrowCursor
    }

    onPressed: function(mouse) {
        startPos = Qt.point(mouse.x, mouse.y)
        startGeometry = Qt.point(window.x, window.y)
        startWidth = window.width
        startHeight = window.height
    }

    onPositionChanged: function(mouse) {
        if (!pressed || window.visibility === Window.Maximized) return

        var deltaX = mouse.x - startPos.x
        var deltaY = mouse.y - startPos.y

        if (resizeEdge === "right") {
            window.width = Math.max(window.minimumWidth, startWidth + deltaX)
        } else if (resizeEdge === "left") {
            var newWidth = Math.max(window.minimumWidth, startWidth - deltaX)
            window.width = newWidth
            window.x = startGeometry.x + (startWidth - newWidth)
        } else if (resizeEdge === "bottom") {
            window.height = Math.max(window.minimumHeight, startHeight + deltaY)
        } else if (resizeEdge === "top") {
            var newHeight = Math.max(window.minimumHeight, startHeight - deltaY)
            window.height = newHeight
            window.y = startGeometry.y + (startHeight - newHeight)
        } else if (resizeEdge === "topLeft") {
            var newWidthTL = Math.max(window.minimumWidth, startWidth - deltaX)
            var newHeightTL = Math.max(window.minimumHeight, startHeight - deltaY)
            window.width = newWidthTL
            window.height = newHeightTL
            window.x = startGeometry.x + (startWidth - newWidthTL)
            window.y = startGeometry.y + (startHeight - newHeightTL)
        } else if (resizeEdge === "topRight") {
            var newHeightTR = Math.max(window.minimumHeight, startHeight - deltaY)
            window.width = Math.max(window.minimumWidth, startWidth + deltaX)
            window.height = newHeightTR
            window.y = startGeometry.y + (startHeight - newHeightTR)
        } else if (resizeEdge === "bottomLeft") {
            var newWidthBL = Math.max(window.minimumWidth, startWidth - deltaX)
            window.width = newWidthBL
            window.height = Math.max(window.minimumHeight, startHeight + deltaY)
            window.x = startGeometry.x + (startWidth - newWidthBL)
        } else if (resizeEdge === "bottomRight") {
            window.width = Math.max(window.minimumWidth, startWidth + deltaX)
            window.height = Math.max(window.minimumHeight, startHeight + deltaY)
        }
    }
}
