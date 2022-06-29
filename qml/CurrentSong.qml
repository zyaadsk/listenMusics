import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    property alias img: img
    property alias songtx: songtx
    property alias singertx: singertx
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.rightMargin: 10
    anchors.bottomMargin: 40
    width: 160
    height: 70
    radius: 4
    RowLayout {
        id: smallRowlayout
        spacing: 5

        Rectangle {
            id: lyric

            height: 60
            width: 60
            Image {
                anchors.fill: parent
                anchors.leftMargin: 5
                id: img
                fillMode: Image.PreserveAspectFit
                clip: true
                source: "/resource/background/1.png"
                TapHandler {
                    onTapped: {
                        var lyricCounts = lyricDialog.counts++
                        if (lyricCounts % 2 == 0) {
                            lyricDialog.visible = true
                            rectround.visible = true
                            songsearchdialog.visible = false
                            playlist.visible=false
                        } else {
                            lyricDialog.visible = false
                            rectround.visible = false
                            songsearchdialog.visible = true
                            playlist.visible=true
                        }
                    }
                }
            }
        }

        ColumnLayout {
            id: smallColumnlayout
            spacing: 4

            Rectangle {
                height: 33
                width: 70
                clip: true
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    id: songtx
                    font.bold: true
                    text: qsTr("听点儿音乐")
                    elide: Text.ElideRight
                }
            }

            Rectangle {
                height: 33
                width: 90
                clip: true
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    id: singertx
                    text: qsTr("听点儿你的音乐")
                    elide: Text.ElideRight
                }
            }
        }
    }
}
