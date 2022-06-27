import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    property alias slider: slider
    property int stats:0

    id: playRowlayout

    anchors.bottom: parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.rightMargin: 20
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
        //stepSize: content.mediaplay.duration/100
        snapMode:SnapOnRelease
        //position: //content.mediaplay.position
        value: content.mediaplay.position

        onMoved: {
            console.log(value)
            value=valueAt(slider.position)
            content.mediaplay.setPosition(slider.value)
        }
    }
    Button{
        id:collects
        text: "收藏"
        onClicked: {
            stats=1
            console.log(content.mediaplay.source)
            leftmargin.listmodels.clear()
            leftmargin.listmodels.append({"medias":content.mediaplay.source,
                                         "names":currentsong.songtx.text})

        }
    }

}
