import QtQuick
import QtQuick.Controls
Item {
//    id:songlists
//    property var url
//    property  var urlsit
//    property int  location
//    property var indexs
//    property alias listmodel:lm
//    property alias listview:listview
//    property int liststat:1
//    property int value:leftmargin.mod

//    Button{
//    id:delets
//    height: 20
//    width: 60
//    visible: false
//    text:qsTr("删除歌曲")
//    onClicked: {
//        //location=getlocation()
//        //console.log(location)
//        lm.remove(index)
//        delets.visible=false
//    }
//        }



Rectangle {
    id:topitem
    width: 120
    height: 220
    border.color: "red"
    Column{
        Row{
        Text{
            id:headertext
            height: 15
            width: topitem.width
            //anchors.centerIn:parentw
            text: qsTr("本地音乐")
            horizontalAlignment: Text.AlignHCenter
            TapHandler{
               onTapped: {
                   if(liststat==1)
                   {
                   songlists.height=headertext.height
                   addmusic.visible=false
//                   addmusic.height=0
                       liststat=0
                   }
                   else if(liststat==0)
                   {
                       songlists.height=300
                       addmusic.visible=true
//                       addmusic.height=10
                       liststat=1
                   }
               }
            }
        }

//        Button{
//            id:newlistbu
//            text: "新建"
//            onClicked: {
//                //newlist.source
//                newlist.source="AddSongList.qml"

//            }
//        }
        }
Item{
id:listitem
height: topitem.height
width: 100

ListView {
    id: listview
    footer: addmusic
    anchors.fill: parent
    remove: Transition {
            ParallelAnimation {
                NumberAnimation { property: "opacity"; to: 0; duration: 1000 }
                NumberAnimation { properties: "x,y"; to: 100; duration: 1000 }
            }
    }
    model: ListModel {
        id: lm
    }
    delegate: delegates

        Component {
        id:delegates
        Rectangle {
        id: rect
        height: 28
        border.color: "red"
        width: 100
        //color:ListView.isCurrentItem ? "black" : "red"
        TapHandler{
            //删除播放列表中的歌曲
            acceptedButtons: Qt.RightButton
            onTapped: {
                delets.visible=true
                delets.z=3
            }
            }
        TapHandler{
            acceptedButtons: Qt.LeftButton
            onTapped: mediaplay.source=media
        }

        Text {
            id: tx
            //color: rect.ListView.isCurrentItem ? "black" : "red"
            anchors.fill: parent
            text: index+"          "+media //文件路径名
        }
        TapHandler {
            onTapped: {
                content.mediaplay.stop() //将上一首歌曲结束
                listview.currentIndex=index
                content.mediaplay.source = media //将资源导入md
               content.mediaplay.play() //md进行播放的实现
            }

        }
    }
        }

}
}
Button{
id:addmusic
x:listview.x
y:listview.height
text: qsTr("添加歌曲")
onClicked: {
    dialogs.openFileDialog()
    //value=publicview.currentIndex
    //leftmargin.getlocation()
    listview.model=listmodels
    console.log("当前model是"+publicview.currentIndex)
    //listmodels.clear()
}
}

}
}

}
