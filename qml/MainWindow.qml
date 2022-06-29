import QtQuick 2.0
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Particles

ApplicationWindow {
    id: appWindow
    width: 870
    height: 680
    visible: true
    title: qsTr("听点儿音乐")

    background: Rectangle {
        opacity: 0.5
        id: root
        anchors.fill: parent
        color: "gray"
        ParticleSystem {
            id: particleSystem
        } //粒子系统
        Emitter {
            //发射器
            id: emitter
            anchors.centerIn: parent

            system: particleSystem
            width: parent.width
            height: parent.width

            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter

            emitRate: 10 //发射速率（每秒发射多少个粒子，默认值为10）
            lifeSpan: 2000 //粒子生命周期，单位毫秒（默认值为1000）
            lifeSpanVariation: 500 //粒子生命周期误差区间
            size: 50 //粒子初始大小
            endSize: 80 //粒子生命周期结束时大小（默认值为-1）
            velocity: PointDirection {
                //点方向
                x: 100
                y: 100
                xVariation: 100
                yVariation: 100 / 6
            }
        }
        //粒子画笔ParticlePainter：ParticlePainter的子类包括：ItemParticle、ImageParticle和CustomParticle。
        ImageParticle {
            source: "/resource/image/原唱.png"
            system: particleSystem
            color: "#FFD700"
            colorVariation: 0.8
            rotation: 15 //顺时针旋转
            rotationVariation: 5 //旋转误差
            rotationVelocity: 45 //旋转速度
            rotationVelocityVariation: 15
            entryEffect: ImageParticle.Fade //进入效果
        }
    }
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
    }

    PlayList {
        id: playlist
    }

    PlaySong {
        id: playsong
    }

    NowPlayList{
        id:nowplaylist
        visible:false
    }

    Actions {
        id: actions
    }

    SearchBar {
        id: searchBar
    }

    SongSearchDialog {
        id: songsearchdialog
        visible: false
    }

    LyricShow {
        id: lyricDialog
        anchors.fill: parent
        visible: false
    }

    DesktopLyric {
        id: desktopLyricDialog
        visible: false
    }

    Dialogs {
        id: dialogs
    }

    CurrentSong {
        id: currentsong
    }

    RectRound {
        id: rectround
        visible: false
    }
}
