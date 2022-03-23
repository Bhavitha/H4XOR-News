//
//  FirestoreViewModel.swift
//  News
//
//  Created by Bhavitha on 23/03/22.
//

import Foundation
import FirebaseFirestore

class FirestoreViewModel: ObservableObject {
    
    @Published var articles = [String]()
    let db = Firestore.firestore()
    
    func save(selectedNews: NSMutableDictionary) {
        
        guard let emailId = UserDefaults.standard.value(forKey: "email") as? String,
              let selectedNews =  selectedNews as? [String:String] else {
            print("email id is nil")
            return
        }
        db.collection(emailId).document("news").collection("selected").addDocument(data: selectedNews) { err in
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
                
        db.collection(emailId).document("news").collection("visited")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.articles.append(document.get("id") as! String)
                    }
                }
        }
    }
}
