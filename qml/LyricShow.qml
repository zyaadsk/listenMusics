import QtQuick
import QtQuick.Controls
import QtMultimedia
import QtQuick.Dialogs
import Lyric 1.0

Item {
    property alias cLyric:cLyric
    property alias lyricView:lyricView

    anchors.fill: parent
    //anchors.topMargin: 80

//    anchors.rightMargin: 100

    ListView{
        id:lyricView
        anchors.fill: parent

        model:ListModel{
            id:lyricModel
        }

        delegate:lyricComponent
        spacing: 30
        focus: true

        //固定currentItem的位置
        highlightRangeMode:ListView.ApplyRange
        preferredHighlightBegin:height/3+30
        preferredHighlightEnd: height/3+60

//        highlight: Rectangle{
//            color: "lightGreen"
//        }
    }

    Component{
        id:lyricComponent
        Rectangle {
            id: componentItem
            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.topMargin: 200

            height: 30
//            width: 600
            focus:true

            //color: "blue"

            Text{
                height: 20
                width: 100
                id:lyricText
                text:lyric
                //设置当前歌词的样式
                font.pixelSize: componentItem.ListView.isCurrentItem ? 25 : 18
                color:componentItem.ListView.isCurrentItem ? "red":"black"
               horizontalAlignment: Text.AlignHCenter  //水平居中
               verticalAlignment: Text.AlignVCenter    //垂直居中
            }
        }
    }

    //歌词ListView的model
    function getL(){
        lyricModel.clear();
        for(var i=0;i<cLyric.onelineLyric.length;i++){
            var data = {"lyric":cLyric.onelineLyric[i]};
            lyricModel.append(data);
            console.log(cLyric.onelineLyric[i]);
        }
    }

    //获取当前歌词的索引
    function currentLine(currentTime){
        for(var i=0;i<cLyric.time.length;i++){
            if(currentTime<cLyric.time[i]){
//                console.log(i);

                return i-1;
            }           
        }
        return cLyric.time.length-1;
    }

    Lyric{
        id:cLyric
    }
}
