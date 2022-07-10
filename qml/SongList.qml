/* ListenToSomeMusic Player
 * zhangyu:2020051615216
 * hulu:2020051615204
 * zahngyu:2020051615218
*/

import QtQuick
import QtQuick.Controls
import QtMultimedia
Rectangle {
    id: songlists
    color: Qt.rgba(192 / 255, 192 / 255, 192 / 255, 0.2)
    property alias songmode: songmode
    property alias listview: listview
    property int liststat: 1
    property int timestat: 1
    property alias listname: headertext.text
    property alias endtime: settime
    property var listsource
    property var remove
    function getmodel() {
        timestat = 0
        for (var j = 0; j <= playlist.listmodels.count; j++) {
            songmode.append({
                                "media": playlist.listmodels.get(j).medias,
                                "name": playlist.listmodels.get(j).names,
                                "image": playlist.listmodels.get(j).images,
                                "song": playlist.listmodels.get(j).songs,
                                "singer": playlist.listmodels.get(j).singers,
                                "lyric":playlist.listmodels.get(j).lyrics,
                                "from":playlist.listmodels.get(j).froms,
                            })
        }
    }
    Rectangle {
        anchors.fill: parent
        border.color: "black"
        color: Qt.rgba(192 / 255, 192 / 255, 192 / 255, 0.2)

        Rectangle{
            id:delets
            height: 42
            width: 90
            visible: false
            Column{
        Button {
            id: deletmusic
            height: 20
            width: 90
            text: qsTr("删除歌曲")
            onClicked: {
                songmode.remove(remove)
                delets.visible = false
            }
        }
        Button {
            id: musicdate
            height: 20
            width: 90
            text: qsTr("查看歌曲信息")
            onClicked: {
                songInformation.visible = true
                delets.visible = false
            }
        }
            }
        }
        Button {
            id: deletlist
            height: 20
            width: 60
            visible: false
            text: qsTr("删除歌单")
            onClicked: {
                playlist.listmode.remove(remove)
                deletlist.visible = false
            }
        }

        ListModel {
            id: songmode
        }

        Rectangle {
            id: topitem
            width: playlist.width
            height: 250
            border.color: "silver"
            Column {
                Rectangle {
                    id: headers
                    height: 20
                    width: topitem.width
                    border.color: "gray"
                    Text {
                        id: headertext
                        anchors.fill: parent
                        //anchors.centerIn:parentw
                        text: qsTr("本地音乐")
                        horizontalAlignment: Text.AlignHCenter
                        TapHandler {
                            onTapped: {
                                if (liststat == 1) {
                                    songlists.height = headertext.height
                                    addmusic.visible = false
                                    listview.visible = false
                                    liststat = 0
                                } else if (liststat == 0) {
                                    songlists.height = 300
                                    addmusic.visible = true
                                    listview.visible = true
                                    liststat = 1
                                }
                            }
                            onDoubleTapped: {

                            }
                        }
                        TapHandler {
                            //删除歌单
                            acceptedButtons: Qt.RightButton
                            onTapped: {
                                remove = listmode.index
                                //publicview.currentIndex=remove
                                console.log("删除当前歌单：" + remove)
                                deletlist.visible = true
                                deletlist.z = 3
                                deletlist.x = eventPoint.scenePosition.x
                                deletlist.y = eventPoint.scenePosition.y
                            }
                        }
                    }
                }

                width: topitem.width
                Rectangle {
                    id: listitem
                    color: Qt.rgba(192 / 255, 192 / 255, 192 / 255, 0.09)
                    height: topitem.height - headers.height
                    width: topitem.width
                    ListView {
                        id: listview
                        footer: addmusic
                        width: 100
                        height: 300
                        remove: Transition {
                            ParallelAnimation {
                                NumberAnimation {
                                    property: "opacity"
                                    to: 0
                                    duration: 1000
                                }
                                NumberAnimation {
                                    properties: "x,y"
                                    to: 100
                                    duration: 1000
                                }
                            }
                        }
                        model: songmode
                        delegate: delegates

                        Component {
                            id: delegates
                            Rectangle {
                                id: rect
                                height: 28
                                width: topitem.width - 2
                                color: ListView.isCurrentItem ? Qt.rgba(
                                                                    192 / 255,
                                                                    192 / 255,
                                                                    192 / 255,
                                                                    1) : Qt.rgba(
                                                                    255,
                                                                    255, 255, 0)
                                TapHandler {
                                    //删除播放列表中的歌曲/查看歌曲信息
                                    acceptedButtons: Qt.RightButton
                                    onTapped: {
                                        remove = index
                                        delets.visible = true
                                        listview.currentIndex = index
                                        songInformation.infoImage.source = ""
                                        songInformation.infoImage.source = image
                                        songInformation.infoTitle.text = song
                                        songInformation.artist.text = singer
//                                        songInformation.album.text = album
                                        delets.z = 4
                                        delets.x = eventPoint.scenePosition.x
                                        delets.y = eventPoint.scenePosition.y
                                    }
                                }
                                TapHandler {
                                    //双击播放
                                    onDoubleTapped: {
                                        actions.playAction.icon.source = "/resource/image/暂停.png"
                                        listview.currentIndex = index
                                        content.mediaplay.stop() //将上一首歌曲结束
                                        content.mediaplay.source = media
                                        currentsong.songtx.text = song
                                        currentsong.singertx.text = singer
                                        currentsong.img.source = image
                                        rectround.image.source=image
                                        content.mediaplay.stop() //将上一首歌曲结束
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
                                        nowplaylist.nowmode.append({
                                                                       "media": media,
                                                                       "name": name,
                                                                       "image":image,
                                                                       "song": song,
                                                                       "singer":singer,
                                                                       "lyric":lyric,

                                                                   })
                                        content.mediaplay.play() //md进行播放的实现
                                    }

                                }
                                Text {
                                    id: tx
                                    anchors.fill: parent
                                    elide: Text.ElideRight
                                    text: index+1 + "    " + name //文件路径名
                                }
                            }
                        }
                    }
                }
                Rectangle {
                    id: addmusic
                    height: 30
                    width: playlist.width
                    anchors.bottom: songlists.bottom
                    Button {
                        anchors.fill: parent
                        text: qsTr("添加歌曲")
                        onClicked: {
                            if (playlist.state == 1) {
                                console.log("网络收藏")
                                publicview.currentIndex = index
                                playlist.settime.running = true
                                songlists.endtime.running = true
                                songlists.endtime.repeat = true
                                playlist.state = 0
                                console.log(playlist.state)
                            } else {
                                publicview.currentIndex = index
                                dialogs.openFileDialog()
                                songlists.endtime.running = true
                                songlists.endtime.repeat = true
                            }
                        }
                    }
                }
            }
        }

        Item {
            Timer {
                id: settime
                interval: 500
                running: false
                repeat: true
                onTriggered: {
                    if (timestat == 0) {
                        songlists.endtime.running = false
                        songlists.endtime.repeat = false
                        timestat = 1
                    } else if (playlist.listmodels.count !== 0) {
                        console.log("执行一次")
                        playlist.publicview.currentItem.getmodel()
                    }
                }
            }
        }
    }
}
