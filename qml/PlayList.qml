import QtQuick
import QtQuick.Controls
Item {
    id:playlistqml
    anchors.top:parent.top
    anchors.bottom:currentsong.top
    width: parent.width/5-10
    anchors.left: parent.left
    property alias listmodels:listmodels
    property alias listmode :listmode
    property alias publicview:publicview
    property alias settime:settime
    property int state:0
    property var urlss
    property int mod:1
    function setFilesModel() {
        for (var j in arguments[0]) {
            content.mediaplay.source=arguments[0][j]
           listmodels.append({
                          "medias": arguments[0][j],
                                 "names":arguments[0][j].toString(),
                                // "lyric":"abc"
                      })
        }
    }

    function getlocation(){
        for(var is=0;;is++)
        {
            if(publicview.delegate.isCurrentItem)
                break
            publicview.currentIndex=is
            console.log("当前所在视图:"+publicview.currentIndex)
        }
    }
<<<<<<< HEAD
    Rectangle{
        anchors.fill: parent
        border.color: "red"
        //color: "gray"
        //opacity: 0.3
=======
    Rectangle{//最外层
        anchors.fill: parent
        border.color: "red"
       color: Qt.rgba(192/255,192/255,192/255,0.2)
        //opacity: 0.08
>>>>>>> b3c40b0 (完成了歌单的删除创建和添加及播放列表，和上一首下一首的切换及歌曲信息的保存，)

    ListModel{
        id:listmode

    }

    ListModel{
        id:listmodels

    }

    TextField{
               id:listname
               visible: false
               x:250
               y:10
               z:5
               placeholderText: qsTr("请输入歌单名称")
               //text: "????"
               onAccepted: {
                   publicview.currentItem.listname=text
                   listname.visible=false
                   //clear()
                   //visible=false
               }
           }

    Button{
        id:newlistbu
        x:publicview.x+publicview.width
        y:publicview.y
        text: "新建"
        onClicked: {
            mod++
            listmode.append({"nomber":mod})
            listname.visible=true
<<<<<<< HEAD
=======
            listname.y=listname.height
            listname.x=listname.width
>>>>>>> b3c40b0 (完成了歌单的删除创建和添加及播放列表，和上一首下一首的切换及歌曲信息的保存，)
        }
    }
    ListView{
        id:publicview
<<<<<<< HEAD
        height: 500
=======
        height: 350
>>>>>>> b3c40b0 (完成了歌单的删除创建和添加及播放列表，和上一首下一首的切换及歌曲信息的保存，)
        width: playlistqml.width-2
        model:listmode
        ScrollBar.vertical:ScrollBar{
            width: 10
            policy: ScrollBar.AsNeeded
        }

        delegate:
            SongList
        {
<<<<<<< HEAD
            height: 100
            width: parent.width
=======
            height: 288
            width:playlist.width
>>>>>>> b3c40b0 (完成了歌单的删除创建和添加及播放列表，和上一首下一首的切换及歌曲信息的保存，)
        }

}

    Item {
        Timer {
            id:settime
            interval: 520; running: false; repeat: true
            onTriggered: {
                listmodels.clear()
                running=false
            }
        }

        Text { id: time }
    }

}
}


