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
    
    func fetchPopularPostList(listType: HeaderType) -> Observable<[PostDataModel]> {
        print("listType:::: \(listType)")
        return Observable.create { observer in
            FirestoreService.shared.fetchDocuments(
                collection: listType.rawValue,
                type: PostDataModel.self,
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
