//
//  PostAPIService.swift
//  ArtBridge
//
//  Created by 김창규 on 6/19/24.
//

import Foundation
import FirebaseFirestore

final class PostAPIService {
    let db = Firestore.firestore()
    
    init() {
//        Firestore에 데이터 작성
//        let newPostDoc = db.collection("post").document()
//        newPostDoc.setData(["id":newPostDoc.documentID, "title":"Title01", "content":"Content01"])
        
        // FireStore으로부터 "post"컬렉션의 모든 데이터 조회
        db.collection("post").getDocuments { snapshot, error in
            if error == nil && snapshot != nil {
                for document in snapshot!.documents {
                    print(document.documentID)
                }
            } else {
                print("ERROR")
            }
        }
    }
}
