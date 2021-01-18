//
//  Notifications.swift
//  CovidTracker
//
//  Created by Software Development HS_902 on 12/20/20.
//  Copyright © 2020 Software Development HS_902. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import UserNotifications

class Notification: Identifiable {
    let id=UUID().uuidString
    let title: String
    let body: String
    let date: Timestamp
    let contactChainLength: Int
    let timeOfContact: String
    let notified: Bool
    
    init(_ title: String, _ body: String, _ date: Timestamp, _ contactChainLength: Int = 0, _ timeOfContact: String = "", _ notified: Bool = false){
        self.title=title
        self.body=body
        self.date=date
        self.contactChainLength=contactChainLength
        self.timeOfContact=timeOfContact
        self.notified = notified
    }

    init(_ dict: [String: Any]){
        self.title=dict["title"] as? String ?? ""
        self.body=dict["body"] as? String ?? ""
        self.date=dict["date"] as? Timestamp ?? Timestamp()
        self.contactChainLength=dict["contactChainLength"] as? Int ?? 0
        self.timeOfContact=dict["timeOfContact"] as? String ?? ""
        self.notified = dict["notified"] as? Bool ?? false
    }

    func asDict() -> [String: Any] {
        return ["title": self.title, "body": self.body, "date": self.date, "contactChainLength": self.contactChainLength, "timeOfContact": self.timeOfContact, "notified": self.notified]
    }
    
   
}
