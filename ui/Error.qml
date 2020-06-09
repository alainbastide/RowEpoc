import QtQuick 2.0

Item {
    id:root
    width: 200
    height: 200

    property string text:  "test"


    Rectangle {
        id: rectangle


        width: 200
        height: 200
        color: "#444444"
        radius: 20
        border.color: "#ff0000"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        border.width: 5

        Text {
            id: textError1
            x: 10
            y: 10
            width: 184
            height: 184
            color: "#000000"
            text: root.text
            lineHeight: 1.6
            fontSizeMode: Text.Fit
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 60
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            id: textError
            x: 8
            y: 8
            width: 184
            height: 184
            color: "#ffffff"
            text: root.text
            font.pixelSize: 60
            lineHeight: 1.6
            fontSizeMode: Text.Fit
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

    }

}


