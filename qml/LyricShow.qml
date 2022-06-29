import QtQuick
import QtQuick.Controls
import QtMultimedia
import QtQuick.Dialogs
import Lyric 1.0

Item {
    property alias cLyric: cLyric
    property alias lyricView: lyricView
    property alias lyricModel: lyricModel
    property int counts: 0

    id: root

    anchors.fill: parent
    ListView {
        id: lyricView
        anchors.fill: parent
        anchors.topMargin: 100
        anchors.bottomMargin: 80

        model: ListModel {
            id: lyricModel
        }

        delegate: lyricComponent
        spacing: 30
        focus: true

        //固定currentItem的位置
        highlightRangeMode: ListView.ApplyRange
        preferredHighlightBegin: height / 3 + 30
        preferredHighlightEnd: height / 3 + 60
    }

    Component {
        id: lyricComponent
        Rectangle {
            id: componentItem
            anchors.right: parent.right
            anchors.rightMargin: 60
            height: 30
            width: 400
            clip: true

            Text {
                id: lyricText
                height: 20
                anchors.centerIn: parent
                text: lyric
                //设置当前歌词的样式
                font.pixelSize: componentItem.ListView.isCurrentItem ? 25 : 18
                color: componentItem.ListView.isCurrentItem ? "red" : "black"
                horizontalAlignment: Text.AlignHCenter //水平居中
                verticalAlignment: Text.AlignVCenter //垂直居中
                elide: Text.ElideRight
            }
        }
    }

    //歌词ListView的model
    function getL() {
        lyricModel.clear()
        for (var i = 0; i < cLyric.onelineLyric.length; i++) {
            var data = {
                "lyric": cLyric.onelineLyric[i]
            }
            lyricModel.append(data)
            //            console.log(cLyric.onelineLyric[i]);
        }
    }

    //获取当前歌词的索引
    function currentLine(currentTime) {
        for (var i = 0; i < cLyric.time.length; i++) {
            if (currentTime < cLyric.time[i]) {
                //                console.log(i);
                return i - 1
            }
        }
        return cLyric.time.length - 1
    }

    Lyric {
        id: cLyric
    }
}
