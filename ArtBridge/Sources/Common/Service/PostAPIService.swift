//
//  PostAPIService.swift
//  ArtBridge
//
//  Created by 김창규 on 6/19/24.
//

import Foundation
import RxSwift

final class PostAPIService {
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    init() {}
    
    // MARK: - Methods
    func fetchDetailPost(postId: Int) -> Observable<DetailPostDataModel> {
        let postDataObservable = fetchDetailPost2(postId: postId)
        
        return postDataObservable.flatMap { postData in
            self.fetchPostUser(userID: postData.userId)
                .map { authorData in
                    DetailPostDataModel(
                        post: postData,
                        author: authorData
                    )
                }
        }
    }
    
    func fetchDetailPost2(postId: Int) -> Observable<ContentDataModel> {
        return Observable.create { observer in
            FirestoreService.shared.fetchDocuments(
                collection: "post",
                type: ContentDataModel.self,
                limit: 1,
                filter: (field: "id", isEqualTo: postId as Int)
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
    
    func fetchPopularPostList(listType: HeaderType) -> Observable<[ContentDataModel]> {
        return Observable.create { observer in
            FirestoreService.shared.fetchDocuments(
                collection: listType.rawValue,
                type: ContentDataModel.self,
                limit: 10
            ) { postData in
                if let postData = postData {
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
    
    func fetchPostUser(userID: Int) -> Observable<User> {
        return Observable.create { observer in
            FirestoreService.shared.fetchDocuments(
                collection: "users",
                type: User.self,
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
