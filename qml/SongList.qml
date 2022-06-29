import QtQuick
import QtQuick.Controls

Rectangle {
    id: songlists
    color: Qt.rgba(192 / 255, 192 / 255, 192 / 255, 0.2)
    //width: playlist.width
    //anchors.left: parent.left
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
                                "singer": playlist.listmodels.get(j).singers
                                //"lyric":playlist.listmodels.get(j).layrics
                            })
        }
    }
    Rectangle {
        anchors.fill: parent
        border.color: "black"
        color: Qt.rgba(192 / 255, 192 / 255, 192 / 255, 0.2)

        Button {
            id: deletmusic
            height: 20
            width: 60
            visible: false
            text: qsTr("删除歌曲")
            onClicked: {
                songmode.remove(remove)
                deletmusic.visible = false
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
                                    //listview.visible=false
                                    //                   addmusic.height=0
                                    //getmodel()
                                    liststat = 0
                                } else if (liststat == 0) {
                                    songlists.height = 300
                                    addmusic.visible = true
                                    listview.visible = true
                                    //listview.visible=true
                                    //                       addmusic.height=10
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
                    //anchors.fill: parent
                    height: topitem.height - headers.height
                    width: topitem.width
                    ListView {
                        id: listview
                        footer: addmusic

                        //header:headers
                        width: 100
                        height: 300

                        //anchors.fill: parent
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
                                //color:ListView.isCurrentItem ? "black" : "red"
                                //clip: true
                                TapHandler {
                                    //删除播放列表中的歌曲
                                    acceptedButtons: Qt.RightButton
                                    onTapped: {
                                        remove = index
                                        console.log("删除当前：" + index)
                                        deletmusic.visible = true
                                        deletmusic.z = 3
                                        deletmusic.x = eventPoint.scenePosition.x
                                        deletmusic.y = eventPoint.scenePosition.y
                                    }
                                }
                                TapHandler {
                                    //双击播放
                                    onDoubleTapped: {
                                        content.mediaplay.stop() //将上一首歌曲结束
                                        listview.currentIndex = index
                                        content.mediaplay.source = media
                                        currentsong.songtx.text = song
                                        currentsong.singertx.text = singer
                                        //lyricDialog.cLyric.setLyric(lyric)
                                        currentsong.img.source = image
                                        nowplaylist.nowmode.append({
                                                                       "media": listview.currentIndex.meida,
                                                                       "name": listview.currentIndex.name
                                                                   })
                                        console.log("当前的音乐长：" + content.mediaplay.duration)
                                        content.mediaplay.play() //md进行播放的实现
                                        //                                    playsong.tataltimes=content.getTime(content.mediaplay.duration)
                                        //                                   console.log("当前的音乐长："+content.mediaplay.duration)
                                    }
                                }
                                Text {
                                    id: tx
                                    //color: rect.ListView.isCurrentItem ? "black" : "red"
                                    anchors.fill: parent
                                    elide: Text.ElideRight
                                    text: index + "    " + name //文件路径名
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

                            //listmodels.clear()
                        }
                    }
                }
                //}
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
