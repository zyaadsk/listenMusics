import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import KuGou 1.0

Rectangle {
    color: Qt.rgba(255, 255, 255, 0.5)
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
            //            Layout.alignment: Qt.AlignTop
            anchors.top: parent.top
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
            id: rectsong
            radius: 4
            width: searchlistview.width - 50
            height: 40
            focus: true
            color: ListView.isCurrentItem ? Qt.rgba(255, 255, 255,
                                                    0.5) : Qt.rgba(255,
                                                                   255, 255, 0)
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
            TapHandler {
                acceptedButtons: Qt.RightButton
                onTapped: {
                    searchlistview.currentIndex = index
                    rightRect.x = eventPoint.scenePosition.x - (songsearchdialog.width / 4 - 15)
                    rightRect.y = eventPoint.scenePosition.y
                            - (searchlistRowlayout.height + searchBar.height + 15)
                    rightRect.visible = true
                    rightRect.index = index
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
            content.mediaplay.play()
            actions.playAction.icon.source = "/resource/image/暂停.png"
            currentsong.img.source = image
            currentsong.songtx.text = song//name
            currentsong.singertx.text = singer//歌手
            rectround.image.source = image

            lyricDialog.counts = 0
            desktopLyricDialog.counts = 0
            lyricDialog.cLyric.setLyric(lyrics)
            lyricDialog.cLyric.divideLyrics()
            lyricDialog.getL()
            nowplaylist.nowmode.append({
                                           "media": content.mediaplay.source,
                                           "name": currentsong.songtx.text,
                                           "image":currentsong.img.source = image,
                                           "songs":currentsong.songtx.text,
                                           "singers":currentsong.singertx.text
                                       })
            playsong.tataltimes = content.getTime(content.mediaplay.duration)
        }
    }

    Rectangle {
        property var index
        id: rightRect
        height: 60
        width: 150
        visible: false
        ColumnLayout {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            Rectangle {
                height: 30
                width: 150
                id: rectPlay
                RowLayout {
                    spacing: 15
                    Rectangle {
                        width: 15
                        height: 15
                        Layout.leftMargin: 10
                        Image {
                            anchors.fill: parent
                            source: "/resource/image/播放.png"
                            fillMode: Image.PreserveAspectFit
                        }
                    }
                    Text {
                        id: play
                        text: qsTr("播放")
                    }
                    TapHandler {
                        onTapped: {
                            kugou.onclickPlay(rightRect.index)
                            eventPoint.accepted = true
                            gesturePolicy: TapHandler.ReleaseWithinBounds
                        }
                    }
                }
                HoverHandler {
                    onHoveredChanged: {
                        if (hovered) {
                            rectPlay.color = "gray"
                        }
                        if (!hovered) {
                            rectPlay.color = "white"
                        }
                    }
                }
            }
            Rectangle {
                id: rectAdd
                height: 30
                width: 150
                RowLayout {
                    spacing: 15
                    Rectangle {
                        width: 15
                        height: 15
                        Layout.leftMargin: 10
                        Image {
                            anchors.fill: parent
                            source: "/resource/image/add.png"
                            fillMode: Image.PreserveAspectFit
                        }
                    }
                    Text {
                        id: add
                        text: qsTr("添加到播放列表")
                        TapHandler {
                            onTapped: {

                            }
                        }
                    }
                }
                HoverHandler {
                    onHoveredChanged: {
                        if (hovered) {
                            rectAdd.color = "gray"
                        }
                        if (!hovered) {
                            rectAdd.color = "white"
                        }
                    }
                }
            }
        }

        HoverHandler {
            onHoveredChanged: {
                if (hovered) {
                    rightRect.visible = true
                }
                if (!hovered) {
                    rightRect.visible = false
                }
            }
        }
    }
}
