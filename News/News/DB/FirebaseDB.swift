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
        //database.child("articleId").setValue("")
        database.child("articleId").observe(.value, with: { (snapshot) in
            self.articleIds = snapshot.value as? [String] ?? []
            print(self.articleIds)
            if self.articleIds == nil {
                self.articleIds = [String]()
            }
            
            self.articleIds.append(value)
            print(self.articleIds)
            //self.database.child("articleId").setValue(articleIds)
            
            
        })
        database.child("articletId").setValue(articleIds)
        //database.child("articleId").observe(.value, )
        //saveItems.append(value)
        //database.child("articleId").setValue("")
        
        // ref = Database.database().reference()
        //database.child("articleId").observeSingleEvent(of: .value, with: { (snapshot) in
        //if let id = snapshot.value as? String {
        //print("The value from the database: \(id)")
           // self.selectdItem.append(id)
          //  self.saveItems.append(id)
        //}
        //})
        //saveItems.append(value)
        //self.ref.child("articleId").setValue(saveItems)
        
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


