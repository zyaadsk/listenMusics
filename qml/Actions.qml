import QtQuick 2.0
import QtQuick.Controls

Item {
    property alias searchAction: search
    property alias nextAction: next
    property alias lastAction: last
    property alias playAction: play
    property alias openFileAction: openFile
    property alias aboutAction: about
    property alias desktopExitAction: desktopExit

    Action {
        id: search
        text: qsTr("搜索歌曲")
        icon.source: "/resource/image/查找.png"
        onTriggered: {
            songsearchdialog.visible = true
            lyricDialog.visible = false
            if (searchBar.inputField.text.length === 0) {
                songsearchdialog.kugou.search(
                            searchBar.inputField.placeholderText)
            } else {
                songsearchdialog.kugou.search(searchBar.inputField.text)
            }
        }
    }
    Action {
        id: next
        text: qsTr("下一首")
        icon.source: "/resource/image/下一曲.png"
        onTriggered: content.nextMedia()
    }
    Action {
        id: last
        text: qsTr("上一首")
        icon.source: "/resource/image/上一曲.png"
        onTriggered: content.lastMedia()
    }
    Action {
        id: play
        text: qsTr("播放")
        icon.source: "/resource/image/播放.png"
        onTriggered: {
            if (icon.source == "/resource/image/播放.png") {
                content.playMedia()
                icon.source = "/resource/image/暂停.png"
            } else {
                icon.source = "/resource/image/播放.png"
                content.pauseMedia()
            }
        }
    }
    Action {
        id: openFile
        text: qsTr("打开文件")
        onTriggered: dialogs.openFileDialog()
    }
    Action {
        id: about
        text: qsTr("&About")
        icon.name: "help-about"
        onTriggered: dialogs.openaboutDialog()
    }
    Action {
        id: desktopExit
        icon.source: "/resource/image/close.png"
        onTriggered: {
            desktopLyricDialog.visible = false
        }
    }
}
