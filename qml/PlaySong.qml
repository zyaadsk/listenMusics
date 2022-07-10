/* ListenToSomeMusic Player
 * zhangyu:2020051615216
 * hulu:2020051615204
 * zahngyu:2020051615218
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    color: "white"
    property alias slider: slider
    property alias value: slidersound.value
    property string nowtimes: "00:00"
    property string tataltimes: "00:00"
    anchors.bottom: parent.bottom
    //    anchors.horizontalCenter: parent.horizontalCenter
    height: 30
    width: parent.width
    RowLayout {
        //        color: "red"
        //        property alias slider: slider
        //        property alias value: slidersound.value
        id: playRowlayout
        anchors.left: parent.left
        anchors.leftMargin: 20

        //        anchors.bottom: parent.bottom
        //        anchors.horizontalCenter: parent.horizontalCenter
        //        anchors.rightMargin: 20
        ToolButton {
            id: collect
            icon.source: "/resource/image/保存.png"
            onClicked: {
                playlist.listmodels.clear()
                playlist.listmodels.append({
                                               "medias": content.mediaplay.source,
                                               "names": currentsong.songtx.text,
                                               "images": currentsong.img.source.toString(),
                                               "songs": currentsong.songtx.text,
                                               "singers": currentsong.singertx.text,
                                               "lyrics":songsearchdialog.kugou.lyrics,
                                               "froms":"1"
                                           })
                playlist.state = 1
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
        Rectangle {
            width: 450
            height: 30
            Slider {
                anchors.fill: parent
                id: slider
                from: 0
                to: content.mediaplay.duration
                value: content.mediaplay.position
                onMoved: {
                    content.mediaplay.setPosition(slider.value)
                }
            }
        }
        Text {
            id: tataltime
            text: qsTr(tataltimes)
        }
        Rectangle {
            id: desktop
            width: 20
            height: 20
            border.color: "gray"
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
            icon.source: "/resource/image/voice.png"
        }

        Rectangle {
            width: 100
            height: 30
            Slider {
                anchors.fill: parent
                id: slidersound
                enabled: true
                from: 0
                to: 100
                value: 20
            }
        }
        ToolButton {
            id: nowplayliston
            icon.source: "/resource/image/播放列表.png"
            //            onClicked: {
            //                nowplaylist.visible = true
            //            }

            //鼠标悬停时最近播放列表显示，鼠标移开，不显示
            HoverHandler {
                onHoveredChanged: {
                    if (hovered) {
                        nowplaylist.nowPlaylistRec.visible = true
                    }
                    if (!hovered && !nowplaylist.recentRecHovered.hovered) {
                        nowplaylist.nowPlaylistRec.visible = false
                    }
                }
            }
        }
    }
}
