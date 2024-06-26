//
//  PostAPIService.swift
//  ArtBridge
//
//  Created by 김창규 on 6/19/24.
//

import Foundation
import RxSwift

final class PostAPIService {
    //MARK: - Properties
    private let disposeBag = DisposeBag()
    
    //MARK: - Init
    init() {}
    
    //MARK: - Methods
    func fetchDetailPost(postID: Int) -> Observable<ContentDataModel> {
        return Observable.create { observer in
            FirestoreService.shared.fetchDocuments(
                collection: "post",
                type: ContentDataModel.self,
                limit: 1,
                filter: (field: "id", isEqualTo: postID as Int)
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
}
