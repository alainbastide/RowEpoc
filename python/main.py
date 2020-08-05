import sys
import random

from PySide2.QtWidgets import QApplication
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine, qmlRegisterType
from PySide2.QtCore import QUrl
import PySide2.QtCore as QtC

from PySide2.QtCore import QObject, Signal, Slot, Property

from pyrow import pyrow



import sqlite3

import configparser
config = configparser.ConfigParser()

config.read('config.ini')


#conn = sqlite3.connect(config['SQL']['sqlfile'])


class dataStore(QObject):

    def __init__(self):
        QObject.__init__(self)

        self.config = []
        self.configFile = 'config.ini'
        
    def readConf(self):
        self.config = configparser.ConfigParser()
        
        self.config.read(self.configFile)
        
        
    @Slot(result=int)
    def sqlConnect(self):
        """ create a database connection to the SQLite database
            specified by the db_file
        :param db_file: database file
        :return: Connection object or None
        """
        conn = None
        try:
            self.conn = sqlite3.connect(config['SQL']['sqlfile'])
            return 1
        except Error as e:
            print(e)
#            raise  e
            return 0
    
    def createTables(self):

        try:
            c = self.conn.cursor()
        
            c.execute('''CREATE TABLE IF NOT EXISTS users
                         (iduser  INTEGER PRIMARY KEY AUTOINCREMENT,
                         firstname TEXT NOT NULL,
                         lastname TEXT NOT NULL,
                         dateBirth TEXT NOT NULL,
                         MF VARCHAR(1) NOT NULL,
                         email VARCHAR(256) NOT NULL,
                         UNIQUE ( firstname, lastname, dateBirth, MF, email) );''')
            self.conn.commit()
            c.close()
        
        except sqlite3.IntegrityError:
            print("User Table exist")
        except sqlite3.Error :
            print("Error on DB")
        
        try:
            c = self.conn.cursor()
        
            c.execute('''CREATE TABLE IF NOT EXISTS  personnalData
                         (idPersonnalData INTEGER PRIMARY KEY AUTOINCREMENT,
                         date TEXT  NOT NULL,
                         idUser INTEGER  NOT NULL,
                         hrrest INTEGER NOT NULL,
                         weight INTEGER NOT NULL,
                         height INTEGER,
                         wingspan INTEGER,
                         FOREIGN KEY (idUser) REFERENCES users(iduser)
                         ON UPDATE CASCADE
                         ON DELETE CASCADE,
                         UNIQUE ( idUser, date)
                         )''')
            self.conn.commit()
            c.close()
        
        except sqlite3.IntegrityError:
            print("personnalData Table exist")
        except sqlite3.Error :
            print("Error on DB")
        
        
        try:
            c = self.conn.cursor()
        
            c.execute('''CREATE TABLE IF NOT EXISTS  trainingData
                         (idTrainingData INTEGER PRIMARY KEY AUTOINCREMENT,
                         date TEXT  NOT NULL,
                         idUser INTEGER  NOT NULL,
                         idPersonnalData INTEGER  NOT NULL,
                         FOREIGN KEY (idUser) REFERENCES users(iduser)
                         ON UPDATE CASCADE
                         ON DELETE CASCADE,
                         FOREIGN KEY (idPersonnalData) REFERENCES personnalData(idPersonnalData)
                         ON UPDATE CASCADE
                         ON DELETE CASCADE,
                         UNIQUE ( idUser,idPersonnalData, date)
                         )''')
            self.conn.commit()
            c.close()
        
        except sqlite3.IntegrityError:
            print("personnalData Table exist")
        except sqlite3.Error :
            print("Error on DB")
        
        
        
        
        try:
            c = self.conn.cursor()
        
            c.execute('''CREATE TABLE IF NOT EXISTS  rowingData
                         (idRowingData INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                         idTrainingData INTEGER NOT NULL,
                         time INTEGER,
                         distance INTEGER,
                         pace INTEGER,
                         stroke INTEGER,
                         HR INTEGER,
                         FOREIGN KEY (idTrainingData) REFERENCES trainingData(idTrainingData)
                         ON UPDATE CASCADE
                         ON DELETE CASCADE 
                         )''')
            self.conn.commit()
            c.close()
        
        except sqlite3.IntegrityError:
            print("personnalData Table exist")
        except sqlite3.Error :
            print("Error on DB")
        


class connectConcept2(QObject):

    numberChanged = Signal(int)

    def __init__(self):
        QObject.__init__(self)

        self.message = []

        self.ergs = []
        self.erg = {} ##{}

        self.monitor = {}
        self.time = 0
        self.heartrate = 0
        self.distance = 0
        self.spm = 0
        self.power = 0
        self.pace = 0
        self.calhr = 0
        self.calories = 0
        self.status = 0
        self.writeCSV=1

    @Slot(result=int)
    def getErgs(self):

        if((self.ergs) == [] ):
            return(0)
        else:
            return(1)

    @Slot(result=bool)
    def connectToErg(self):
        try:
                self.ergs = list(pyrow.find())

                return(True)

        except:
                self.ergs = []
                self.message.append("No ergs found")
                return(False)
        return(False)

    def getMessage(self):

        return(self.message)

    @Slot(result=int)
    def getErg(self):
        if (self.ergs != []):
            try:
                self.erg = pyrow.PyErg(self.ergs[0])
                self.erg.set_clock()
                print(self.erg.get_workout())
                print(self.erg.get_erg())
                print(self.erg.get_status())
                self.message.append("Connected to erg.")
                return(self.erg)
            except:
                self.message.append("No ergs found")

    @Slot()
    def getMonitor(self):
        if(self.ergs != []):
                try:
                    self.monitor = self.erg.get_monitor()
                    self.time = self.monitor['time']
                    self.heartrate = self.monitor['heartrate']
                    self.distance = self.monitor['distance']
                    self.spm = self.monitor['spm']
                    self.power = self.monitor['power']
                    self.pace = self.monitor['pace']
                    self.calhr = self.monitor['calhr']
                    self.calories = self.monitor['calories']
                    self.status = self.monitor['status']

                    return(True)
                except:
                    return(False)


    @Slot(result=int)
    def getHeartRate(self):
            return(self.heartrate)

    @Slot(result=int)
    def getDistance(self):
            return(self.distance)


    @Slot(result=int)
    def getTime(self):
            return(self.time)

    @Slot(result=int)
    def getStrokes(self):
            return(self.spm)

    @Slot(result=int)
    def getPower(self):
            return(self.power)

    @Slot(result=float)
    def getPace(self):
            return(self.pace)

    @Slot(result=int)
    def getCalories(self):
            return(self.calories)

    @Slot(result=str)
    def getStatuts(self):
            return(self.status)

    @Slot()
    def writeData(self):
        import csv

        with open('../data/data.csv', 'a') as f:
            w = csv.DictWriter(f, self.monitor.keys())
            if(self.writeCSV==1):
                w.writeheader()
                self.writeCSV=0
            w.writerow( self.monitor  )

        with open('../data/get_workout.csv', 'a') as f:
            gwt = (self.erg).get_workout()
            w = csv.DictWriter(f, gwt.keys())
            if(self.writeCSV==1):
                w.writeheader()
                self.writeCSV=0
            w.writerow(  gwt)


        with open('../data/get_erg.csv', 'a') as f:
            gwt = (self.erg).get_erg()
            w = csv.DictWriter(f, gwt.keys())
            if(self.writeCSV==1):
                w.writeheader()
                self.writeCSV=0
            w.writerow(  gwt)


        with open('../data/get_status.csv', 'a') as f:
            gwt = (self.erg).get_status()
            w = csv.DictWriter(f, gwt.keys())
            if(self.writeCSV==1):
                w.writeheader()
                self.writeCSV=0
            w.writerow(  gwt)



class HeartRate(QObject):

    numberChanged = Signal(int)


    def __init__(self):
        QObject.__init__(self)

        self.age = 45

        self.actualHeartRate = 160
        self.heartRateRest = 59
        self.heartRateAerobic = 110
        self.heartRateAdvencedAerobic = 120
        self.heartRateLactic = 130
        self.heartRateAnaerobic = 140
        self.heartRateAdvencedAnaerobic = 150
        self.heartRateMax = 160

        self.ergs = []

        self.message = ""
        ## init

    @Slot()
    def getactualHeartRate(self):

#        self.connectToErg()


        return(self.actualHeartRate)

    @Slot()
    def getheartRateRest(self):
        return(self.heartRateRest)

    @Slot()
    def getheartRateAerobic(self):
        return(self.heartRateAerobic)

    @Slot()
    def getheartRateAdvencedAerobic(self):
        return(self.heartRateAdvencedAerobic)

    @Slot()
    def getheartRateLactic(self):
        return(self.heartRateLactic)

    @Slot()
    def getheartRateAnaerobic(self):
        return(self.heartRateAnaerobic)

    @Slot()
    def getheartRateAdvencedAnaerobic(self):
        return(self.heartRateAdvencedAnaerobic)

    @Slot()
    def getheartRateMax(self):
        return(self.heartRateMax)

    @Slot(int)
    def setactualHeartRate(self,value):
        self.actualHeartRate = value



    actualHeartRateProp           = Property(int, getactualHeartRate, notify=numberChanged)
    heartRateRestProp             = Property(int, getheartRateRest, notify=numberChanged)
    heartRateAerobicProp          = Property(int, getheartRateAerobic, notify=numberChanged)
    heartRateAdvencedAerobicProp   = Property(int, getheartRateAdvencedAerobic, notify=numberChanged)
    heartRateLacticProp           = Property(int, getheartRateLactic, notify=numberChanged)
    heartRateAnaerobicProp        = Property(int, getheartRateAnaerobic, notify=numberChanged)
    heartRateAdvencedAnaerobicProp = Property(int, getheartRateAdvencedAnaerobic, notify=numberChanged)
    heartRateMaxProp              = Property(int, getheartRateMax, notify=numberChanged)


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

        self.heartRateAerobic           = 0.6 * (self.heartRateMax - self.heartRateRest) + self.heartRateRest
        self.heartRateAdvencedAerobic    = 0.73 * (self.heartRateMax - self.heartRateRest) + self.heartRateRest
        self.heartRateLactic            = 0.84*(self.heartRateMax - self.heartRateRest) + self.heartRateRest
        self.heartRateAnaerobic         = 0.88 * (self.heartRateMax - self.heartRateRest) + self.heartRateRest
        self.heartRateAdvencedAnaerobic  = 0.95 * (self.heartRateMax - self.heartRateRest) + self.heartRateRest

    getAgeProp              = Property(int, getAge, notify=numberChanged)


if __name__ == '__main__':

    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()

    connC2  = connectConcept2()
    HR = HeartRate();
    
    sqlData = dataStore();
    
    sqlData.readConf();
    sqlData.sqlConnect();
    sqlData.createTables();
    

    engine.rootContext().setContextProperty("connC2", connC2)
    engine.rootContext().setContextProperty("HR", HR)

    engine.load(QUrl("../ui/main.qml"))

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec_())
