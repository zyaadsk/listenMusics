import QtQuick 2.0
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

ApplicationWindow {
    id: appWindow
    width: 870
    height: 680
    visible: true
    title: qsTr("听点儿音乐")

    menuBar: MenuBar {
        id: appMenuBar

        Menu {
            title: qsTr("&File")
            MenuItem {
                action: actions.openFileAction
            }
        }
    }

    Spectrogram {
        id: spectrogram
    }

    Content {
        id: content
    }

    PlayList {
        id: playlist
<<<<<<< HEAD
=======

>>>>>>> b3c40b0 (完成了歌单的删除创建和添加及播放列表，和上一首下一首的切换及歌曲信息的保存，)
    }


    PlaySong {
        id: playsong
    }

    NowPlayList{
        id:nowplaylist
        visible:false
    }

    Actions {
        id: actions
    }

    SearchBar {
        id: searchBar
    }

    SongSearchDialog {
        id: songsearchdialog
        visible: false
    }

    LyricShow {
        id: lyricDialog
        anchors.fill: parent
        visible: false
    }

    DesktopLyric {
        id: desktopLyricDialog
        visible: false
    }

    Dialogs {
        id: dialogs
    }

    CurrentSong {
        id: currentsong
    }

    Rectangle {
        property alias image: image
        id: rect_round
        width: 300
        height: 300
        radius: 150
        anchors.top: searchBar.bottom
        anchors.right: parent.right
        anchors.topMargin: 60
        anchors.rightMargin: 100
        color: "black"
        Image {
            id: image
            smooth: true
            visible: false
            anchors.fill: parent
            sourceSize: Qt.size(parent.size, parent.size)
            antialiasing: true
            NumberAnimation {
                running: rect_round
                loops: Animation.Infinite
                target: rect_round
                from: 0
                to: 360
                property: "rotation"
                duration: 10000
            }
        }
        Rectangle {
            id: mask
            color: "black"
            anchors.fill: parent
            radius: 150
            visible: false
            antialiasing: true
            smooth: true
        }

        OpacityMask {
            id: mask_iamge
            anchors.fill: mask
            source: image
            maskSource: mask
            visible: true
            antialiasing: true
        }
    }
}
