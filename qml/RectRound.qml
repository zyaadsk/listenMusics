import QtQuick
import Qt5Compat.GraphicalEffects

Rectangle {
    property alias image: image
    property alias animation: animation
    id: rect_round
    width: 300
    height: 300
    radius: 150
    anchors.top: searchBar.bottom
    anchors.left: parent.left
    anchors.topMargin: 80
    anchors.leftMargin: 60
    color: "black"
    Image {
        id: image
        smooth: true
        visible: false
        anchors.fill: parent
        sourceSize: Qt.size(parent.size, parent.size)
        antialiasing: true
        NumberAnimation {
            id: animation
            running: rect_round
            loops: Animation.Infinite
            target: rect_round
            from: 0
            to: 360
            property: "rotation"
            duration: 10000
        }
    }
    Rectangle {
        id: mask
        color: "black"
        anchors.fill: parent
        radius: 150
        visible: false
        antialiasing: true
        smooth: true
    }

    OpacityMask {
        id: mask_iamge
        anchors.fill: mask
        source: image
        maskSource: mask
        visible: true
        antialiasing: true
    }
}
