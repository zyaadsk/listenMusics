/* ListenToSomeMusic Player
 * zhangyu:2020051615216
 * hulu:2020051615204
 * zahngyu:2020051615218
*/

import QtQuick
import QtQuick.Dialogs
import QtQuick.Controls as QQC
import QtMultimedia

Rectangle {
    property alias mediaplay: mediaplayer

    //时间转化
    function getTime(playTime) {
        var m, s
        var time
        playTime = (playTime - playTime % 1000) / 1000
        m = (playTime - playTime % 60) / 60
        s = playTime - m * 60
        if (m >= 0 & m < 10) {
            if (s >= 0 & s < 10) {
                time = "0" + m + ":0" + s
            } else {
                time = "0" + m + ":" + s
            }
        } else {
            if (s >= 0 & s < 10) {
                time = m + ":0" + s
            } else {
                time = m + ":" + s
            }
        }
        return time
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
        for (var i = 0; i <= nowplaylist.nowmode.count; i++) {
            if (mediaplayer.source == nowplaylist.nowmode.get(i).media) {
                mediaplayer.stop()
                i = i + 1
                if (i > nowplaylist.nowmode.count) {
                    mediaplayer.source = nowplaylist.nowmode.get(0).media
                    currentsong.songtx.text = nowplaylist.nowmode.get(0).song
                    currentsong.singertx.text = nowplaylist.nowmode.get(0).singer
                    currentsong.img.source = nowplaylist.nowmode.get(0).image

                    if(nowplaylist.nowmode.get(0).from==1)
                    {
                        lyricDialog.cLyric.setLyric(nowplaylist.nowmode.get(0).lyric)
                        lyricDialog.cLyric.divideLyrics()
                        lyricDialog.getL()
                    }
                    if(nowplaylist.nowmode.get(0).from==0)
                    {
                        lyricDialog.cLyric.getLocalUrl(nowplaylist.nowmode.get(0).media)
                        lyricDialog.cLyric.divideLocalLyric()
                        lyricDialog.getL()
                    }
                } else {
                    mediaplayer.source = nowplaylist.nowmode.get(i).media
                    currentsong.songtx.text = nowplaylist.nowmode.get(i).song
                    currentsong.singertx.text = nowplaylist.nowmode.get(i).singer
                    currentsong.img.source = nowplaylist.nowmode.get(i).image
                    if(nowplaylist.nowmode.get(i).from==1)
                    {
                        lyricDialog.cLyric.setLyric(nowplaylist.nowmode.get(i).lyric)
                        lyricDialog.cLyric.divideLyrics()
                        lyricDialog.getL()
                    }
                    if(nowplaylist.nowmode.get(i).from==0)
                    {
                        lyricDialog.cLyric.getLocalUrl(nowplaylist.nowmode.get(i).media)
                        lyricDialog.cLyric.divideLocalLyric()
                        lyricDialog.getL()
                    }
                }
                mediaplayer.play()
                break
            }
        }
    }
    function lastMedia() {
        //上一首
        for (var j = 0; j <= nowplaylist.nowmode.count; j++) {
            if (mediaplayer.source == nowplaylist.nowmode.get(j).media) {
                mediaplayer.stop()
                j = j - 1
                if (j < 0)
                {
                    mediaplayer.source = nowplaylist.nowmode.get(nowplaylist.nowmode.count - 1).media
                                currentsong.songtx.text = nowplaylist.nowmode.get(nowplaylist.nowmode.count - 1).song
                                currentsong.singertx.text = nowplaylist.nowmode.get(nowplaylist.nowmode.count - 1).singer
                                currentsong.img.source = nowplaylist.nowmode.get(nowplaylist.nowmode.count - 1).image
                                if(nowplaylist.nowmode.get(nowplaylist.nowmode.count - 1).from==1)
                                {
                                    lyricDialog.cLyric.setLyric(nowplaylist.nowmode.get(nowplaylist.nowmode.count - 1).lyric)
                                    lyricDialog.cLyric.divideLyrics()
                                    lyricDialog.getL()
                                }
                                if(nowplaylist.nowmode.get(nowplaylist.nowmode.count - 1).from==0)
                                {
                                    lyricDialog.cLyric.getLocalUrl(nowplaylist.nowmode.get(nowplaylist.nowmode.count - 1).media)
                                    lyricDialog.cLyric.divideLocalLyric()
                                    lyricDialog.getL()
                                }
                }
                else
                                {
                    mediaplayer.source = nowplaylist.nowmode.get(j).media
                                    currentsong.songtx.text = nowplaylist.nowmode.get(j).song
                                    currentsong.singertx.text = nowplaylist.nowmode.get(j).singer
                                    currentsong.img.source = nowplaylist.nowmode.get(j).image
                                    if(nowplaylist.nowmode.get(i).from==1)
                                    {
                                        lyricDialog.cLyric.setLyric(nowplaylist.nowmode.get(j).lyric)
                                        lyricDialog.cLyric.divideLyrics()
                                        lyricDialog.getL()
                                    }
                                    if(nowplaylist.nowmode.get(j).from==0)
                                    {
                                        lyricDialog.cLyric.getLocalUrl(nowplaylist.nowmode.get(j).media)
                                        lyricDialog.cLyric.divideLocalLyric()
                                        lyricDialog.getL()
                                    }
                                }
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
            playsong.nowtimes = getTime(mediaplay.position)
            playsong.tataltimes = content.getTime(content.mediaplay.duration)

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
