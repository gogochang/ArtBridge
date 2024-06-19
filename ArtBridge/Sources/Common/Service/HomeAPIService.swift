//
//  HomeAPIService.swift
//  ArtBridge
//
//  Created by 김창규 on 6/19/24.
//

import Foundation
import RxSwift
import FirebaseFirestore

final class HomeAPIService {
    private let disposeBag = DisposeBag()
    init() {
        
    }
    func fetchHomeData() -> Observable<HomeDataModel> {
        return Observable.create { observer in
            FirestoreService.shared.fetchDocument(collection: "home", documentId: "1sLkg0A4h0sXTZ30kIY7", type: HomeDataModel.self) { (homeData: HomeDataModel?) in
                if let homeData = homeData {
                    observer.onNext(homeData)
                    observer.onCompleted()
                } else {
                    observer.onError(NSError(domain: "HomeAPIService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch home data"]))
                }
            }
            
            return Disposables.create()
        }
    }
}
