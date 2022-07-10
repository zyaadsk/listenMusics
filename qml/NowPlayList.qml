/* ListenToSomeMusic Player
 * zhangyu:2020051615216
 * hulu:2020051615204
 * zahngyu:2020051615218
*/

import QtQuick
import QtQuick.Controls

Rectangle {
    z:5
    property alias nowmode: nowmode
    property alias nowlistview: thislistview
    property alias nowPlaylistRec: nowPlaylistRec
    property alias recentRecHovered: recentRecHovered

    id: nowPlaylistRec

    width: 200
    height: 400
    anchors.right: parent.right
    anchors.bottomMargin: 27
    anchors.bottom: parent.bottom

    //鼠标悬停时最近播放列表显示，鼠标移开，不显示
    HoverHandler {
        id: recentRecHovered
        onHoveredChanged: {
            if (hovered) {
                nowPlaylistRec.visible = true
            }
            if (!hovered) {
                nowPlaylistRec.visible = false
            }
        }
    }

    ListModel {
        id: nowmode
    }

    Button {
        id: delets
        height: 20
        width: 60
        visible: false
        text: qsTr("删除歌曲")
        onClicked: {
            nowmode.remove(nowmode.index)
            delets.visible = false
            delets.x = eventPoint.scenePosition.x
            delets.y = eventPoint.scenePosition.y
        }
    }

    Rectangle {
        height: 300
        width: 150
        anchors.left: parent.left + 200
        anchors.top: parent.top
        ListView {
            id: thislistview
            anchors.fill: parent
            model: nowmode
            delegate: Rectangle {
                height: 30
                width: 100
                color: ListView.isCurrentItem ? Qt.rgba(192 / 255, 192 / 255,
                                                        192 / 255,
                                                        1) : Qt.rgba(255, 255,
                                                                     255, 0)
                Text {
                    anchors.fill: parent
                    elide: Text.ElideRight
                    text: index+1 + "   " + name
                    TapHandler {
                        //双击播放
                        onDoubleTapped: {
                            content.mediaplay.stop() //将上一首歌曲结束
                            thislistview.currentIndex = index
                            content.mediaplay.source = media //将资源导入md
                            currentsong.songtx.text = song
                            currentsong.singertx.text = singer
                            currentsong.img.source = image
                            rectround.image.source=image
                            //本地音乐歌词解析
                            if(from==0)
                            {
                            lyricDialog.cLyric.getLocalUrl(media)
                            lyricDialog.cLyric.divideLocalLyric()
                            lyricDialog.getL()
                        }
                            //网络歌词解析
                            if(from==1)
                            {
                                lyricDialog.cLyric.setLyric(lyric)
                                lyricDialog.cLyric.divideLyrics()
                                lyricDialog.getL()

                            }
                            content.mediaplay.play() //md进行播放的实现
                            playsong.tataltimes = content.getTime(
                                        content.mediaplay.duration)

                        }
                    }

                    TapHandler {
                        //右键删除播放列表中的歌曲
                        acceptedButtons: Qt.RightButton
                        onTapped: {
                            delets.visible = true
                            delets.z = 6
                        }
                    }
                }
            }
        }
    }
}
