//
//  User.swift
//  CovidTracker
//
//  Created by Software Development HS_902 on 11/14/20.
//  Copyright © 2020 Software Development HS_902. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

@available(iOS 14.0, *)
class User: ObservableObject{
    //Default settings for new users
    @Published var anon_uuid: String = "Hello World"
    @Published var endLocationRequests: [String: String] = [String: String]()
    @Published var enterLocation: Bool = false
    @Published var locationsVisited: [[String: Any]] = []
    @Published var notifications: [Notification] = [Notification("Welcome to the CovidTracker App!", "Welcome to the CovidTracker Society! We understand that this year has been hard for everyone and people are hesitant to go anywhere in fear of contracting the virus. We hope this app helps you make educated decisions about the locations you visit. Together as a society, we will overcome this virus!", Timestamp())]
    @Published var riskAssesment: RiskValues = .green
    @Published var status: InfectionStatus = .negative
    @Published var timeStart: Timestamp = Timestamp(date: Date())
    @Published var quarantineDate: Timestamp = Timestamp(date: Date())
    var temporaryAlert: String = "Default"
    


    init(){
        Auth.auth().signInAnonymously() { (authResult, error) in
            guard let user = authResult?.user else { return }
            let uid = user.uid
            self.anon_uuid=uid
            print("UUID", uid)
            print("First bruh", self.anon_uuid)
            //Check if new user or not.
            let db = Firestore.firestore()
            
            let docRef = db.collection("users").document(self.anon_uuid)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    //Do Nothing Yet
                    print("Fetching User Variables 1...")
                    if let data = document.data() {
                        self.endLocationRequests = data["endLocationRequests"]! as! [String: String]
                        self.enterLocation = data["enterLocation"]! as! Bool
                        self.locationsVisited=data["locationsVisited"]! as! [[String: Any]]
                        let notification = data["notifications"]! as! [[String: Any]]
                        var notificationsArr=[Notification]()
                        var updatedNotificationsArr=[Notification]()
                        for i in notification{
                            if !i.isEmpty{
                                notificationsArr.append(Notification(i))
                                if Notification(i).timeOfContact != ""{
                                    let time=Notification(i).timeOfContact.split(separator: "_")[1]
                                    let timeArr=time.split(separator: "-")
                                    let hourAndMinutes=timeArr[0].split(separator: ":")
                                    let hour=hourAndMinutes[0]
                                    let minute=hourAndMinutes[1]
                                    let month=timeArr[1]
                                    let day=timeArr[2]
                                    let year=timeArr[3]
                                    let contactTime = DateComponents(
                                        calendar: nil,
                                        timeZone: nil,
                                        era: nil,
                                        year: Int(year),
                                        month: Int(month),
                                        day: Int(day),
                                        hour: Int(hour),
                                        minute: Int(minute),
                                        second: nil,
                                        nanosecond: nil,
                                        weekday: nil,
                                        weekdayOrdinal: nil,
                                        quarter: nil,
                                        weekOfMonth: nil,
                                        weekOfYear: nil,
                                        yearForWeekOfYear: nil
                                    )
            
                        
                                    var dateOfContact = Calendar.current.date(from: contactTime)!
                                    if !(Calendar.current.date(byAdding: .day, value: -14, to: Date())! > dateOfContact){
                                        updatedNotificationsArr.append(Notification(i))
                                    }
                                }else{
                                    let time=Notification(i).date.dateValue()
                                    if !(Calendar.current.date(byAdding: .day, value: -14, to: Date())! > time){
                                        updatedNotificationsArr.append(Notification(i))
                                    }
                                }
                            }
                        }
                        if notificationsArr.count != updatedNotificationsArr.count{
                            var notificationsDict=[[:]]
                            for i in updatedNotificationsArr{
                                if i.title != ""{
                                    notificationsDict.append(i.asDict())
                                }
                            }
                            docRef.setData([
                                "notifications": notificationsDict
                            ], merge: true) { err in
                                if let err = err {
                                    print("Error writing document: \(err)")
                                } else {
                                    print("Document successfully written!")
                                }
                            }
                            notificationsArr=updatedNotificationsArr
                        }
                        self.notifications=notificationsArr
                        self.status = data["status"]! as! String == "negative" ? InfectionStatus.negative : InfectionStatus.positive
                        self.timeStart = data["timeStart"]! as! Timestamp
                        if self.status == .positive{
                            self.quarantineDate = data["quarantineDate"]! as! Timestamp
                            print("Date Recieved", Calendar.current.date(byAdding: .day, value: 14, to: self.quarantineDate.dateValue())!)
                            print("Date Value", Date() >= Calendar.current.date(byAdding: .day, value: 14, to: self.quarantineDate.dateValue())!)
                            if Date() >= Calendar.current.date(byAdding: .day, value: 14, to: self.quarantineDate.dateValue())!{
                                self.status = .negative
                                docRef.setData([
                                    "status": "negative"
                                ], merge: true) { err in
                                    if let err = err {
                                        print("Error writing document: \(err)")
                                    } else {
                                        print("Document successfully written!")
                                    }
                                }
                            }
                        }
                        self.riskAssesment = self.evaluateRisk()
                        print("New Value", self.riskAssesment)
                    } else {
                        print("Data could not be unpacked")
                        exit(0)
                    }
                    print("New Val 2",self.riskAssesment)
                } else {
                    //Document doesn't exist
                    //Only add user to Firestore
                    print("Creating new User Variables...")
                    //Adding new Document to Firestore
                    var notificationsDict=[[:]]
                    for i in self.notifications{
                        if i.title != ""{
                            notificationsDict.append(i.asDict())
                        }
                    }
                    docRef.setData([
                        "anon_uuid": self.anon_uuid,
                        "endLocationRequests": self.endLocationRequests,
                        "enterLocation": self.enterLocation,
                        "locationsVisited": self.locationsVisited,
                        "notifications": notificationsDict,
                        "status": "negative",
                        "timeStart": self.timeStart
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                }
                let listener = db.collection("users").document(uid).addSnapshotListener { documentSnapshot, error in
                    guard let data = documentSnapshot?.data() else {
                        print("Error fetching document listener.")
                        return
                    }
                    //Document Exists
                    print("Fetching User Variables 2...")
                    self.endLocationRequests = data["endLocationRequests"]! as! [String: String]
                    self.enterLocation = data["enterLocation"]! as! Bool
                    self.locationsVisited = data["locationsVisited"]! as! [[String: Any]]
                    let notification = data["notifications"]! as! [[String: Any]]
                    var notificationsArr=[Notification]()
                    var updatedNotificationsArr=[Notification]()
                        for i in notification{
                            if !i.isEmpty{
                                notificationsArr.append(Notification(i))
                                if Notification(i).timeOfContact != ""{
                                    let time=Notification(i).timeOfContact.split(separator: "_")[1]
                                    let timeArr=time.split(separator: "-")
                                    let hourAndMinutes=timeArr[0].split(separator: ":")
                                    let hour=hourAndMinutes[0]
                                    let minute=hourAndMinutes[1]
                                    let month=timeArr[1]
                                    let day=timeArr[2]
                                    let year=timeArr[3]
                                    let contactTime = DateComponents(
                                        calendar: nil,
                                        timeZone: nil,
                                        era: nil,
                                        year: Int(year),
                                        month: Int(month),
                                        day: Int(day),
                                        hour: Int(hour),
                                        minute: Int(minute),
                                        second: nil,
                                        nanosecond: nil,
                                        weekday: nil,
                                        weekdayOrdinal: nil,
                                        quarter: nil,
                                        weekOfMonth: nil,
                                        weekOfYear: nil,
                                        yearForWeekOfYear: nil
                                    )
            
                        
                                    var dateOfContact = Calendar.current.date(from: contactTime)!
                                    if !(Calendar.current.date(byAdding: .day, value: -14, to: Date())! > dateOfContact){
                                        updatedNotificationsArr.append(Notification(i))
                                    }
                                }else{
                                    let time=Notification(i).date.dateValue()
                                    if !(Calendar.current.date(byAdding: .day, value: -14, to: Date())! > time){
                                        updatedNotificationsArr.append(Notification(i))
                                    }
                                }
                            }
                        }
                        if notificationsArr.count != updatedNotificationsArr.count{
                            var notificationsDict=[[:]]
                            for i in updatedNotificationsArr{
                                if i.title != ""{
                                    notificationsDict.append(i.asDict())
                                }
                            }
                            docRef.setData([
                                "notifications": notificationsDict
                            ], merge: true) { err in
                                if let err = err {
                                    print("Error writing document: \(err)")
                                } else {
                                    print("Document successfully written!")
                                }
                            }
                            notificationsArr=updatedNotificationsArr
                        }
                    self.notifications=notificationsArr
                    self.status = data["status"]! as! String == "negative" ? InfectionStatus.negative : InfectionStatus.positive
                    self.timeStart = data["timeStart"]! as! Timestamp
                    if self.status == .positive{
                        self.quarantineDate = data["quarantineDate"]! as! Timestamp
                        if Date() >= Calendar.current.date(byAdding: .day, value: 14, to: self.quarantineDate.dateValue())!{
                            self.status = .negative
                            docRef.setData([
                                "status": "negative"
                            ], merge: true) { err in
                                if let err = err {
                                    print("Error writing document: \(err)")
                                } else {
                                    print("Document successfully written!")
                                }
                            }
                        }
                    }
                    self.riskAssesment = self.evaluateRisk()
                    print("New Value", self.riskAssesment)
                    
                }
            }
            print("New Val 3", self.riskAssesment)
        }
    }

    func checkIfUserExited() -> Bool{
        Auth.auth().signInAnonymously() { (authResult, error) in
            guard let user = authResult?.user else { return }
            let uid = user.uid
            let db = Firestore.firestore()
            db.collection("users").document(uid).getDocument { (document, error) in
                if let document = document, document.exists {
                    //Do Nothing Yet
                    print("Fetching User Variables 3...")
                    if let data = document.data() {
                        self.enterLocation = data["enterLocation"]! as! Bool
                    } else {
                        print("Data could not be unpacked")
                        exit(0)
                    }
                    print("New Val 2", self.riskAssesment)
                }
            }
        }
        return self.enterLocation
    }
    
    func evaluateRisk() -> RiskValues{
        var riskAssesment: RiskValues
        //Insert risk assesment algorithm
        if status == .positive{
            riskAssesment = .red
        }else{
            var arrOfNotifications=[Notification]()
            var average=0
            for i in self.notifications{
                if i.contactChainLength != 0{
                    arrOfNotifications.append(i)
                    average+=i.contactChainLength
                }
            }
            if arrOfNotifications.count != 0{
                average/=arrOfNotifications.count
                if average <= 3{
                    //Small chain length
                    if arrOfNotifications.count >= 3{
                        riskAssesment = .red
                    }else if arrOfNotifications.count >= 1{
                        riskAssesment = .yellow
                    }else{
                        riskAssesment = .green
                    }
                }else if average <= 7{
                    //Medium chain length
                    if arrOfNotifications.count >= 5{
                        riskAssesment = .red
                    }else if arrOfNotifications.count >= 2{
                        riskAssesment = .yellow
                    }else{
                        riskAssesment = .green
                    }
                }else{
                    //Long chain length
                    if arrOfNotifications.count >= 10{
                        riskAssesment = .red
                    }else if arrOfNotifications.count >= 4{
                        riskAssesment = .yellow
                    }else{
                        riskAssesment = .green
                    }
                }
            }else{
                riskAssesment = .green
            }
        }
        return riskAssesment
    }
    
    
    func checkInfection(_ results: SurveyQuestions) {
        Auth.auth().signInAnonymously() { (authResult, error) in
            guard let user = authResult?.user else { return }
            let uid = user.uid
            //Put logic from answers here
            //Remove default value
            var resultsDict=[String: Bool]()
            for question in results.arrOfQuestions{
                resultsDict[question.question]=question.answer
            }
            var score = 0
            if resultsDict["If you were tested for COVID-19, was your result positive?"]!{
                score += 30
            }
            if resultsDict["Do you have a sore throat, cough, chills, body aches for unknown reasons, shortness of breath for unknown reasons, loss of smell or taste, fever at or greater than 100 degrees Fahrenheit?"]!{
                score += 15
            }
            if resultsDict["To the best of your knowledge have you been in close proximity to any individual who tested positive for COVID-19?"]!{
                score += 15
            }
            if resultsDict["Have you or anyone in your household traveled abroad in the past 21 days?"]!{
                score += 15
            }
            if resultsDict["Have you or anyone in your household been tested positive for COVID-19?"]!{
                score += 15
            }
            if resultsDict["Have you or anyone in your household visited or received treatment in a hospital, nursing home, long-term care, or other health care facility in the past 30 days?"]!{
                score += 15
            }
            if score >= 25{
                let db=Firestore.firestore()
                let docRef=db.collection("users").document(uid)
                self.quarantineDate=Timestamp(date: Calendar.current.date(byAdding: .day, value: score>=60 ? 14: 7, to: Date())!)
                docRef.setData([
                    "status": "positive",
                    "quarantineDate": self.quarantineDate
                ], merge: true) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
                User.alertContactedUsers(uid)
                self.evaluateRisk()
                self.temporaryAlert="14 days of quarantine"
            }else{
                self.temporaryAlert=""
            }
        }
    }
    
    func performEvaluation(_ results: SurveyQuestions?) -> String{
        if let results=results{
            var resultsDict=[String: Bool]()
            for question in results.arrOfQuestions{
                resultsDict[question.question]=question.answer
            }
            var score = 0
            if resultsDict["If you were tested for COVID-19, was your result positive?"]!{
                score += 30
            }
            if resultsDict["Do you have a sore throat, cough, chills, body aches for unknown reasons, shortness of breath for unknown reasons, loss of smell or taste, fever at or greater than 100 degrees Fahrenheit?"]!{
                score += 15
            }
            if resultsDict["To the best of your knowledge have you been in close proximity to any individual who tested positive for COVID-19?"]!{
                score += 15
            }
            if resultsDict["Have you or anyone in your household traveled abroad in the past 21 days?"]!{
                score += 15
            }
            if resultsDict["Have you or anyone in your household been tested positive for COVID-19?"]!{
                score += 15
            }
            if resultsDict["Have you or anyone in your household visited or received treatment in a hospital, nursing home, long-term care, or other health care facility in the past 30 days?"]!{
                score += 15
            }
            if score >= 60{
                return "14 days of quarantine"
            }else if score >= 25{
                //Just warn user to quarantine for 5-7 days for safety
                return "5-7 days of quarantine"
            }else{
                return ""
            }
        }else{
            return "Default"
        }
    }

    func checkEndTime() -> Date {
        Auth.auth().signInAnonymously() { (authResult, error) in
            guard let user = authResult?.user else { return }
            let uid = user.uid
            self.anon_uuid=uid
            print("UUID", uid)
            print("First bruh", self.anon_uuid)
            //Check if new user or not.
            let db = Firestore.firestore()
            
            let docRef = db.collection("users").document(self.anon_uuid)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    //Do Nothing Yet
                    print("Fetching User Variables 1...")
                    if let data = document.data() {
                        self.endLocationRequests = data["endLocationRequests"]! as! [String: String]
                        self.enterLocation = data["enterLocation"]! as! Bool
                        self.locationsVisited=data["locationsVisited"]! as! [[String: Any]]
                        let notification = data["notifications"]! as! [[String: Any]]
                        var notificationsArr=[Notification]()
                        for i in notification{
                            if !i.isEmpty{
                                notificationsArr.append(Notification(i))
                            }
                        }
                        self.notifications=notificationsArr
                        self.status = data["status"]! as! String == "negative" ? InfectionStatus.negative : InfectionStatus.positive
                        self.timeStart = data["timeStart"]! as! Timestamp
                        self.riskAssesment=self.evaluateRisk()
                        print("New Value", self.riskAssesment)
                    } else {
                        print("Data could not be unpacked")
                        exit(0)
                    }
                    print("New Val 2",self.riskAssesment)
                }
            }
        }
        return self.timeStart.dateValue()
    }
    
    func enterLocation(_ location: Location){
        Auth.auth().signInAnonymously() { (authResult, error) in
            guard let user = authResult?.user else { return }
            
            let uid = user.uid
            let db = Firestore.firestore()
            
            db.collection("users").document(uid).getDocument { (document, error) in
                if let document = document, document.exists {
                    //Do Nothing Yet
                    print("Fetching User Variables 3...")
                    if let data = document.data() {
                        self.endLocationRequests = data["endLocationRequests"]! as! [String: String]
                        self.enterLocation = data["enterLocation"]! as! Bool
                        self.locationsVisited=data["locationsVisited"]! as! [[String: Any]]
                        let notification = data["notifications"]! as! [[String: Any]]
                        var notificationsArr=[Notification]()
                        for i in notification{
                            notificationsArr.append(Notification(i))
                        }
                        self.notifications=notificationsArr
                        self.status = data["status"]! as! String == "negative" ? InfectionStatus.negative : InfectionStatus.positive
                        self.timeStart = data["timeStart"]! as! Timestamp
                        self.riskAssesment = self.evaluateRisk()
                        print("New Value", self.riskAssesment)
                        
                        if location.name != "Default Value"{
                            print("Unique Value: ", self.locationsVisited)
                            let currentTime=Timestamp()
                            self.enterLocation=true
                            self.endLocationRequests=["name": location.name, "address": location.address]
                            self.timeStart=currentTime
                            let docRef=db.collection("users").document(uid)
                            var notificationsDict=[[:]]
                            for i in self.notifications{
                                if i.title != ""{
                                    notificationsDict.append(i.asDict())
                                }
                            }
                            docRef.setData([
                                "anon_uuid": self.anon_uuid,
                                "endLocationRequests": self.endLocationRequests,
                                "enterLocation": self.enterLocation,
                                "locationsVisited": self.locationsVisited,
                                "notifications": notificationsDict,
                                "status": self.status == .negative ? "negative" : "positive",
                                "timeStart": self.timeStart
                            ], merge: true) { err in
                                if let err = err {
                                    print("Error writing document: \(err)")
                                } else {
                                    print("Document successfully written!")
                                }
                            }
                        }
                    } else {
                        print("Data could not be unpacked")
                        exit(0)
                    }
                    print("New Val 2",self.riskAssesment)
                }
            }
        }
    }
    
    
    func exitLocation(_ location: Location, _ endingTime: Date = Date()){
        Auth.auth().signInAnonymously() { (authResult, error) in
            guard let user = authResult?.user else { return }
            let uid = user.uid
            //Calender Object
            let calendar=Calendar.current
            
            //Starting Time HERE
            var startingTime: Date=self.timeStart.dateValue()
            
            // We want to extract the year, month, and day from firstLandLineCallDate
            let startingTimeComponents = calendar.dateComponents([.timeZone, .year, .month, .day, .hour, .minute, .second], from: startingTime)
            
            var roundedMinute: Int = 0
            if startingTimeComponents.minute! <= 30 && startingTimeComponents.minute! >= 15{
                roundedMinute=15
            }else if startingTimeComponents.minute! <= 45{
                roundedMinute=30
            }else{
                roundedMinute=45
            }
            let roundedTimeComponents = DateComponents(
                calendar: nil,
                timeZone: startingTimeComponents.timeZone!,
                era: nil,
                year: startingTimeComponents.year!,
                month: startingTimeComponents.month!,
                day: startingTimeComponents.day!,
                hour: startingTimeComponents.hour!,
                minute: roundedMinute,
                second: 0,
                nanosecond: nil,
                weekday: nil,
                weekdayOrdinal: nil,
                quarter: nil,
                weekOfMonth: nil,
                weekOfYear: nil,
                yearForWeekOfYear: nil)
            
            // 3
            var roundedDate = calendar.date(from: roundedTimeComponents)!
            
            var arr=[String]()
            while roundedDate<=endingTime{
                let timeComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: roundedDate)
                arr.append(String(timeComponents.hour!)+":"+String(timeComponents.minute!)+"-"+String(timeComponents.month!)+"-"+String(timeComponents.day!)+"-"+String(timeComponents.year!))
                roundedDate=roundedDate.addingTimeInterval(60*15)
            }
            let db=Firestore.firestore()
            for time in arr{
                let docRef=db.collection("locations").whereField("address", isEqualTo: self.endLocationRequests["address"])
                docRef.getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        let document=querySnapshot?.documents[0]
                        let documentId=document!.documentID
                        if let data = document?.data(){
                            print("Updating Stats")
                            location.numOfPeopleToday = data["numOfPeopleToday"] as! [String]
                            location.numOfCasesThisWeek = data["numOfCasesThisWeek"] as! [String]
                            location.numOfPeopleToday.append(time)
                            if self.status == .positive{
                                location.numOfCasesThisWeek.append(time)
                            }
                            db.collection("locations").document(documentId).setData([
                                "numOfPeopleToday": location.numOfPeopleToday,
                                "numOfCasesThisWeek": location.numOfCasesThisWeek
                            ], merge: true) { err in
                                if let err = err {
                                 print("Error writing document: \(err)")
                                } else {
                                    print("Document successfully written!")
                                }
                            }
                        
                            let finalDocRef=db.collection("locations").document(documentId).collection("date").document(time)
                            finalDocRef.getDocument { (document, error) in
                                if let document = document, document.exists {
                                    if let data = document.data() {
                                        var users = data["users"]! as! [String]
                                        users.append(self.anon_uuid)
                                        finalDocRef.setData([
                                            "users": users
                                        ]) { err in
                                            if let err = err {
                                                print("Error writing document: \(err)")
                                            } else {
                                                print("Document successfully written!")
                                            }
                                        }
                                    }
                                } else {
                                    print("Creating New Time")
                                    finalDocRef.setData([
                                        "users": [self.anon_uuid]
                                    ]) { err in
                                        if let err = err {
                                            print("Error writing document: \(err)")
                                        } else {
                                            print("Document successfully written!")
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
            //If status positive then alert contacted users
            if self.status == .positive{
                User.alertContactedUsers(self.anon_uuid, roundedDate)
            }
            //End of For Loop
            let docRef=db.collection("users").document(uid)
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    //Do Nothing Yet
                    print("Fetching User Variables 4...")
                    if let data = document.data() {
                        self.endLocationRequests = data["endLocationRequests"]! as! [String: String]
                        self.enterLocation = data["enterLocation"]! as! Bool
                        self.locationsVisited=data["locationsVisited"]! as! [[String: Any]]
                        let notification = data["notifications"]! as! [[String: Any]]
                        var notificationsArr=[Notification]()
                        for i in notification{
                            notificationsArr.append(Notification(i))
                        }
                        self.notifications=notificationsArr
                        self.status = data["status"]! as! String == "negative" ? InfectionStatus.negative : InfectionStatus.positive
                        self.timeStart = data["timeStart"]! as! Timestamp
                        self.riskAssesment=self.evaluateRisk()
                        print("New Value", self.riskAssesment)
                        
                        print("Unique Value: ", self.locationsVisited)
                        let currentTime=Timestamp()
                        self.enterLocation=false
                        self.locationsVisited.append(["name": location.name, "address": location.address, "times": arr])
                        self.endLocationRequests=[:]
                        self.timeStart=Timestamp()
                        let docRef=db.collection("users").document(uid)
                        
                        var notificationsDict=[[:]]
                        for i in self.notifications{
                            if i.title != ""{
                                notificationsDict.append(i.asDict())
                            }
                        }
                        docRef.setData([
                            "anon_uuid": self.anon_uuid,
                            "endLocationRequests": self.endLocationRequests,
                            "enterLocation": self.enterLocation,
                            "locationsVisited": self.locationsVisited,
                            "notifications": notificationsDict,
                            "status": self.status == .negative ? "negative" : "positive",
                            "timeStart": self.timeStart
                        ], merge: true) { err in
                            if let err = err {
                                print("Error writing document: \(err)")
                            } else {
                                print("Document successfully written!")
                            }
                        }
                    } else {
                        print("Data could not be unpacked")
                        exit(0)
                    }
                    print("New Val 2",self.riskAssesment)
                }
            }
        }
    }

    static func alertContactedUsers(_ startingUid: String, _ dateOfContact: Date? = nil){
        //Preparation
        var finalDict: [String: Date?] = [startingUid: dateOfContact]
        var edgesTraversed = 1
        var currentLevelOfNodes = [startingUid]
        //End loop once there are no more users to warn
        while currentLevelOfNodes != []{
            for node in currentLevelOfNodes{
                //Get Neighbors
                let db=Firestore.firestore()
                let docRef=db.collection("users").document(node)
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        //Getting locations user visited
                        print("Running Alert Function...")
                        if let data = document.data() {
                            let endLocationRequests = data["endLocationRequests"]! as! [String: String]
                            let enterLocation = data["enterLocation"]! as! Bool
                            let locationsVisited=data["locationsVisited"]! as! [[String: Any]]
                            let notificationsFromDatabase = data["notifications"]! as! [[String: Any]]
                            var arrOfNotifications=[Notification]()
                            for notification in notificationsFromDatabase{
                                if !notification.isEmpty{
                                    arrOfNotifications.append(Notification(notification))
                                }
                            }
                            var notifications=arrOfNotifications
                            let status = data["status"]! as! String == "negative" ? InfectionStatus.negative : InfectionStatus.positive
                            let timeStart = data["timeStart"]! as! Timestamp
                    
                            var notificationsDict=[[:]]
                            for i in notifications{
                                if i.title != ""{
                                     notificationsDict.append(i.asDict())
                                }
                            }
                            print("Got all data from function")

                            //Iterating through all locations
                            for location in locationsVisited{
                                db.collection("locations").whereField("address", isEqualTo: location["address"]).getDocuments() { (querySnapshot, err) in
                                    if let err = err {
                                        print("Error getting documents: \(err)")
                                    } else {
                                        //Finding documentID after searching with query
                                        let document=querySnapshot?.documents[0]
                                        let documentId=document!.documentID

                                        //Iterating through times of visits
                                        for time in location["times"] as! [String]{
                                            if let contactDate = finalDict[node]!{
                                                let calendar = Calendar.current
                                                let timeArr=time.split(separator: "-")
                                                let hourAndMinutes=timeArr[0].split(separator: ":")
                                                let hour=hourAndMinutes[0]
                                                let minute=hourAndMinutes[1]
                                                let month=timeArr[1]
                                                let day=timeArr[2]
                                                let year=timeArr[3]
                                                let contactTime = DateComponents(
                                                    calendar: nil,
                                                    timeZone: nil,
                                                    era: nil,
                                                    year: Int(year),
                                                    month: Int(month),
                                                    day: Int(day),
                                                    hour: Int(hour),
                                                    minute: Int(minute),
                                                    second: nil,
                                                    nanosecond: nil,
                                                    weekday: nil,
                                                    weekdayOrdinal: nil,
                                                    quarter: nil,
                                                    weekOfMonth: nil,
                                                    weekOfYear: nil,
                                                    yearForWeekOfYear: nil
                                                )
                                                var dateToBeChecked = calendar.date(from: contactTime)!
                                                //Skipping this time if it is earlier than date of contact
                                                if dateToBeChecked < contactDate{
                                                    continue
                                                }
                                            }

                                            //Fetching all contacted users using space-time stamp
                                            let finalDocRef=db.collection("locations").document(documentId).collection("date").document(time)
                                            finalDocRef.getDocument { (document, error) in
                                                if let document = document, document.exists {
                                                    if let data = document.data() {
                                                        var users = data["users"]! as! [String]
                                                        print("Found these users \(users) at \(location)")

                                                        //Iterating through all users
                                                        for user in users{
                                                            //Checks that this is the first time reaching this node and that this isn't the start node.
                                                            if !(finalDict.keys.contains(user)) && user != node{
                                                                print("Found in nested for loop", user)
                                                                //Making new notification
                                                                notifications.append(Notification("Contacted Possible Infected User", "You were in close proximity to an infected user at \(location["address"]!).", Timestamp(), edgesTraversed, location["address"] as! String+"_"+time))
                                                                var notificationsDict=[[:]]
                                                                for i in notifications{
                                                                        if i.title != ""{
                                                                            notificationsDict.append(i.asDict())
                                                                        }
                                                                }

                                                                //Save notifications in Firestore
                                                                db.collection("users").document(user).setData([
                                                                    "anon_uuid": user,
                                                                    "notifications": notificationsDict
                                                                ], merge: true) { err in
                                                                    if let err = err {
                                                                        print("Error writing document: \(err)")
                                                                    } else {
                                                                        print("Document successfully written!")
                                                                    }
                                                                }

                                                                //Converting time to limit next level search
                                                                let calendar=Calendar.current
                                                                let timeArr=time.split(separator: "-")
                                                                let hourAndMinutes=timeArr[0].split(separator: ":")
                                                                let hour=hourAndMinutes[0]
                                                                let minute=hourAndMinutes[1]
                                                                let month=timeArr[1]
                                                                let day=timeArr[2]
                                                                let year=timeArr[3]
                                                                let contactTime = DateComponents(
                                                                    calendar: nil,
                                                                    timeZone: nil,
                                                                    era: nil,
                                                                    year: Int(year),
                                                                    month: Int(month),
                                                                    day: Int(day),
                                                                    hour: Int(hour),
                                                                    minute: Int(minute),
                                                                    second: nil,
                                                                    nanosecond: nil,
                                                                    weekday: nil,
                                                                    weekdayOrdinal: nil,
                                                                    quarter: nil,
                                                                    weekOfMonth: nil,
                                                                    weekOfYear: nil,
                                                                    yearForWeekOfYear: nil
                                                                )
            
                        
                                                                var newDateOfContact = calendar.date(from: contactTime)!

                                                                //BFS Processing. Enqueuing new entry and marking current user with time for next run.
                                                                finalDict[user] = newDateOfContact
                                                                currentLevelOfNodes.append(user)
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        } else {
                            print("Data could not be unpacked")
                            exit(0)
                        }
                    }
                }
                //Pop Value from Queue
                currentLevelOfNodes.remove(at: 0)
            }
            //Once layer is checked, chain length must be increased.
            edgesTraversed+=1
        }
    }
}


