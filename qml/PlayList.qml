import QtQuick
import QtQuick.Controls
Item {
    height: 800
    width: 500
    property alias listmodels:listmodels
    property alias listmode :listmode
    property alias publicview:publicview
    property var urlss
    property int mod:1
    function setFilesModel() {
//        urlss = arguments[0] //保存文件路径
        listmodels.clear()
        for (var j in arguments[0]) {
           listmodels.append({
                          "medias": arguments[0][j]
                      })
        }
        //urlss = arguments[0] //保存文件路径

    }

    function getlocation(){
        for(var is=0;;is++)
        {
            if(publicview.delegate.isCurrentItem)
                break
            publicview.currentIndex=is
            console.log("当前所在视图:"+publicview.currentIndex)
        }
    }

    ListModel{
        id:listmode

    }

    ListModel{
        id:listmodels
    }

    TextField{
               id:listname

               onAccepted: {
                   console.log("this:"+text)
                   headertext.text=text
                   listname.visible=false
                   clear()
               }
           }

    Button{
        id:newlistbu
        x:publicview.x+publicview.width
        y:publicview.y
        text: "新建"
        onClicked: {
            mod++
            //newlist.source
            listmode.append({"nomber":mod})


            //publicview.currentIndex=publicview.model-1
            //mod=publicview.model


            //publicview.model[publicview.model].value=publicview.model
            //console.log()
            //publicview.currentIndex++


        }
    }
    ListView{
        id:publicview
        anchors.fill: parent
        model:listmode
        delegate:
            SongList
        {
            //id:liss
            height: 400
            width:300
        //            value: ListView.isCurrentItem ? publicview.currentIndex:value
        }

}

}


