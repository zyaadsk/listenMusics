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
    Rectangle{
        anchors.fill: parent
        border.color: "red"
        //color: "gray"
        //opacity: 0.3

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
        }
    }
    ListView{
        id:publicview
        height: 500
        width: playlistqml.width-2
        model:listmode
        delegate:
            SongList
        {
            height: 100
            width: parent.width
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


