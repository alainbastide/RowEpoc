import QtQuick 2.12
import QtQml 2.2
import QtQuick.Window 2.2
import QtCharts 2.3
import QtQuick.Controls 2.0

import QtGraphicalEffects 1.12
import QtQuick.Controls.Styles 1.4

import "Functions.js" as ChartsFunctions


Window {
    id: root

    width: 400
    height: width
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
        anchors.fill: parent

        MyProgressCircle {
            id: myProgressCircle
            width: parent.width
            height: parent.height
            anchors.fill: parent

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

