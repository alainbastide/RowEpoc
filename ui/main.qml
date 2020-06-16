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

//import QtSystemInfo 5.0

//import QtQuick.Timeline 1.0
import "js/Functions.js" as ChartsFunctions

//Window {
//    id: splash
//    color: "transparent"
//    title: "Splash Window"
//    modality: Qt.ApplicationModal
//    flags: Qt.SplashScreen
//    property int timeoutInterval: 2000
//    signal timeout

//    Timer {
//        interval: timeoutInterval; running: true; repeat: false
//        onTriggered: {
//            visible = false
//            splash.timeout()
//        }
//    }
//    Shared.CheckBox {
//        text: "Windowed"
//        height: showButton.height
//        width: col.cellWidth
//        Binding on checked { value: testWindow.visibility === Window.Windowed }
//        onClicked: testWindow.visibility = Window.Windowed
//    }

//}
Window {
    id: root

    width: 800
    height: root.width / 2
    color: "#1c1c1c"
    visible: true

    title: "RowEPOC"

    //    onVisibilityChanged: {
    //        console.log(Qt.Key_ScreenSaver.valueOf())
    //    }

    //    Component.ScreenSaver {
    //        id: screenSaver
    //        screenSaverEnabled: !Qt.application.active
    //    }
    onHeightChanged: {

        root.height = root.width / 2
        // charge au demarrage
    }

    onWidthChanged: {

        root.height = root.width / 2
        //        dataList[0].nameZone.text = ""
        // charge au demarrage
    }

    HrCircles {
        id: myProgressCircle
        x: 0
        y: 0
        width: root.width / 2
        height: root.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.rightMargin: 0
        anchors.top: parent.top
    }

    Column {
        id: column
        width: root.width / 2
        height: root.height
        property int rowNumber: 8
        x: root.width / 2
        y: 0

        onPositioningComplete: {
            column.rowNumber = 8
        }

        Data {
            id: distance
            heightRow: column.height / column.rowNumber
            textDataName: "Distance"
            textDataData: "3287"
            textDataUnit: "m"
        } //distance.textDataData

        Data {
            id: temps
            heightRow: column.height / column.rowNumber
            textDataName: "Temps"
            textDataData: "3:20"
            textDataUnit: ""
        }

        Data {
            id: pace500m
            heightRow: column.height / column.rowNumber
            textDataName: "Allure 500m"
            textDataData: "2:00"
            textDataUnit: ""
        }

        Data {
            id: power
            heightRow: column.height / column.rowNumber
            textDataName: "Puissance"
            textDataData: "215"
            textDataUnit: "W"
        }

        Data {
            id: pace2K
            heightRow: column.height / column.rowNumber
            textDataName: "Allure 2K"
            textDataData: "2:10"
            textDataUnit: ""
        }

        Data {
            id: projection
            heightRow: column.height / column.rowNumber
            textDataName: "Projection 30m"
            textDataData: "12000"
            textDataUnit: "m"
        }

        Data {
            id: calories
            heightRow: column.height / column.rowNumber
            textDataName: "Calories"
            textDataData: "0"
            textDataUnit: "Cal"
        }

        Data {
            id: status
            heightRow: column.height / column.rowNumber
            textDataName: "Statut"
            textDataData: "Ready"
            textDataUnit: ""
        }
    }


    //    onWidthChanged: {
    //        root.height = 400
    //        root.width = 800
    //    }

    //    onHeightChanged: {
    //        root.height = 400
    //        root.width = 800
    //    }
    //    ListView {
    //        id: dataList

    //        x: 400
    //        width: root.width / 2
    //        height: root.height
    //        anchors.verticalCenter: parent.verticalCenter
    //        anchors.right: parent.right
    //        anchors.bottom: parent.bottom
    //        anchors.top: parent.top
    //        anchors.left: myProgressCircle.right
    //        anchors.leftMargin: 6
    //        antialiasing: true
    //        highlightMoveDuration: 0
    //        highlightRangeMode: ListView.ApplyRange
    //        flickableDirection: Flickable.AutoFlickDirection
    //        delegate: Item {
    //            x: 5
    //            width: dataList.width
    //            height: 400 / 7 * dataList.width / 400
    //            Row {
    //                id: row1
    //                width: dataList.width

    //                Text {
    //                    text: nameZone
    //                    font.bold: true
    //                    width: dataList.width / 4 * 1.5
    //                    anchors.verticalCenter: parent.verticalCenter
    //                    color: "white"
    //                    fontSizeMode: Text.HorizontalFit
    //                    verticalAlignment: Text.AlignVCenter
    //                    horizontalAlignment: Text.AlignLeft
    //                    font.pixelSize: 15 * dataList.width / 400
    //                }
    //                Text {
    //                    text: dataZone
    //                    font.bold: false
    //                    anchors.bottom: parent.bottom
    //                    width: dataList.width / 2
    //                    color: "white"
    //                    font.family: "Digital-7"
    //                    fontSizeMode: Text.HorizontalFit
    //                    font.pixelSize: 60 * dataList.width / 400
    //                    verticalAlignment: Text.AlignVCenter
    //                    horizontalAlignment: Text.AlignRight
    //                }
    //                Text {
    //                    //                    id: changeZone
    //                    text: unitZone
    //                    font.bold: false
    //                    anchors.bottom: row1.anchors.TopAnchor //parent.bottom
    //                    width: dataList.width / 4 * 3
    //                    color: "white"
    //                    fontSizeMode: Text.HorizontalFit
    //                    font.pixelSize: 15 * dataList.width / 400
    //                    verticalAlignment: Text.AlignBottom
    //                    horizontalAlignment: Text.AlignLeft
    //                }
    //                spacing: 3
    //            }
    //        }

    //        model: ListModel {
    //            property var colorArray: [3600, 7200, HR.actualHeartRateProp]
    //            ListElement {
    //                //                changeZone: distance
    //                nameZone: qsTr("Distance")
    //                dataZone: "1005"
    //                unitZone: "m"
    //            }

    //            ListElement {
    //                //                changeZone: pace
    //                nameZone: qsTr("Allure")
    //                dataZone: "2:07.20" //ChartsFunctions.secondsToTime(3600) //"2:07.20"
    //                unitZone: ""
    //            }
    //            ListElement {
    //                //                changeZone: power
    //                nameZone: qsTr("Puissance")
    //                dataZone: "315"
    //                unitZone: "W"
    //            }

    //            ListElement {
    //                //                changeZone: strokes
    //                nameZone: qsTr("Coups de Rame")
    //                dataZone: "22"
    //                unitZone: ""
    //            }

    //            ListElement {
    //                //                changeZone: timeStart
    //                nameZone: qsTr("Temps")
    //                dataZone: "22:32.20"
    //                unitZone: ""
    //            }

    //            ListElement {
    //                //                changeZone: lap2K
    //                nameZone: qsTr("Passage au 2K")
    //                dataZone: "2:02.20"
    //                unitZone: ""
    //            }

    //            ListElement {
    //                //                changeZone: timeEnd
    //                nameZone: qsTr("Projection fin")
    //                dataZone: "2:02.20"
    //                unitZone: ""
    //            }
    //        }

    //        //        Text {
    //        //            id: element
    //        //            x: 112
    //        //            y: 363
    //        //            color: "#ffffff"
    //        //            text: qsTr("Text")
    //        //            fontSizeMode: Text.VerticalFit
    //        //            font.pixelSize: 12
    //        //        }
    //    }
    Timer {
        id: testRefreshTimerOneSecond
        interval: 1000
        running: true
        repeat: true
        onTriggered: {

        }
    }

    Timer {
        id: testRefreshTimer
        interval: 200
        running: true
        repeat: true
        onTriggered: {

            myProgressCircle.givenValue = HR.actualHeartRateProp //HR.heartRateRestProp               // The size of the circle in pixel

            myProgressCircle.hRR = HR.heartRateAerobicProp
                    - 10 //HR.heartRateRestProp               // The size of the circle in pixel
            myProgressCircle.hRAe = HR.heartRateAerobicProp // The size of the circle in pixel
            myProgressCircle.hRAeA
                    = HR.heartRateAdvencedAerobicProp // The size of the circle in pixel
            myProgressCircle.hRLa = HR.heartRateLacticProp // The size of the circle in pixel
            myProgressCircle.hRAn = HR.heartRateAnaerobicProp // The size of the circle in pixel
            myProgressCircle.hRAnA
                    = HR.heartRateAdvencedAnaerobicProp // The size of the circle in pixel
            myProgressCircle.hRMax = HR.heartRateMaxProp

            //            console.log("3600".toMMSS())
            connC2.connectToErg()
            var ergs = connC2.getErgs()

            //            console.log(ergs)
            if (connC2.getErgs() === 1) {

                connC2.getErg()
                connC2.getMonitor()

                connC2.writeData() //CSV
                HR.setactualHeartRate(connC2.getHeartRate())
                HR.setAge(45)
                HR.computeHRMax()
                HR.computeHRZones()

                distance.textDataData = (connC2.getDistance()).toString()
                temps.textDataData = ChartsFunctions.toMMSS(connC2.getTime())
                pace500m.textDataData = ChartsFunctions.toMMSSMM(
                            connC2.getPace())
                //                pace2K.textDataData = ChartsFunctions.toMMSSMM(connC2.getPace())
                power.textDataData = (connC2.getPower())
                calories.textDataData = (connC2.getCalories())
                status.textDataData = (connC2.getStatuts())

                noErg.visible = false

                if (HR.actualHeartRateProp === 0) {
                    noHRBelt.visible = true
                    noHRBelt.text = qsTr("No Heart\nRate Belt")
                } else {
                    noHRBelt.visible = false
                }
            } else {

                if (ergs === 0) {
                    var erg = connC2.getErg()
                    var monitor = connC2.getMonitor(erg)
                }
                noErg.text = qsTr("No Erg\nPlease\nConnect")
                noErg.visible = true
            }
        }
    }

    Error {
        id: noErg
        x: parent.width / 2
        y: parent.height / 2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        visible: false
    }

    Error {
        id: noHRBelt
        x: parent.width / 2
        y: parent.height / 2
        width: 200
        height: 200
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        visible: false
        focus: true
    }
}
