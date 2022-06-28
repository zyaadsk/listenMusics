import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    property alias inputField: inputField

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
                lyricDialog.visible = false
                if (inputField.text.length === 0) {
                    songsearchdialog.kugou.search(inputField.placeholderText)
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
