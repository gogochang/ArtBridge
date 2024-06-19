//
//  FirebaseService.swift
//  ArtBridge
//
//  Created by 김창규 on 6/19/24.
//

import Foundation
import FirebaseFirestore
struct HomeDataModel: Decodable {
    var bannerUrls:[String]
    
    enum CodingKeys: String, CodingKey {
        case bannerUrls = "bannerUrls"
    }
}

class FirestoreService {
    static let shared = FirestoreService()
    let db = Firestore.firestore()
    
    
    func fetchDocument<T: Decodable>(collection: String, documentId: String, type: T.Type, completion: @escaping (T?) -> Void) {
        db.collection(collection).document(documentId).getDocument { snapshot, error in
            if let error = error {
                print("Error fetching document: \(error)")
                completion(nil)
                return
            }
            
            guard let data = snapshot?.data() else {
                print("Document data was empty.")
                completion(nil)
                return
            }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                let decodedData = try JSONDecoder().decode(type, from: jsonData)
                completion(decodedData)
            } catch {
                print("Error decoding data: \(error)")
                completion(nil)
            }
        }
    }
}
