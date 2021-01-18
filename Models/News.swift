//

//  News.swift

//  CovidTracker

//

//  Created by Software Development HS_902 on 11/14/20.

//  Copyright © 2020 Software Development HS_902. All rights reserved.

//



import UIKit

import WebKit

import Firebase

import FirebaseFirestore

import FirebaseStorage



@available(iOS 14.0, *)
class NewsPost: Identifiable{
    
    var title: String
    
    var body: String
    
    var image: UIImage
    
    var date: Timestamp
    
    var uid = UUID().uuidString
    
    
    init(_ title: String, _ body: String, _ image: UIImage, _ date: Timestamp){
        
        self.title=title
        
        self.body=body
        
        self.image=image
        
        self.date = date
        
        self.exportToFirebase()
        
        
        
        /*
         let db = Firestore.firestore()
         
         
         
         let docRef = db.collection("News").document()
         
         
         
         docRef.getDocument { (document, error) in
         
         if let document = document, document.exists {
         
         //Document Exists
         
         print("Fetching User Variables...")
         
         if let data = document.data() {
         
         self.title = data["title"] as? String ?? ""
         
         self.body = data["body"] as? String ?? ""
         
         let imageURI = data["imageURI"] as? String ?? ""
         
         self.date = data["date"] as? Timestamp ?? Timestamp()
         
         
         
         let storage = Storage.storage()
         
         let imageRef = storage.reference(withPath: "news/" + String(self.date.hash) + ".jpg")
         
         imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
         
         if let error = error {
         
         print("ERROR: Image could not be downloaded.")
         
         } else {
         
         self.image = UIImage(data: data!)!
         
         }
         
         }
         
         } else {
         
         print("Data could not be unpacked")
         
         exit(0)
         
         }
         
         } else {
         
         //Document doesn't exist
         
         //Only add post to Firestore
         
         self.exportToFirebase()
         
         }
         
         }
         
         */
        
    }
    
    init(_ title: String, _ body: String, _ image: UIImage, _ date: Timestamp, _ uid: String) {
        self.title=title
        
        self.body=body
        
        self.image=image
        
        self.date = date
        
        self.uid = uid
    }
    
    
    func exportToFirebase() {
        
        let db = Firestore.firestore()
        
        let docRef=db.collection("News").document()
        
        docRef.setData([
            
            "title": self.title,
            
            "body": self.body,
            
            "imageURI": "news/" + String(self.date.hash) + ".jpg",
            
            "date": self.date,
            
            "uid": self.uid
            
            
            
            
        ]) { err in
            
            if let err = err {
                
                print("Error writing document: \(err)")
                
            } else {
                
                print("Document successfully written!")
                
            }
            
        }
        
        //Put qrCode in location
        
        let storage = Storage.storage()
        
        let imageRef = storage.reference(withPath: "news/" + String(self.date.hash) + ".jpg")
        
        
        
        // Upload the file to the path "images/rivers.jpg"
        
        let uploadTask = imageRef.putData(self.image.jpegData(compressionQuality: 0.9)!, metadata: nil) { (metadata, error) in
            
            guard let metadata = metadata else {
                
                // Uh-oh, an error occurred!
                
                print("Image was not uploaded!")
                
                return
                
            }
            
            // Metadata contains file metadata such as size, content-type.
            
            let size = metadata.size
            
            // You can also access to download URL after upload.
            
            imageRef.downloadURL { (url, error) in
                
                guard let downloadURL = url else {
                    
                    // Uh-oh, an error occurred!
                    
                    print("Url was not valid!")
                    
                    return
                    
                }
                
            }
            
        }
        
        
        
    }
    
    
}










