//Author: zhangyu
//Data: 2022-06-19
//number: 2020051615216
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ApplicationWindow{
    id:appWindow
    visible: true
    width: 600
    height: 400
    menuBar: MenuBar{
        id:appMenuBar

        Menu{
            title: qsTr("&File")
            MenuItem{action: actions.openAction}
        }

        Menu {
            title: qsTr("&Help")
            contentData:[ actions.contentsAction,
                actions.aboutAction ]
        }
    }

    header: ToolBar {
        id:appToolBar
        RowLayout{
            ToolButton{ action: actions.openAction }
        }
    }


    Actions{
        id:actions
        openAction.onTriggered: dialogs.openFileDialog()
        aboutAction.onTriggered: dialogs.openAboutDialog()
    }


    Dialogs{
        id:dialogs
        fileOpenDialog.onAccepted:{
            content.setFilesModel(fileOpenDialog.selectedFiles)
        }




    }


    Content{
        id:content
        anchors.fill: parent

    }

}
