
import sys
import random

from PySide2.QtWidgets import QApplication # <--- https://stackoverflow.com/questions/57514937/qml-charts-causes-crash-on-startup
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine, qmlRegisterType
from PySide2.QtCore import QUrl

from PySide2.QtCore import QObject, Signal, Slot, Property

from pyrow import pyrow


class HeartRate(QObject):

    numberChanged = Signal(int)


    def __init__(self):
        QObject.__init__(self)

        self.age = -1

        self.actualHeartRate = 150
        self.heartRateRest = 59
        self.heartRateAerobie = 110
        self.heartRateAdvenceAerobie = 120
        self.heartRateLactic = 130
        self.heartRateAnaerobie =140
        self.heartRateAdvenceAnaerobie = 150
        self.heartRateMax = 160

        self.ergs = []

    def connectToErg(self):

        if(self.ergs == []):
            self.ergs = list(pyrow.find())

        if(self.ergs == []):
            print("No ergs found.")

        else:

            try:
                    erg = pyrow.PyErg(self.ergs[0])
                    print("Connected to erg.")
                    monitor = erg.get_monitor()
#                    result = erg.send(command)
                    hrate = monitor['heartrate']
                    if(hrate != 0):
                        self.actualHeartRate = hrate ##+80
                    else :
                        print("HR = 0 !")
            except:#display error msg
                    self.ergs = []
                    print("Pas de PM5")

#        return(self.actualHeartRate)

    @Slot()
    def getactualHeartRate(self):

        self.connectToErg()


        return(self.actualHeartRate)

    @Slot()
    def getheartRateRest(self):
        return(self.heartRateRest)

    @Slot()
    def getheartRateAerobie(self):
        return(self.heartRateAerobie)

    @Slot()
    def getheartRateAdvenceAerobie(self):
        return(self.heartRateAdvenceAerobie)

    @Slot()
    def getheartRateLactic(self):
        return(self.heartRateLactic)

    @Slot()
    def getheartRateAnaerobie(self):
        return(self.heartRateAnaerobie)

    @Slot()
    def getheartRateAdvenceAnaerobie(self):
        return(self.heartRateAdvenceAnaerobie)

    @Slot()
    def getheartRateMax(self):
        return(self.heartRateMax)

    @Slot()
    def getErgs(self):
        if(self.ergs == []):
            return(0)
        else:
            return(1)

    @Slot(int)
    def setactualHeartRate(self,value):
        self.actualHeartRate = value
        print("setactualHeartRate : ",self.actualHeartRate)

    actualHeartRateProp           = Property(int, getactualHeartRate, notify=numberChanged)
    heartRateRestProp             = Property(int, getheartRateRest, notify=numberChanged)
    heartRateAerobieProp          = Property(int, getheartRateAerobie, notify=numberChanged)
    heartRateAdvenceAerobieProp   = Property(int, getheartRateAdvenceAerobie, notify=numberChanged)
    heartRateLacticProp           = Property(int, getheartRateLactic, notify=numberChanged)
    heartRateAnaerobieProp        = Property(int, getheartRateAnaerobie, notify=numberChanged)
    heartRateAdvenceAnaerobieProp = Property(int, getheartRateAdvenceAnaerobie, notify=numberChanged)
    heartRateMaxProp              = Property(int, getheartRateMax, notify=numberChanged)
    ergsProp                      = Property(int, getErgs, notify=numberChanged)


    @Slot(int)
    def setAge(self,age):
        self.age = age

    def getAge(self):
        return(self.age)

    @Slot()
    def computeHRMax(self):

        if(self.age>0) : # Gellish et al 2007
            if(self.age >= 35 and self.age <= 75):
                self.heartRateMax = round(191.5 -0.007*self.age*self.age)
            else:
                self.heartRateMax = round(206.9 -0.67*self.age)
        return(self.age)

    @Slot()
    def computeHRZones(self):

        self.heartRateAerobie           = 0.6*(self.heartRateMax - self.heartRateRest) + self.heartRateRest
        self.heartRateAdvenceAerobie    = 0.73*(self.heartRateMax - self.heartRateRest) + self.heartRateRest
        self.heartRateLactic            = 0.84*(self.heartRateMax - self.heartRateRest) + self.heartRateRest
        self.heartRateAnaerobie         = 0.88*(self.heartRateMax - self.heartRateRest) + self.heartRateRest
        self.heartRateAdvenceAnaerobie  = 0.95*(self.heartRateMax - self.heartRateRest) + self.heartRateRest

    getAgeProp              = Property(int, getAge, notify=numberChanged)


if __name__ == '__main__':
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()


    HR = HeartRate();

    engine.rootContext().setContextProperty("HR", HR)

    engine.load(QUrl("main.qml"))

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec_())
