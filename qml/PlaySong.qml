import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    property alias slider: slider
<<<<<<< HEAD


=======
    property alias value: slidersound.value
    property string nowtimes:"00:00"
    property string tataltimes:"00:00"
>>>>>>> b3c40b0 (完成了歌单的删除创建和添加及播放列表，和上一首下一首的切换及歌曲信息的保存，)
    id: playRowlayout

    anchors.bottom: parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.rightMargin: 20
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

    Text {
        id: nowtime
        text: qsTr(nowtimes)
    }

    Rectangle{
        height: 20
        width: 250
    Slider {
        id: slider
        anchors.fill: parent
        width: 500
        from: 0
        to: content.mediaplay.duration
        onMoved: {
            content.mediaplay.setPosition(slider.value)
        }

    }
    }

    Text {
        id: tataltime
        text: qsTr(tataltimes)
    }
    Button{
        id:collect
        text: qsTr("收藏")
        onClicked: {
            playlist.listmodels.clear()
            playlist.listmodels.append({"medias":content.mediaplay.source,
                                           "names":currentsong.songtx.text,
                                           //"lyrics":songsearchdialog.kugou.lyrics
                                       })
            playlist.state=1
        }
    }

    Button{
        id:nowplayliston
        text: "当前播放列表"
        onClicked:
        {
            nowplaylist.visible=true
        }
    }

    Button{
        id:collect
        text: qsTr("收藏")
        onClicked: {
            playlist.listmodels.clear()
            playlist.listmodels.append({"medias":content.mediaplay.source,
                                           "names":currentsong.songtx.text,
                                           //"lyrics":songsearchdialog.kugou.lyrics
                                       })
            playlist.state=1
        }
    }

    Button{
        id:nowplayliston
        text: "当前播放列表"
        onClicked:
        {
            nowplaylist.visible=true
        }
    }




}
