import QtQuick
import QtQuick.Dialogs
import QtQuick.Controls as QQC
import QtMultimedia

Rectangle {
    anchors.fill: parent
    property alias mediaplay: mediaplayer

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
        for (var i = 0; i < url.length; i++) {
            if (mediaplayer.source == url[i]) {
                mediaplayer.stop()
                i = i + 1
                if (i == url.length)
                    mediaplayer.source = url[0]
                else
                    mediaplayer.source = url[i]
                mediaplayer.play()
                break
            }
        }
    }
    function lastMedia() {
        //上一首
        for (var i = 0; i < url.length; i++) {
            if (mediaplayer.source == url[i]) {
                mediaplayer.stop()
                i = i - 1
                if (i < 0)
                    mediaplayer.source = url[url.length - 1]
                else
                    mediaplayer.source = url[i]
                mediaplayer.play()
                break
            }
        }
    }
    MediaPlayer {
        id: mediaplayer
        audioOutput: AudioOutput {
            id: audiooutput
            volume: playsong.value / 100
        }

        onPositionChanged: {
            var currentTimeIndex = lyricDialog.currentLine(position)
            lyricDialog.lyricView.currentIndex = currentTimeIndex
            desktopLyricDialog.desktopTextNow = lyricDialog.lyricModel.get(
                        lyricDialog.lyricView.currentIndex).lyric
            if (lyricDialog.lyricView.currentIndex != lyricDialog.cLyric.time.length - 1) {
                desktopLyricDialog.desktopTextNext = lyricDialog.lyricModel.get(
                            lyricDialog.lyricView.currentIndex + 1).lyric
            } else {
                desktopLyricDialog.desktopTextNext = " "
            }
        }
    }
}
