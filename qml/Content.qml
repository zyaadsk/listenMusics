import QtQuick
import QtQuick.Dialogs
import QtQuick.Controls as QQC
import QtMultimedia

Rectangle {
    anchors.fill: parent
    property alias mediaplay: mediaplayer
    property var url



    //时间转化
    function getTime(playTime) {
        var m,s;
        var time;
        playTime=(playTime-playTime%1000)/1000;
        m=(playTime-playTime%60)/60
        s=playTime-m*60
        if(m>=0&m<10) {
            if(s>=0&s<10) {
                time="0"+m+":0"+s;
            } else {
                time="0"+m+":"+s;
            }
        } else {
            if(s>=0&s<10) {
                time=m+":0"+s;
            } else {
                time=m+":"+s;
            }
        }
        return time;
    }

    function playMedia() {
        //播放功能
        mediaplayer.play()
    }
    function pauseMedia() {
        //暂停功能
        mediaplayer.pause()
    }
    function stopMedia() {
        //停止功能
        mediaplayer.stop()
    }
    function nextMedia() {
        //下一首
        for (var i = 0; i <=nowplaylist.nowmode.count; i++) {
            if (mediaplayer.source == nowplaylist.nowmode.get(i).media) {
                mediaplayer.stop()
                i = i + 1
                if (i > nowplaylist.nowmode.count)
                {
                    mediaplayer.source = nowplaylist.nowmode.get(0).media
                }
                else
                {
                    mediaplayer.source =nowplaylist.nowmode.get(i).media
                }
                mediaplayer.play()
                break
            }
        }
    }
    function lastMedia() {
        //上一首
        for (var j = 0; j <=nowplaylist.nowmode.count; j++) {
            if (mediaplayer.source == nowplaylist.nowmode.get(j)) {
                mediaplayer.stop()
                j = j - 1
                if (i < 0)
                    mediaplayer.source = nowplaylist.nowmode.get(nowplaylist.nowmode.count-1).media
                else
                    mediaplayer.source = nowplaylist.nowmode.get(j).media
                mediaplayer.play()
                break
            }
        }
    }
    MediaPlayer {
        id: mediaplayer
        audioOutput: AudioOutput {}

        onPositionChanged: {
<<<<<<< HEAD
            var currentTimeIndex=lyricDialog.currentLine(position)
=======
            playsong.nowtimes=getTime(mediaplay.position)
            playsong.tataltimes=content.getTime(content.mediaplay.duration)

            var currentTimeIndex = lyricDialog.currentLine(position)
>>>>>>> b3c40b0 (完成了歌单的删除创建和添加及播放列表，和上一首下一首的切换及歌曲信息的保存，)
            lyricDialog.lyricView.currentIndex = currentTimeIndex
            //desktopLyricDialog.desktopTextNow=lyricDialog.lyricModel.get(lyricDialog.lyricView.currentIndex).lyric
            if(lyricDialog.lyricView.currentIndex != lyricDialog.cLyric.time.length-1){
                desktopLyricDialog.desktopTextNext=lyricDialog.lyricModel.get(lyricDialog.lyricView.currentIndex+1).lyric
            }else{
                desktopLyricDialog.desktopTextNext=" "
            }
        }
    }
}
