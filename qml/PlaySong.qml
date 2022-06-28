import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    property alias slider: slider
    property alias value: slidersound.value
    id: playRowlayout

    anchors.bottom: parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.rightMargin: 20

    Slider {
        id: slidersound
        enabled: true
        from: 0
        to: 100
        value: 20
    }

    Rectangle {
        id: desktop
        width: 20
        height: 20
        border.color: "grey"
        Text {
            anchors.centerIn: parent
            text: qsTr("词")
        }
        TapHandler {
            onTapped: {
                var desktopLyricCounts = desktopLyricDialog.counts++
                if (desktopLyricCounts % 2 == 0) {
                    desktopLyricDialog.visible = true
                } else {
                    desktopLyricDialog.visible = false
                }
            }
        }
    }

    ToolButton {
        action: actions.lastAction
        text: qsTr("")
    }
    ToolButton {
        action: actions.playAction
        text: qsTr("")
    }
    ToolButton {
        action: actions.nextAction
        text: qsTr("")
    }
    Slider {
        id: slider
        from: 0
        to: content.mediaplay.duration
        value: content.mediaplay.position
        onMoved: {
            content.mediaplay.setPosition(slider.value)
        }
    }
}
