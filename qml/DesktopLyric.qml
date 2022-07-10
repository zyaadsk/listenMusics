/* ListenToSomeMusic Player
 * zhangyu:2020051615216
 * hulu:2020051615204
 * zahngyu:2020051615218
*/

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    x: (Screen.desktopAvailableWidth - width) / 2
    y: Screen.desktopAvailableHeight - height

    property alias desktopTextNow: desktoptextNow.text
    property alias desktopTextNext: desktoptextNext.text

    property int counts: 0

    id: root
    width: 800
    height: 150
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint //将窗口无边框 最顶层
    color: Qt.rgba(0, 0, 0, 0)

    //无边框窗口的移动
    MouseArea {
        anchors.fill: parent
        property point clickPos: "0,0"
        onPressed: {
            clickPos = Qt.point(mouse.x, mouse.y)
        }
        onPositionChanged: {
            var delta = Qt.point(mouse.x - clickPos.x, mouse.y - clickPos.y)
            root.x = root.x + delta.x
            root.y = root.y + delta.y
        }
    }

    //鼠标悬停在窗口上的变化
    HoverHandler {
        onHoveredChanged: {
            if (hovered) {
                toolRow.opacity = 1
                root.color = Qt.rgba(0.5, 0.5, 0.5, 0.8)
            }
            if (!hovered) {
                toolRow.opacity = 0
                root.color = Qt.rgba(0, 0, 0, 0)
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent

        RowLayout {
            id: toolRow
            height: 30
            opacity: 0
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            ToolButton {
                action: actions.lastAction
            }
            ToolButton {
                action: actions.playAction
            }
            ToolButton {
                action: actions.nextAction
            }
            ToolButton {
                action: actions.desktopExitAction
            }
        }

        //当前歌词
        Text {
            id: desktoptextNow
            text: ""
            Layout.fillHeight: true
            Layout.fillWidth: true
            font.pixelSize: 40
            color: "red"
        }

        //下一句歌词
        Text {
            id: desktoptextNext
            text: ""
            Layout.alignment: Qt.AlignRight
            color: "black"
            font.pixelSize: 40
        }
    }
}
