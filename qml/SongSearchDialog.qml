import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import KuGou 1.0

Rectangle {
    property alias kugou: kugou
    id: songsearchdialog
    width: parent.width / 5 * 4
    anchors.bottom: parent.bottom
    anchors.right: parent.right
    anchors.top: searchBar.bottom
    anchors.margins: 10
    anchors.bottomMargin: 40
    radius: 4
    clip: true

    ColumnLayout {
        anchors.fill: parent

        RowLayout {
            id: searchlistRowlayout
            Layout.fillWidth: true
            Layout.leftMargin: 50
            Layout.bottomMargin: 20
            Layout.alignment: Qt.AlignTop
            anchors.topMargin: 10

            Text {
                Layout.preferredWidth: 120
                Layout.rightMargin: 50
                text: qsTr("歌曲")
            }

            Text {
                Layout.preferredWidth: 120
                Layout.rightMargin: 50
                text: qsTr("歌手")
                font.family: "Noto Rashi Hebrew Thin"
            }

            Text {
                Layout.preferredWidth: 120
                Layout.rightMargin: 50
                text: qsTr("专辑")
            }

            Text {
                Layout.preferredWidth: 120
                Layout.rightMargin: 50
                text: qsTr("时间")
            }
        }

        ListView {
            id: searchlistview
            Layout.preferredWidth: parent.width - Layout.leftMargin
            Layout.leftMargin: 50
            Layout.preferredHeight: parent.height - searchlistRowlayout.height
            spacing: 5
            model: searchlistmodel
            delegate: searchdelegate
            ScrollBar.vertical: ScrollBar {
                width: 10
                policy: ScrollBar.AsNeeded
            }
        }
    }

    ListModel {
        id: searchlistmodel
    }

    Component {
        id: searchdelegate
        Rectangle {
            radius: 4
            width: searchlistview.width - 50
            height: 40
            focus: true
            color: ListView.isCurrentItem ? "lightgrey" : "white"
            clip: true
            RowLayout {
                id: sarchLayout
                anchors.verticalCenter: parent.verticalCenter
                Text {
                    text: song
                    Layout.preferredWidth: 120
                    Layout.rightMargin: 50
                    elide: Text.ElideRight
                }
                Text {
                    text: singer
                    Layout.preferredWidth: 120
                    Layout.rightMargin: 50
                    elide: Text.ElideRight
                }
                Text {
                    text: album
                    Layout.preferredWidth: 120
                    Layout.rightMargin: 50
                    elide: Text.ElideRight
                }
                Text {
                    text: duration
                    Layout.preferredWidth: 120
                    Layout.rightMargin: 50
                }
            }
            TapHandler {
                onTapped: {
                    searchlistview.currentIndex = index
                }
                onDoubleTapped: {

                    kugou.onclickPlay(index)
                }
            }
        }
    }

    KuGou {
        id: kugou
        onAlbumIdChanged: {
            var s, m
            searchlistmodel.clear()
            for (var i = 0; i < songName.length; i++) {
                m = (duration[i] - duration[i] % 60) / 60
                s = duration[i] - m * 60
                if (s >= 0 & s < 10) {
                    searchlistmodel.append({
                                               "song": songName[i],
                                               "singer": singerName[i],
                                               "album": albumName[i],
                                               "duration": m + ":0" + s
                                           })
                } else {
                    searchlistmodel.append({
                                               "song": songName[i],
                                               "singer": singerName[i],
                                               "album": albumName[i],
                                               "duration": m + ":" + s
                                           })
                }
            }
        }
        onUrlChanged: {
            content.mediaplay.source = url
            console.log(url)
            content.mediaplay.play()
            actions.playAction.icon.source = "/resource/image/暂停.png"
            currentsong.img.source = image
            currentsong.songtx.text = song
            currentsong.singertx.text = singer
            rect_round.image.source = image

            lyricDialog.counts = 0
            desktopLyricDialog.counts = 0
            lyricDialog.cLyric.setLyric(lyrics)
            //            console.log(lyrics)
            lyricDialog.cLyric.divideLyrics()
            lyricDialog.getL()
        }
    }
}
