import QtQuick 2.0

Item {
    id: root
    width: parent.width
    height: heightRow
    property int heightRow: 60
    //    property int rowNumber
    property string textDataName: ""
    property string textDataData: ""
    property string textDataUnit: ""

    FontLoader {
        id: digitalFont
        source: "font/digital-7-mono.ttf"
    }

    FontLoader {
        id: trebuchetFont
        source: "font/trebuc.ttf"
    }

    Text {
        id: dataname
        y: 0
        text: textDataName
        anchors.left: root.left
        anchors.leftMargin: 0
        font.bold: true
        width: root.width * 3 / 8
        height: heightRow
        color: "white"
        font.family: trebuchetFont.name
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        font.pixelSize: 26 * root.width / 400
    }
    Text {
        id: dataData
        y: 0
        text: textDataData
        anchors.left: dataname.right
        anchors.leftMargin: 0
        font.bold: false
        width: root.width * 4 / 8
        height: heightRow
        color: "white"
        font.family: digitalFont.name //"Digital-7Mono" //digitalFont //"font/digital-7-mono.ttf" //"Digital-7"
        font.pixelSize: 60 * root.width / 400
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
    }
    Text {
        id: dataUnit
        y: 0
        text: textDataUnit
        anchors.left: dataData.right
        anchors.leftMargin: 0
        font.bold: false
        width: root.width / 8
        height: heightRow
        color: "white"
        font.family: trebuchetFont.name
        font.pixelSize: 26 * root.width / 400
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
    }
}
