import Firebase
import FirebaseFirestore

@available(iOS 14.0, *)
class NewsRepository: ObservableObject {
    @Published var newsPosts: [NewsPost] = [NewsPost]()
    var newsListener: ListenerRegistration?
    
    func getAllPosts(){
        let db = Firestore.firestore()
        let newsListener = db.collection("News").order(by: "date", descending: true).addSnapshotListener { (querySnapshot, error) in
            if let snapshot = querySnapshot {
                let queryResult = snapshot.documents
                for doc in queryResult{
                    let data = doc.data()
                    let title = data["title"] as! String
                    
                    let body = data["body"] as! String
                    
                    let imageURI = data["imageURI"] as! String
                    
                    let date = data["date"] as! Timestamp
                    
                    let uid = data["uid"] as! String
                    
                    
                    print("Cool", title, body, imageURI, date)
                    let storage = Storage.storage()
                    
                    let imageRef = storage.reference(withPath: imageURI)
                    
                    imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                        var image = UIImage()
                        if let error = error {
                            print("ERROR: Image could not be downloaded.")
                            print("Cause of Error", imageURI, uid)
                            
                        } else {
                            print("Got all data successfully to create new NewsPost")
                            image = UIImage(data: data!)!
                        }
                        self.newsPosts.append(NewsPost(title, body, image, date, uid))
                        print("New Data 2: " + String(self.newsPosts.count))
                        
                    }
                }
            }
        }
        self.newsListener=newsListener
    }
}
