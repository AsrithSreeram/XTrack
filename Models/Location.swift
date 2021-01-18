//
//  Location.swift
//  CovidTracker
//
//  Created by Software Development HS_902 on 11/14/20.
//  Copyright © 2020 Software Development HS_902. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

@available(iOS 14.0, *)
class Location: ObservableObject{
    @Published var name: String = "Default Value"
    @Published var address: String
    @Published var numOfPeopleToday: [String] = []
    @Published var numOfCasesThisWeek: [String] = []
    static var existsMessage: String=""
    
    init(_ address: String) {
        //User creates QR
        self.address=address
        let db = Firestore.firestore()
        db.collection("locations").whereField("address", isEqualTo: self.address)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    print("Maybe Error", self.address)
                    print("Query Results", querySnapshot?.documents, querySnapshot?.count)
                    print("Location Recieved", querySnapshot?.documents[0].data())
                    let data: [String:Any] = (querySnapshot?.documents[0].data())!
                    if !data.isEmpty {
                        //Document Exists
                        print("Fetching Location Variables...")
                        self.name = data["name"] as! String
                        self.address = data["address"] as! String
                        self.numOfPeopleToday = data["numOfPeopleToday"] as! [String]
                        self.numOfCasesThisWeek = data["numOfCasesThisWeek"] as! [String]
                        var updatedNumOfPeopleArr=[String]()
                        for i in self.numOfPeopleToday{
                            let calendar = Calendar.current
                            let timeArr=i.split(separator: "-")
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
                            var enterDate = calendar.date(from: contactTime)!
                            let currentTime = Date()
                            let today = DateComponents(
                                calendar: nil,
                                timeZone: nil,
                                era: nil,
                                year: calendar.component(.year, from: currentTime),
                                month: calendar.component(.month, from: currentTime),
                                day: calendar.component(.day, from: currentTime),
                                hour: nil,
                                minute: nil,
                                second: nil,
                                nanosecond: nil,
                                weekday: nil,
                                weekdayOrdinal: nil,
                                quarter: nil,
                                weekOfMonth: nil,
                                weekOfYear: nil,
                                yearForWeekOfYear: nil
                            )
                            var todayDate = calendar.date(from: today)!
                            if enterDate >= todayDate{
                                updatedNumOfPeopleArr.append(i)
                            }
                        }
                        var updatedNumOfCasesThisWeekArr=[String]()
                        for i in self.numOfCasesThisWeek{
                            let calendar = Calendar.current
                            let timeArr=i.split(separator: "-")
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
                            var enterDate = calendar.date(from: contactTime)!
                            let currentTime = Date()
                            let today = DateComponents(
                                calendar: nil,
                                timeZone: nil,
                                era: nil,
                                year: calendar.component(.year, from: currentTime),
                                month: calendar.component(.month, from: currentTime),
                                day: calendar.component(.day, from: currentTime),
                                hour: nil,
                                minute: nil,
                                second: nil,
                                nanosecond: nil,
                                weekday: nil,
                                weekdayOrdinal: nil,
                                quarter: nil,
                                weekOfMonth: nil,
                                weekOfYear: nil,
                                yearForWeekOfYear: nil
                            )
                            var todayDate = calendar.date(from: today)!
                            var aWeekAgo = calendar.date(byAdding: .day, value: -7, to: todayDate)!
                            if enterDate >= aWeekAgo{
                                updatedNumOfCasesThisWeekArr.append(i)
                            }
                        }
                        let db = Firestore.firestore()
                        let docRef=db.collection("locations").document((querySnapshot?.documents[0].documentID)!)
                        print("Date Updates", updatedNumOfPeopleArr, updatedNumOfCasesThisWeekArr)
                        if updatedNumOfPeopleArr.count != self.numOfPeopleToday.count || updatedNumOfCasesThisWeekArr.count != self.numOfCasesThisWeek.count{
                            docRef.setData([
                                "numOfPeopleToday": updatedNumOfPeopleArr,
                                "numOfCasesThisWeek": updatedNumOfCasesThisWeekArr
                            ], merge: true) { err in
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
    
    init(_ name: String, _ address: String) {
        //User creates QR
        self.name=name
        self.address=address
        let db = Firestore.firestore()
        db.collection("locations").whereField("address", isEqualTo: self.address)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    let documents = querySnapshot!.documents
                    if !documents.isEmpty {
                        //Document Exists
                        let data=documents[0].data()
                        print("Fetching Location Variables...")
                        self.name = data["name"] as! String
                        self.address = data["address"] as! String
                        self.numOfPeopleToday = data["numOfPeopleToday"] as! [String]
                        self.numOfCasesThisWeek = data["numOfCasesThisWeek"] as! [String]
                    } else {
                        self.exportToFirebase()
                    }
                    
                }
                
            }
        
    }
    
    func exportToFirebase() {
        let db = Firestore.firestore()
        let docRef=db.collection("locations").document()
        docRef.setData([
            "name": self.name,
            "address": self.address,
            "numOfPeopleToday": self.numOfPeopleToday,
            "numOfCasesThisWeek": self.numOfCasesThisWeek
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    static func exists(_ address: String) -> String{
        let db = Firestore.firestore()
        db.collection("locations").whereField("address", isEqualTo: address)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    if querySnapshot!.count>0{
                        Location.existsMessage="None"
                    }else{
                        Location.existsMessage="Error"
                    }
                }
            }
        return Location.existsMessage
    }

    func evaluateLocation() -> RiskValues{
        var riskAssesment: RiskValues
        if self.numOfPeopleToday.count != 0{
            let rateOfPositivity = Double(self.numOfCasesThisWeek.count)/Double(self.numOfPeopleToday.count)
            if rateOfPositivity >= 0.3{
                //Greater than 20% positivity rating
                riskAssesment = .red
            }else if rateOfPositivity >= 0.1{
                //Greater than 10% positivity rating
                riskAssesment = .yellow
            }else{
                //Less than 10% positivity rating
                riskAssesment = .green
            }
        }else{
            riskAssesment = .green
        }
        return riskAssesment
    }
}


