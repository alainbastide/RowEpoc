import QtQuick 2.12
import QtQml 2.2
import QtQuick.Window 2.2
import QtCharts 2.3
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0

import QtGraphicalEffects 1.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4

Item {
    id: root
    width: 200
    height: 200

    property string text: "test"

    
    Rectangle {
        id: rectangle

        width: 200 * root.width / 400
        height: 200 * root.width / 400
        color: "#444444"
        radius: 20 * root.width / 400
        border.color: "#ff0000"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        border.width: 5 * root.width / 400

        Text {
            id: textError1
            x: 10
            y: 10
            width: 184 * root.width / 400
            height: 184 * root.width / 400
            color: "#000000"
            text: root.text
            lineHeight: 1.6
            fontSizeMode: Text.Fit
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 60 * root.width / 400
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            id: textError
            x: 8
            y: 8
            width: 184 * root.width / 400
            height: 184 * root.width / 400
            color: "#ffffff"
            text: root.text
            font.pixelSize: 60 * root.width / 400
            lineHeight: 1.6
            fontSizeMode: Text.Fit
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
