import QtQuick
import QtQuick.Controls

Item {
    id: songlists
    //anchors.left: parent.left
    property alias songmode: songmode
    property alias listview: listview
    property int liststat: 1
    property int timestat:1
    property alias listname:headertext.text
    property alias endtime:settime
    property var listsource
    function getmodel() {
        timestat=0
        for (var j = 0; j <= playlist.listmodels.count; j++) {
            songmode.append({
                          "media": playlist.listmodels.get(j).medias,
                                "name": playlist.listmodels.get(j).names,
                                //"lyric":playlist.listmodels.get(j).layrics
                      })
        }
    }
    Rectangle{
        anchors.fill: parent

    Button {
        id: delets
        height: 20
        width: 60
        visible: false
        text: qsTr("删除歌曲")
        onClicked: {
            //location=getlocation()
            //console.log(location)
            songmode.remove(index)
            delets.visible = false
        }
    }

    ListModel {
        id:songmode
    }

    Rectangle {
        id: topitem
        width:playlist.width
        height:300
        border.color: "red"
        Column {
            Row {
                Rectangle{
                    border.color: "gray"
                    height: 15
                    width: topitem.width
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
                                //listview.visible=false
                                //                   addmusic.height=0
                                //getmodel()
                                liststat = 0
                            } else if (liststat == 0) {
                                songlists.height = 300
                                addmusic.visible = true
                                //listview.visible=true
                                //                       addmusic.height=10
                                liststat = 1
                            }
                        }
                        onDoubleTapped: {

                        }
                    }
                }
                }
            }
            Item {
                id: listitem
                height: topitem.height
                width: 100
                ListView {
                    id: listview
                    footer: addmusic
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
                    delegate: /*delegates

                    Component {
                        id: delegates*/
                        //anchors.fill: parent
                        Rectangle {
                            id: rect
                            height: 28
                            border.color: "red"
                            width: 100
                            //color:ListView.isCurrentItem ? "black" : "red"
                            TapHandler {
                                //删除播放列表中的歌曲
                                acceptedButtons: Qt.RightButton
                                onTapped: {
                                    delets.visible = true
                                    delets.z = 3
                                }
                            }
                            TapHandler {
                                //双击播放
                                onDoubleTapped: {
                                    content.mediaplay.stop() //将上一首歌曲结束
                                    listview.currentIndex = index
                                    content.mediaplay.source = media //将资源导入md
                                    //lyricDialog.cLyric.setLyric(lyric)
                                    nowplaylist.nowmode.append({"media":listview.currentIndex.meida,
                                                               "name":listview.currentIndex.name})
                                    content.mediaplay.play() //md进行播放的实现
                                }
                            }
                            Text {
                                id: tx
                                //color: rect.ListView.isCurrentItem ? "black" : "red"
                                anchors.fill: parent
                                text: index + "          " + name //文件路径名
                            }
                        }
                    //}
                }
            }
            Button {
                id: addmusic
                x: listview.x
                y: listview.height
                text: qsTr("添加歌曲")
                onClicked: {
                    if(playlist.state==1)
                    {
                        console.log("网络收藏")
                       publicview.currentIndex = index
                        playlist.settime.running=true
                        songlists.endtime.running=true
                        songlists.endtime.repeat=true
                        playlist.state=0
                        console.log(playlist.state)
                    }
                    else
                    {
                        publicview.currentIndex = index
                        dialogs.openFileDialog()
                        songlists.endtime.running=true
                        songlists.endtime.repeat=true
                    }

                    //listmodels.clear()
                }
            }
        }
    }

    Item {
        Timer {
            id:settime
            interval: 500; running: false; repeat: true
            onTriggered: {
                if(timestat==0)
                {
                    songlists.endtime.running=false
                    songlists.endtime.repeat=false
                    timestat=1
                }
                else
                    if(playlist.listmodels.count!==0)
                {
                    console.log("执行一次")
                    playlist.publicview.currentItem.getmodel()
                }


            }
        }
    }
}
}
