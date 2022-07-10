/* ListenToSomeMusic Player
 * zhangyu:2020051615216
 * hulu:2020051615204
 * zahngyu:2020051615218
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow{
    property alias infoImage:infoImage
    property alias infoTitle:infoTitle
    property alias artist:artist
    property alias album:album

    title: qsTr("曲目信息")
    width:680
    height:450
    visible: false


    RowLayout{
        anchors.fill: parent
        GroupBox{
            implicitWidth: parent.width/2+50
            implicitHeight: parent.height
            title: qsTr("专辑封面")

            Rectangle{
                height: parent.height
                width: parent.width

                Image {
                    id: infoImage
                    width: parent.width
                    height: parent.height
                    cache: false
                    Layout.preferredWidth: parent.width-40
                    Layout.preferredHeight: parent.height-100
                    Layout.alignment: Qt.AlignHCenter
                    fillMode: Image.PreserveAspectCrop
                }
            }
        }

        GroupBox{
            implicitWidth: parent.width/2-10
            implicitHeight: parent.height
            title: qsTr("音频信息")

            ColumnLayout{
                Layout.fillWidth: true
                spacing: 10


                RowLayout{
                    Layout.fillWidth: true
                    Text {
                        text: qsTr("歌   曲：")
                    }
                    Text {
                        id: infoTitle
                        text: ""
                    }
                }

                RowLayout{
                    Layout.fillWidth: true
                    Text {
                        text: qsTr("艺术家：")
                    }
                    Text {
                        id: artist
                        text: ""
                    }
                }

                RowLayout{
                    Layout.fillWidth: true
                    Text {
                        text: qsTr("专   辑：")
                    }
                    Text {
                        id: album
                        text: ""
                    }
                }
            }
        }
    }

}
