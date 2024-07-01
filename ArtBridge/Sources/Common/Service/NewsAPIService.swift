//
//  NewsAPIService.swift
//  ArtBridge
//
//  Created by 김창규 on 6/30/24.
//

import Foundation
import RxSwift

struct DetailNewsDataModel: Hashable {
    let news: ContentDataModel
    let author: UserDataModel
}

final class NewsAPIService {
    //MARK: - Properties
    
    //MARK: - Init
    init() {}
    
    //MARK: - Observable
    func fetchDetailNews(newsID: Int) -> Observable<DetailNewsDataModel> {
        let newsDataObservable = fetchDetailNews2(newsID: newsID)
        
        return newsDataObservable.flatMap { newsData in
            self.fetchNewsUser(userID: newsData.userId)
                .map { authorData in
                    DetailNewsDataModel(
                        news: newsData,
                        author: authorData
                    )
                }
        }
    }
    //MARK: - Internal Methods
    func fetchDetailNews2(newsID: Int) -> Observable<ContentDataModel> {
        return Observable.create { observer in
            FirestoreService.shared.fetchDocuments(
                collection: "news",
                type: ContentDataModel.self,
                limit: 1,
                filter: (field: "id", isEqualTo: newsID)
            ) { newsData in
                if let newsData = newsData?.first {
                    observer.onNext(newsData)
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
    
    func fetchNewsUser(userID: Int) -> Observable<UserDataModel> {
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
