import QtQuick 2.0
import QtQml 2.2

import "js/Functions.js" as JSFunctions

Item {
    id: root


    property int givenValue: 134

    property int size: 200               // The size of the circle in pixel
    property int arcBeginF: 0            // start arc angle in degree
    property int arcEndF: 270            // end arc angle in degree
    property int arcOffset: -135           // rotation
    property int lineWidth: 20          // width of the line
    property string colorCircle: "#CC3333"

    property int hRR: HR.heartRateRestProp               // The size of the circle in pixel
    property int hRW: HR.actualHeartRateProp               // The size of the circle in pixel
    property int hRAe: HR.heartRateAerobieProp               // The size of the circle in pixel
    property int hRAeA: HR.heartRateAdvenceAerobieProp               // The size of the circle in pixel
    property int hRLa : HR.heartRateLacticProp               // The size of the circle in pixel
    property int hRAn : HR.heartRateAnaerobieProp               // The size of the circle in pixel
    property int hRAnA: HR.heartRateAdvenceAnaerobieProp               // The size of the circle in pixel
    property int hRMax: HR.heartRateMaxProp
    width: 400
    height: root.width               // The size of the circle in pixel



    onGivenValueChanged: {

        canvas.requestPaint()
        textPrincipal.text = givenValue

        if(givenValue<=hRR)  textWarn.text = qsTr("Too Low")
        else  if(givenValue>=hRMax)  textWarn.text = qsTr("Too High")
        else textWarn.text = ""



    }

    onWidthChanged: {

          var coef = 29 * Math.min(parent.width/120,parent.height/120);
          textPrincipal.font.pixelSize = coef;

    }


    onHeightChanged: {

        var coef = 29 * Math.min(parent.width/120,parent.height/120);
        textPrincipal.font.pixelSize = coef;

    }



    Timer {
        id: testRefreshTimer
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
//            givenValue  = JSFunctions.entierAleatoire(hRR/2, hRMax)

        }
    }

    Canvas {
        id: canvas
        x: Math.min(parent.width,parent.height)/2
        y: Math.min(parent.width,parent.height)/2
        anchors.fill: parent
        rotation: -90 + parent.arcOffset

        onPaint: {
            var ctx = getContext("2d")
            ctx.reset();
            var x = Math.min(parent.width,parent.height)/2
            var y = Math.min(parent.width,parent.height)/2


            var correctGivenValue = (parent.givenValue <= parent.hRR) ? parent.hRR:parent.givenValue ;

            var coeffDegRad = Math.PI/180. ;
            var lineWidth = 10*x/80;
            var lineWidth2 = 20*x/80;
            var lowRadius = parent.width/2 - lineWidth - lineWidth2 - 10 ;
            var diffArc = (parent.arcEndF - parent.arcBeginF) ;
            var diffHR  = parent.hRMax - parent.hRR ;
            var position = (correctGivenValue - parent.hRR) ;
            var coefArc = 1./diffHR*diffArc*coeffDegRad;
            var positionArc = position*coefArc;

            var testLowhRR   = correctGivenValue < parent.hRAe;
            var testLowhRAe  = parent.hRAe <= correctGivenValue && correctGivenValue < parent.hRAeA;
            var testLowhRAeA   = parent.hRAeA<= correctGivenValue && correctGivenValue < parent.hRLa;
            var testLowhRLa  = parent.hRLa <= correctGivenValue && correctGivenValue < parent.hRAn;
            var testLowhRAn  = parent.hRAn <= correctGivenValue && correctGivenValue < parent.hRAnA;
            var testLowhRAnA  = parent.hRAnA<= correctGivenValue && correctGivenValue <= parent.hRMax;

            var colorArray    = ['gray','MediumSlateBlue','Lime', 'yellow','orange','Red','Red'];
            var selectColor   = colorArray[0];
            var trans         = 0.2;
            var selectColorTransparency = [trans,trans,trans,trans,trans,trans];


                ctx.lineWidth=lineWidth2;
                ctx.lineCap='butt';
                ctx.beginPath();
                ctx.arc(x,y,lowRadius + lineWidth2/2 + 5 + lineWidth, 0  , positionArc );

                if(testLowhRR) {
                        ctx.strokeStyle=colorArray[0];
                        selectColorTransparency[0] = 1;
                        textWork.text = qsTr("Echauffement")
                         }
                else if(testLowhRAe) {
                        ctx.strokeStyle=colorArray[1]
                        selectColorTransparency[1] = 1;
                       textWork.text = qsTr("Aérobie")
                        }
                else if(testLowhRAeA) {
                        ctx.strokeStyle=colorArray[2]
                        selectColorTransparency[2] = 1;
                        textWork.text = qsTr("Aérobie\nAvancée")
                        }
                else if(testLowhRLa) {
                        ctx.strokeStyle=colorArray[3]
                        selectColorTransparency[3] = 1;
                        textWork.text = qsTr("Lactique")
                        }
                else if(testLowhRAn) {
                        ctx.strokeStyle=colorArray[4]
                        selectColorTransparency[4] = 1;
                        textWork.text = qsTr("Anaérobie")
                        }
                else if(testLowhRAnA) {
                        ctx.strokeStyle=colorArray[5]
                        selectColorTransparency[5] = 1;
                        textWork.text = qsTr("Anaérobie\nAvancée")
                        }
                else  {
                        ctx.strokeStyle=colorArray[6]
                        selectColorTransparency[6] = 1;
                        textWork.text = qsTr("Danger")
                       }

                ctx.stroke();


                ctx.beginPath();
                ctx.lineWidth = lineWidth;
                ctx.arc(x,y,lowRadius - ctx.lineWidth/2, (parent.hRR - parent.hRR)*coefArc  , (parent.hRAe - parent.hRR)*coefArc );
                ctx.strokeStyle=colorArray[0];
                ctx.globalAlpha =selectColorTransparency[0];
                ctx.stroke();



                ctx.beginPath();
                ctx.lineWidth = lineWidth;
                ctx.arc(x,y,lowRadius - ctx.lineWidth/2, (parent.hRAe - parent.hRR)*coefArc  , (parent.hRAeA - parent.hRR)*coefArc );
                ctx.strokeStyle=colorArray[1];
                ctx.globalAlpha =selectColorTransparency[1];
                ctx.stroke();



                ctx.beginPath();
                ctx.lineWidth = lineWidth;
                ctx.arc(x,y,lowRadius - ctx.lineWidth/2, (parent.hRAeA - parent.hRR)*coefArc  , (parent.hRLa - parent.hRR)*coefArc );
                ctx.strokeStyle=colorArray[2];
                ctx.globalAlpha =selectColorTransparency[2];
                ctx.stroke();


                ctx.beginPath();
                ctx.lineWidth = lineWidth;
                ctx.arc(x,y,lowRadius - ctx.lineWidth/2, (parent.hRLa - parent.hRR)*coefArc  , (parent.hRAn - parent.hRR)*coefArc );
                ctx.strokeStyle=colorArray[3];
                ctx.globalAlpha =selectColorTransparency[3];
                ctx.stroke();


                ctx.beginPath();
                ctx.lineWidth = lineWidth;
                ctx.arc(x,y,lowRadius - ctx.lineWidth/2 , (parent.hRAn - parent.hRR)*coefArc  , (parent.hRAnA - parent.hRR)*coefArc );
                ctx.strokeStyle=colorArray[4];
                ctx.globalAlpha =selectColorTransparency[4];
                ctx.stroke();



                ctx.beginPath();
                ctx.lineWidth = lineWidth;
                ctx.arc(x,y,lowRadius - ctx.lineWidth/2 , (parent.hRAnA - parent.hRR)*coefArc  , (parent.hRMax - parent.hRR)*coefArc );
                ctx.strokeStyle=colorArray[5];
                ctx.globalAlpha =selectColorTransparency[5];
                ctx.stroke();









        }
    }

    Text {
        id: textPrincipal
        width: 300
        height: 100
        color: "#ffffff"
        text: "120"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.family: "Verdana"
        fontSizeMode: Text.Fit
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 29
        minimumPointSize: 10



    }
    Text {
        id: textbmp
        width: 75
        height: 22
        color: "#505050"
        text: "bmp"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:  textPrincipal.bottom
        font.pixelSize: 10
        fontSizeMode: Text.HorizontalFit
        font.family: "Verdana"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    Text {
        id: textWarn
        width: 75
        height: 22
        color: "#ffffff"
        text: ""
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:  textbmp.bottom
        font.pixelSize: 15
        fontSizeMode: Text.HorizontalFit
        font.family: "Verdana"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }



    Text {
        id: textWork
        width: 100
        height: 67
        color: "#ffffff"
        text: ""
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:  textWarn.bottom
        wrapMode: Text.WrapAnywhere
        font.pixelSize: 20
        fontSizeMode: Text.HorizontalFit
        font.family: "Verdana"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
