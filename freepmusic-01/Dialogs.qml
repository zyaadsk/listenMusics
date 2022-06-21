//Author: zhangyu
//Data: 2022-06-19
//number: 2020051615216
import QtQuick
import QtCore
import QtQuick.Controls
import QtQuick.Dialogs

Item {
    property alias fileOpenDialog: fileOpen

    function openFileDialog() { fileOpen.open(); }
    function openAboutDialog() { about.open(); }

    FileDialog {
        id: fileOpen
        title: "Select some music files"
        currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
        fileMode: FileDialog.OpenFiles
        nameFilters: [ "music files (*.mp3)" ]
    }
    Dialog {
        id: aboutDialog

        title: qsTr("About")

        Label {
            anchors.fill: parent
            text: qsTr("A QML Pictures Viewer\n")
            horizontalAlignment: Text.AlignHCenter
        }
    }

}


