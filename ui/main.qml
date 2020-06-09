import QtQuick 2.12
import QtQml 2.2
import QtQuick.Window 2.2
import QtCharts 2.3
import QtQuick.Controls 2.0

import QtGraphicalEffects 1.12
import QtQuick.Controls.Styles 1.4

import "js/Functions.js" as ChartsFunctions


Window {
    id: root

    width: 800
    height: 400
    color: "#1c1c1c"
    visible: true
    title: "RowEPOC"



    onWidthChanged: {
        root.height = root.width
        root.width = root.height
    }

    onHeightChanged: {
        root.height = root.width
        root.width = root.height
    }


    Timer {
        id: testRefreshTimer
        interval: 200
        running: true
        repeat: true
        onTriggered: {


            if(HR.ergsProp === 1) {


                HR.setAge(45)
                HR.computeHRMax()
                HR.computeHRZones()

                noErg.visible = false

                if(actualHeartRateProp==0) {
                    noHRBelt.visible = true
                    noHRBelt.textError.text = qsTr("No Heart\nRate Belt")
                }
                else {
                    noHRBelt.visible = false
                }

                myProgressCircle.givenValue    = HR.actualHeartRateProp //HR.heartRateRestProp               // The size of the circle in pixel

                myProgressCircle.hRR    = HR.heartRateAerobieProp  - 10//HR.heartRateRestProp               // The size of the circle in pixel
                myProgressCircle.hRAe   = HR.heartRateAerobieProp               // The size of the circle in pixel
                myProgressCircle.hRAeA  = HR.heartRateAdvenceAerobieProp               // The size of the circle in pixel
                myProgressCircle.hRLa   = HR.heartRateLacticProp               // The size of the circle in pixel
                myProgressCircle.hRAn   = HR.heartRateAnaerobieProp               // The size of the circle in pixel
                myProgressCircle.hRAnA  = HR.heartRateAdvenceAnaerobieProp               // The size of the circle in pixel
                myProgressCircle.hRMax  = HR.heartRateMaxProp
            }
            else {
                noErg.text = qsTr("No Erg\nPlease\nConnect")
                noErg.visible = true

            }

            //            myProgressCircle.givenValue = ( myProgressCircle.givenValue>= 145) ? myProgressCircle.givenValue*ChartsFunctions.entierAleatoire(99,101)/100 : 150;
        }
    }

    Column {
        id: column
        width: 800
        height: 400

        MyProgressCircle {
            id: myProgressCircle
            width: 400
            height: 400
            anchors.right: grid.left
            anchors.rightMargin: 0
            anchors.top: column.top

        }

        Grid {
            id: grid
            width: 400
            height: 400
            anchors.left: myProgressCircle.right
            anchors.top: column.top

            Text {
                id: paceText
                width: 200
                color: "#ffffff"
                text: qsTr("Allure 500m")
                font.pixelSize: 30
            }

            Text {
                id: pace
                width: 200
                color: "#ffffff"
                text: qsTr("Text")
                horizontalAlignment: Text.AlignRight
                anchors.left: paceText.right
                anchors.leftMargin: 0
                font.pixelSize: 30
            }

            Text {
                id: distanceText
                width: 200
                color: "#ffffff"
                text: qsTr("Distance")
                font.pixelSize: 30
                anchors.top: pace.bottom
            }

            Text {
                id: distance
                width: 200
                color: "#ffffff"
                text: qsTr("Text")
                horizontalAlignment: Text.AlignRight
                anchors.left: distanceText.right
                anchors.leftMargin: 0
                font.pixelSize: 30
                anchors.top: pace.bottom
            }

            Text {
                id: wattText
                width: 200
                color: "#ffffff"
                text: qsTr("Puissance")
                anchors.topMargin: 0
                font.pixelSize: 30
                anchors.top: distanceText.bottom
            }

            Text {
                id: watt
                width: 200
                color: "#ffffff"
                text: qsTr("Text")
                anchors.topMargin: 0
                font.pixelSize: 30
                anchors.left: distanceText.right
                anchors.top: distance.bottom
                horizontalAlignment: Text.AlignRight
                anchors.leftMargin: 0
            }
        }



    }


    Error {
        id: noErg
        x: parent.width/2
        y: parent.height/2
        anchors.fill: parent
        visible: false

    }



    Error {
        id: noHRBelt
        x: parent.width/2
        y: parent.height/2
        anchors.fill: parent
        visible: false
        focus: true

    }

    //    Popup {
    //        id: popup
    //        x: 100
    //        y: 100
    //        width: 200
    //        height: 300
    //        modal: true
    //        focus: true
    //        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

    //        Button {
    //            text: "Close"
    //            onClicked: popup.close()
    //        }
    //    }
    //    Button {
    //        text: "Open"
    //        onClicked: popup.open()
    //    }

}


/*##^##
Designer {
    D{i:3;anchors_height:400;anchors_width:400}D{i:4;anchors_width:400}
}
##^##*/
