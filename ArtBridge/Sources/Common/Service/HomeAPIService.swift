//
//  HomeAPIService.swift
//  ArtBridge
//
//  Created by 김창규 on 6/19/24.
//

import Foundation
import RxSwift
import FirebaseFirestore

//TODO: 모델로 이동
struct HomeDataModel: Decodable {
    var bannerUrls: [HomeBannerDataModel]
    var popularPosts: [PostDataModel]
    
    enum CodingKeys: String, CodingKey {
        case bannerUrls = "bannerUrls"
        case popularPosts = "popularPosts"
    }
}

struct PostDataModel: Decodable {
    let id: String
    let title: String
    let content: String
    let coverURLs: String
    var likeCount: Int
}

struct HomeBannerDataModel: Decodable {
    let URL: String
}

final class HomeAPIService {
    //MARK: - Properties
    private let disposeBag = DisposeBag()
    
    //MARK: - Init
    init() {}
    
    //MARK: - Observable
    func fetchHomeData() -> Observable<HomeDataModel> {
        let homeDataObservable = fetchBannerData()
        let popularPostsObservable = fetchHomePopularPostsData()
        
        return Observable.zip(
            homeDataObservable,
            popularPostsObservable
        ) { homeBanners, popularPosts in
            return HomeDataModel(
                bannerUrls: homeBanners,
                popularPosts: popularPosts
            )
        }
    }
    
    func fetchBannerData() -> Observable<[HomeBannerDataModel]> {
        return Observable.create { observer in
            FirestoreService.shared.fetchDocuments(
                collection: "homeBanners",
                type: HomeBannerDataModel.self
            ) { homeBannerData in
                if let homeBannerData = homeBannerData {
                    observer.onNext(homeBannerData)
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
    
    func fetchHomePopularPostsData() -> Observable<[PostDataModel]> {
        return Observable.create { observer in
            FirestoreService.shared.fetchDocuments(
                collection: "post",
                type: PostDataModel.self,
                limit: 5
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
