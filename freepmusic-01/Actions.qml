//Author: zhangyu
//Data: 2022-06-19
//number: 2020051615216
import QtQuick
import QtQuick.Controls


Item {
    property alias openAction: open
    property alias aboutAction: about

    Action {
        id: open
        text: qsTr("&Add songs...")
        icon.name: "document-open"
        shortcut: "StandardKey.Open"
    }


    Action {
        id: about
        text: qsTr("&About")
        icon.name: "help-about"
    }

}
