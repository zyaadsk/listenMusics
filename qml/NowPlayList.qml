import QtQuick
import QtQuick.Controls
Item {
    property alias nowmode: nowmode

    ListModel{
        id:nowmode
    }

    Button {
        id: delets
        height: 20
        width: 60
        visible: false
        text: qsTr("删除歌曲")
        onClicked: {
            nowmode.remove(nowmode.index)
            delets.visible = false
        }
    }

    Rectangle{
        id:nowplaylist
        height: 300
        width: 150
        anchors.left: parent.left+200
        anchors.top: parent.top
        border.color: "red"
        ListView
        {
            id:thislistview
            anchors.fill: parent
            z:6
            model: nowmode
            delegate:
                Rectangle{
                height: 30
                width: 100
                Text {
                    anchors.fill: parent
                    text: index+"   "+name
                    TapHandler {
                        //双击播放
                        onDoubleTapped: {
                            content.mediaplay.stop() //将上一首歌曲结束
                            thislistview.currentIndex = index
                            content.mediaplay.source = media //将资源导入md
                            content.mediaplay.play() //md进行播放的实现
                        }
                    }
                    TapHandler {
                        //右键删除播放列表中的歌曲
                        acceptedButtons: Qt.RightButton
                        onTapped: {
                            delets.visible = true
                            delets.z = 6
                        }
                    }
                }
            }
        }
    }

}
