//
//  DatabaseManager.swift
//  News
//
//  Created by Bhavitha on 23/03/22.
//

import Foundation
import Firebase

class DatabaseManager: ObservableObject {
    
    private let database = Database.database().reference()
    var ref: DatabaseReference!
    @Published var selectdItems = [String]()
    var saveItems = [String]()
    var articleIds = [String]()
    
    func save(value: String) {
        self.articleIds.removeAll()
        database.child("articleId").observe(DataEventType.value, with: { snapshot in
            
            if snapshot.value as? [String] == nil {
                self.articleIds.append(value)
                self.database.child("articleId").setValue(self.articleIds)
            } else {
                self.articleIds = (snapshot.value as? [String])!
                if !self.articleIds.contains(value) {
                    self.articleIds.append(value)
                }
                self.database.child("articleId").setValue(self.articleIds)
            }
        })
    }
    
    func read(completion: @escaping (([String]) -> Void))  {
        
        database.child("articleId").observe(DataEventType.value, with: { snapshot in
            guard let snapshot =  snapshot.value as? [String]  else {
                completion([])
                return                
            }
            self.selectdItems = snapshot
            completion(self.selectdItems)
        })
    }
}


