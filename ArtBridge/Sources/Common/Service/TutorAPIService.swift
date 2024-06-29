//
//  TutorAPIService.swift
//  ArtBridge
//
//  Created by 김창규 on 6/28/24.
//

import Foundation
import RxSwift

struct UserDataModel: Decodable {
    let id: Int
    let nickname: String
}

final class TutorAPIService {
    //MARK: - Properties
    private let disposeBag = DisposeBag()
    
    //MARK: - Init
    init() {}
    
    //MARK: - Methods
    func fetchDetailTutor(tutorID: Int) -> Observable<ContentDataModel> {
        return Observable.create { observer in
            FirestoreService.shared.fetchDocuments(
                collection: "tutors",
                type: ContentDataModel.self,
                limit: 1,
                filter: (field: "id", isEqualTo: tutorID as Int)
            ) { postData in
                
                if let postData = postData?.first {
                    observer.onNext(postData)
                    observer.onCompleted()
                } else {
                    observer.onError(NSError(
                        domain: "HomeAPIService",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Failed to fetch home data"])
                    )
                }
            }
            return Disposables.create()
        }
    }
    
    func fetchUserData(userID: Int) -> Observable<UserDataModel> {
        return Observable.create { observer in
            FirestoreService.shared.fetchDocuments(
                collection: "users",
                type: UserDataModel.self,
                limit: 1,
                filter: (field: "id", isEqualTo: userID as Int)
            ) { userData in
                if let userData = userData?.first {
                    observer.onNext(userData)
                    observer.onCompleted()
                } else {
                    observer.onError(NSError(
                        domain: "TutorAPIService",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Failed to fetch home data"])
                    )
                }
            }
            return Disposables.create()
        }
    }
}
