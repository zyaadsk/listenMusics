//Author: zhangyu
//Data: 2022-06-19
//number: 2020051615216
import QtQuick
import QtQuick.Dialogs
import QtQuick.Controls
import QtMultimedia
import QtQuick.Layouts

Item{
    property var wei
    property var nowtime
    property var sumtime
    property var sumtimes

    function setFilesModel(){
        wei=arguments[0]
        console.log(wei)
        for(var i in wei)
        {

            listmodel.append({"musics":wei[i]})
        }
    }

    MediaPlayer{
        id:musicplayer
        //parent:nowtime=position
        audioOutput: AudioOutput {}
        //mediaStatus: "NoMedia"
        onPositionChanged: {
            nowtime=slider.settime(position)





        }
        onDurationChanged: {
            sumtimes=slider.settime(duration)
        }
    }

    ListModel{
        id:listmodel

    }

    ListView{
        id:listview
        anchors.fill: parent
        model:listmodel
        delegate:Rectangle{
            height: 20
            width: parent.width
            Text {
                anchors.fill: parent
                text:musics
            }
            TapHandler{
                onTapped:{
                    console.log(musics)
                    musicplayer.source=musics
                    musicplayer.play()
            }
            }
        }

    }

Row{
    anchors.bottom: parent.bottom
    ToolButton{
        text: "播放"
        onClicked: musicplayer.play()
    }

    ToolButton{
        text:"暂停"
        onClicked: musicplayer.pause()
    }
    ToolButton{
        text:"停止"
        onClicked: musicplayer.stop()
    }
    Text {
        id: timenow
        text: nowtime
    }
    Slider{
        id:slider
        function settime(playTime){
            var m,s,times
            playTime=(playTime-playTime%1000)/1000;
            m=(playTime-playTime%60)/60
            s=playTime-m*60
            if(m>=0&m<10) {
                if(s>=0&s<10) {
                    times="0"+m+":0"+s;
                } else {
                    times="0"+m+":"+s;
                }
            } else {
                if(s>=0&s<10) {
                    times=m+":0"+s;
                } else {
                    times=m+":"+s;
                }
            }
            return times

        }
        from:0
        to:musicplayer.duration
         //stepSize:
         //snapMode:"SnapAlways"
         //position: musicplayer.duration/2
        //value: musicplayer.position
 //       musicplayer.seekable(value)
        onVisualPositionChanged: {
            //visualPosition=value
        }
         onValueChanged: {
             musicplayer.position=value


         }
        onMoved: {
            //musicplayer.seekable= true
            nowtime=slider.settime(musicplayer.position)
            console.log(musicplayer.position)
            console.log(value)
        }

        //visualPosition: musicplayer.position
    }
    Text {
        id: timessum
        text:sumtimes
    }

}
}




















