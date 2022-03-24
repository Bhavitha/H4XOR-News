//
//  FirebaseDB.swift
//  News
//
//  Created by Bhavitha on 23/03/22.
//

import Foundation
import Firebase

class FirebaseDB: ObservableObject {
    
    private let database = Database.database().reference()
    var ref: DatabaseReference!
    @Published var selectdItem = [String]()
    var saveItems = [String]()
    var articleIds = [String]()
    
    func save(value: String) {
        //database.child("articleId").setValue(articleIds)
        self.articleIds.removeAll()
        database.child("articleId").observe(DataEventType.value, with: { snapshot in
            self.articleIds = (snapshot.value as? [String])!
            if !self.articleIds.contains(value) {
                self.articleIds.append(value)
            }
            self.database.child("articleId").setValue(self.articleIds)
        })
    }
    
    func read() {
        // ref = Database.database().reference()
        //database.child("articleId").observeSingleEvent(of: .value, with: { (snapshot) in
        //if let id = snapshot.value as? String {
        //print("The value from the database: \(id)")
           // self.selectdItem.append(id)
           
        //}
        //})
    }
    
}


