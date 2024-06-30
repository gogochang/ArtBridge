//
//  NewsAPIService.swift
//  ArtBridge
//
//  Created by 김창규 on 6/30/24.
//

import Foundation
import RxSwift

final class NewsAPIService {
    //MARK: - Properties
    
    //MARK: - Init
    init() {}
    
    //MARK: - Internal Methods
    func fetchDetailNews(newsID: Int) -> Observable<ContentDataModel> {
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
}
