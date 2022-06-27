import QtQuick 2.0
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts

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

    Rectangle {
        anchors.fill: parent
        color: "red"
        opacity: 0.5
    }

    Content {
        id: content
    }

    PlayList{
        id:leftmargin
    }

    PlaySong {
        id: playsong
    }

    Actions {
        id: actions
    }

    SongList{
        id:x
        visible:false
    }

    SearchBar {
        id: searchBar
    }

    SongSearchDialog {
        id: songsearchdialog
        visible: false
    }

    Dialogs {
        id: dialogs
    }

    CurrentSong {
        id: currentsong
    }
}
