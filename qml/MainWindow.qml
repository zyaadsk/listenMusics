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

    Content {
        id: content
        anchors.fill: parent
    }

    RowLayout {
        id: playRowlayout

        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.rightMargin: 20
        ToolButton{
            action: actions.lyricAction
        }

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

    Actions {
        id: actions
    }

    SearchBar {
        id: searchRowlayout
    }

    SongSearchDialog {
        id: songsearchdialog
        visible: false
    }

    LyricShow{
        id:lyricDialog
        anchors.fill:parent
        visible:false
    }

    Dialogs {
        id: dialogs
    }

    RowLayout {
        id: smallRowlayout
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.margins: 10
        anchors.bottomMargin: 40
        spacing: 10

        Rectangle {
            height: 60
            width: 60
            Image {
                anchors.fill: parent
                id: img
                fillMode: Image.PreserveAspectFit
                clip: true
                TapHandler {
                    onTapped: {

                    }
                }
            }
        }

        ColumnLayout {
            id: smallColumnlayout
            height: 60
            width: 100
            spacing: 4

            Rectangle {
                height: 33
                width: 100
                clip: true
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    id: songtx
                    font.bold: true
                }
            }

            Rectangle {
                height: 33
                width: 120
                clip: true
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    id: singertx
                }
            }
        }
    }
}
