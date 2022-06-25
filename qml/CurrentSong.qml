import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.rightMargin: 10
    anchors.bottomMargin: 40
    width: 160
    height: 70
    radius: 4
    RowLayout {
        property alias img: img
        property alias songtx: songtx
        property alias singertx: singertx

        id: smallRowlayout
        //        anchors.bottom: parent.bottom
        //        anchors.left: parent.left
        //        anchors.margins: 10
        //        anchors.bottomMargin: 40
        spacing: 5

        Rectangle {
            height: 60
            width: 60
            Image {
                anchors.fill: parent
                anchors.leftMargin: 5
                id: img
                fillMode: Image.PreserveAspectFit
                clip: true
                source: "/resource/background/1.png"
                TapHandler {
                    onTapped: {

                    }
                }
            }
        }

        ColumnLayout {
            id: smallColumnlayout
            //            height: 60
            //            width: 100
            spacing: 4

            Rectangle {
                height: 33
                width: 70
                clip: true
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    id: songtx
                    font.bold: true
                    text: qsTr("听点儿音乐")
                }
            }

            Rectangle {
                height: 33
                width: 90
                clip: true
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    id: singertx
                    text: qsTr("听点儿你的音乐")
                }
            }
        }
    }
}
