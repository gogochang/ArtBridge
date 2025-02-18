//
//  TutorAPIService.swift
//  ArtBridge
//
//  Created by 김창규 on 6/28/24.
//

import Foundation
import RxSwift

final class TutorAPIService {
    //MARK: - Properties
    private let disposeBag = DisposeBag()
    
    //MARK: - Init
    init() {}
    
    //MARK: - Methods
    func fetchDetailTutor(tutorId: Int) -> Observable<DetailTutorDataModel> {
        let tutorDataObservable = fetchDetailTutor2(tutorId: tutorId)
        
        return tutorDataObservable.flatMap { tutorData in
            self.fetchUserData(userID: tutorData.userId)
                .map { authorData in
                    DetailTutorDataModel(
                        tutor: tutorData,
                        author: authorData
                    )
                }
        }
    }
    
    func fetchDetailTutor2(tutorId: Int) -> Observable<ContentDataModel> {
        return Observable.create { observer in
            FirestoreService.shared.fetchDocuments(
                collection: "tutors",
                type: ContentDataModel.self,
                limit: 1,
                filter: (field: "id", isEqualTo: tutorId as Int)
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
    
    func fetchPostUser(userID: Int) -> Observable<UserDataModel> {
        return Observable.create { observer in
            FirestoreService.shared.fetchDocuments(
                collection: "users",
                type: UserDataModel.self,
                limit: 1,
                filter: (field: "id", isEqualTo: userID)
            ) { userData in
                if let userData = userData?.first {
                    observer.onNext(userData)
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
}
