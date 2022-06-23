import QtQuick 2.0
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts

ApplicationWindow {
    id: appWindow
    width: 870
    height: 680
    visible: true
    title: qsTr("听点音乐")

    menuBar: MenuBar {
        id: appMenuBar

        Menu {
            title: qsTr("&File")
            MenuItem {
                action: actions.openFileAction
            }
        }
    }

    RowLayout {
        id: playRowlayout

        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.rightMargin: 20
        ToolButton {
            action: actions.lastAction
            text: qsTr("")
        }
        ToolButton {
            action: actions.playAction
            text: qsTr("")
        }
        ToolButton {
            action: actions.nextAction
            text: qsTr("")
        }
        Slider {
            id: slider
        }
    }

    RowLayout {
        id: searchRowlayout

        anchors.top: parent.top
        anchors.right: parent.right
        anchors.rightMargin: 10
        spacing: 20
        TextField {
            id: inputField
            focus: true
            background: Rectangle {
                implicitHeight: 20
                implicitWidth: 200
                border.color: "gray"
            }
            placeholderText: qsTr("搜一搜歌曲")
            Keys.onPressed: {
                if (event.key === Qt.Key_Return) {
                    songsearchdialog.visible = true
                    if (inputField.text.length === 0) {
                        songsearchdialog.kugou.search(
                                    inputField.placeholderText)
                    } else {
                        songsearchdialog.kugou.search(inputField.text)
                    }
                }
            }
        }

        ToolButton {
            action: actions.searchAction
            text: qsTr("")
        }
    }

    Actions {
        id: actions
        openFileAction.onTriggered: dialogs.openFileDialog()
        aboutAction.onTriggered: dialogs.openaboutDialog()
        playAction.onTriggered: {
            if (playAction.icon.source == "/resource/image/播放.png")
                content.pauseMedia()
            else
                content.playMedia()
        }
        nextAction.onTriggered: content.nextMedia()
        lastAction.onTriggered: content.lastMedia()
        searchAction.onTriggered: {
            songsearchdialog.visible = true
            if (inputField.text.length === 0) {
                songsearchdialog.kugou.search(inputField.placeholderText)
            } else {
                songsearchdialog.kugou.search(inputField.text)
            }
        }
    }

    SongSearchDialog {
        id: songsearchdialog
        visible: false
    }

    Dialogs {
        id: dialogs
        fileOpenDialog.onAccepted: content.setFilesModel(
                                       fileOpenDialog.selectedFiles)
    }

    Content {
        id: content
        anchors.fill: parent
        z: -1
    }
}
