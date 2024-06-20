//
//  FirebaseService.swift
//  ArtBridge
//
//  Created by 김창규 on 6/19/24.
//

import Foundation
import FirebaseFirestore

class FirestoreService {
    static let shared = FirestoreService()
    let db = Firestore.firestore()
    
    
    func fetchDocument<T: Decodable>(
        collection: String,
        documentId: String,
        type: T.Type,
        completion: @escaping (T?) -> Void
    ) {
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
                let jsonData = try JSONSerialization.data(withJSONObject: data)
                
                let decodedData = try JSONDecoder().decode(type, from: jsonData)
                
                completion(decodedData)
            } catch {
                print("Error decoding data: \(error)")
                completion(nil)
            }
        }
    }
    
    func fetchDocuments<T: Decodable>(
        collection: String,
        type: T.Type,
        order: String? = nil,
        limit: Int? = nil,
        completion: @escaping ([T]?) -> Void
    ) {
        var collection: Query = db.collection(collection)
        
        if let order = order {
            collection = collection.order(by: order)
        }
        
        if let limit = limit {
            collection = collection.limit(to: limit)
        }
        
        collection.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching document: \(error)")
                completion(nil)
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents found.")
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            let dataList = documents.compactMap { document in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: document.data())
                    let decodedData = try decoder.decode(T.self, from: jsonData)
                    return decodedData
                } catch {
                    print()
                    return nil
                }
            }
            completion(dataList)
        }
    }
}
