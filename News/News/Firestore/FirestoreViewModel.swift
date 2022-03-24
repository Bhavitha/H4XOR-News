//
//  FirestoreViewModel.swift
//  News
//
//  Created by Bhavitha on 23/03/22.
//

import Foundation
import FirebaseFirestore

class FirestoreViewModel: ObservableObject {
    
    @Published var articles = [SelectedArticle]()
    let db = Firestore.firestore()
    
    func save(selectedNews: NSMutableDictionary) {
        
        guard let emailId = UserDefaults.standard.value(forKey: "email") as? String,
              let selectedNews =  selectedNews as? [String:Any] else {
            print("email id is nil")
            return
        }
        db.collection(emailId).addDocument(data: selectedNews) { err in
                if err != nil {
                    print("Error saving data to firestore")
                } else {
                   print("Document successfully written!")
                }
            }
    }
    
    func loadVisitedArticles() {
        
        
        guard let emailId = UserDefaults.standard.value(forKey: "email") as? String else {
           print("email id is nil")
            return
        }
                
        db.collection(emailId).getDocuments { snapshot, error in
            guard let err = error else {
                fatalError("error")
            }
                if let snapshot = snapshot {
                    
                    self.articles = snapshot.documents.map { article in
                        return SelectedArticle(id: article["id"] as? String ?? "", title: article["title"] as? String ?? "", url: article["url"] as? String ?? "", points: article["points"] as? Int ?? 0)
                    
                    }
                }
        }
    }
}
