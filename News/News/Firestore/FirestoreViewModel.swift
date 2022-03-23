//
//  FirestoreViewModel.swift
//  News
//
//  Created by Bhavitha on 23/03/22.
//

import Foundation
import FirebaseFirestore
//import FirebaseFirestoreSwift


class FirestoreViewModel: ObservableObject {
    
   // @Published var history = [History]()
    let db = Firestore.firestore()
    
    func save(selectedNews: NSMutableDictionary) {
        
        guard let emailId = UserDefaults.standard.value(forKey: "email") as? String,
              let selectedNews =  selectedNews as? [String: Any] else {
            print("email id is nil")
            return
        }
        db.collection(emailId).document("news").collection("selected").addDocument(data: selectedNews) { err in
                if let err = err {
                    print("Error saving data to firestore")
                } else {
                   print("Document successfully written!")
                }
            }
    }
    
    func getData(deviceName: String) {
        
        
      /*  guard let emailId = UserDefaults.standard.value(forKey: HealthTrackerConstants.EMAIL_ID) as? String else {
            AppLogger.shared.error("email id is nil", module: HealthTrackerConstants.HISTORY)
            return
        }
        
        
        db.collection(emailId).document(HealthTrackerConstants.HISTORY).collection(deviceName)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        do {
                            let jsonData: NSData = try JSONSerialization.data(withJSONObject: document.data(), options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
                            let history = try JSONDecoder().decode(History.self, from: jsonData as Data)
                            self.history.append(history)
                        }
                        catch {
                            print("Error reading document: \(error)")
                        }
                        
                    }
                }
        }*/
    }
}
