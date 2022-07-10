/* ListenToSomeMusic Player
 * zhangyu:2020051615216
 * hulu:2020051615204
 * zahngyu:2020051615218
*/

import QtQuick
import QtQuick.Controls
import QtMultimedia
import LocalSong 1.0

Item {
    id: playlistqml
    anchors.top: parent.top
    anchors.bottom: currentsong.top
    width: parent.width / 5 - 10
    anchors.left: parent.left
    property alias listmodels: listmodels
    property alias listmode: listmode
    property alias publicview: publicview
    property alias settime: settime
    property int state: 0
    property int firststate: 0
    property var urlss
    property int mod: 0
    property var selecturls
    property int selectindex
    property int sel:0
    property int selc:0
    function loadMusic(source){
        content.mediaplay.source = source
    }

    function setFilesModel() {
        selecturls=arguments[0]
        sel=0
        selc=0
        loadmusic.running=true
    }



    Timer{
        id: loadmusic
        interval: 1
        running: false
        repeat: true
        onTriggered: {
            for(var i=sel;i<=selecturls.length;)
            {
            if(content.mediaplay.mediaStatus!==2||selc===0)
            {
                content.mediaplay.source=selecturls[i]
                localSong.songInfo(selecturls[i])
                selc=1
                break
            }
            else if(content.mediaplay.mediaStatus===2&&selc===1)
            {
                listmodels.append({
                                      "medias": selecturls[i],
                                      "names": selecturls[i].toString().substring(selecturls[i].toString().lastIndexOf("/")+1),
                                      "images": "file:///tmp/cover.jpg",
                                      "songs":content.mediaplay.metaData.stringValue(content.mediaplay.metaData.Title), //localSong.Tags["歌名"],
                                      "singers":localSong.Tags["艺术家"],
                                      "albums": localSong.Tags["专辑"],
                                      "lyrics":"暂无歌词",
                                      "froms":"0"
                                  })
                sel++
                selc=0
                break
            }
            }
            if(sel===selecturls.length)
            {
                loadmusic.running=false
            }
        }

    }

    Rectangle {
        //最外层
        anchors.fill: parent
        border.color: "gray"
        color: Qt.rgba(192 / 255, 192 / 255, 192 / 255, 0.2)
        radius: 4

        Item{
            id:hint
            x:10
            y:200
            z:2
            height: 100
            width: 30
            Text{
                text: "暂无歌单点击可新建歌单"
                TapHandler
                {
                    onTapped: {
                        hint.visible=false
                        listmode.append({
                                            "nomber": mod
                                        })
                        listname.visible = true
                        listname.y = listname.height
                        listname.x = listname.width
                    }
                }

            }
        }


        ListModel {//歌单数据模型
            id: listmode
        }

        ListModel {//歌曲数据模型
            id: listmodels
        }

        TextField {
            id: listname
            visible: false
            x: 250
            y: 10
            z: 5
            placeholderText: qsTr("请输入歌单名称")
            onAccepted: {
                publicview.currentIndex = mod
                publicview.currentItem.listname = text
                mod++
                listname.visible = false
            }
        }

        Button {
            id: newlistbu
            x: publicview.x + publicview.width
            y: publicview.y
            text: "新建"
            onClicked: {
                hint.visible=false
                listmode.append({
                                    "nomber": mod
                                })
                listname.visible = true
                listname.y = listname.height
                listname.x = listname.width
            }
        }
        ListView {
            id: publicview
            height: 350
            width: playlistqml.width - 2
            model: listmode
            ScrollBar.vertical: ScrollBar {
                width: 10
                policy: ScrollBar.AsNeeded
            }

            delegate: SongList {
                height: 288
                width: playlist.width
            }
        }

        Item {
            Timer {
                id: settime
                interval: 520
                running: false
                repeat: true
                onTriggered: {
                    listmodels.clear()
                    running = false
                }
            }

            Text {
                id: time
            }
        }
    }

    LocalSong{
        id:localSong
    }
}
