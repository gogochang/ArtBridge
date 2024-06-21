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
    var popularTutors: [TutorDataModel]
    var news: [NewsDataModel]
    
    enum CodingKeys: String, CodingKey {
        case bannerUrls = "bannerUrls"
        case popularPosts = "popularPosts"
        case popularTutors = "popularTutors"
        case news = "news"
    }
}

struct PostDataModel: Decodable {
    let id: String
    let title: String
    let content: String
    let coverURLs: String
    var likeCount: Int
}

struct TutorDataModel: Decodable {
    let userIdx: Int
    let nickname: String
    let categoryType: Int
    let profileImgURL: String
    let likeCount: Int
}

struct NewsDataModel: Decodable {
    let index: Int
    let title: String
    let content: String
    let author: String
    let likeCount: Int
    let coverImgURL: String
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
        let popularTutorsObservable = fetchHomePopularTutorsData()
        let popularNewsObservable = fetchHomeNewsData()
        
        return Observable.zip(
            homeDataObservable,
            popularPostsObservable,
            popularTutorsObservable,
            popularNewsObservable
        ) { homeBanners, popularPosts, popularTutors, news in
            return HomeDataModel(
                bannerUrls      : homeBanners,
                popularPosts    : popularPosts,
                popularTutors   : popularTutors,
                news            : news
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
    
    func fetchHomePopularTutorsData() -> Observable<[TutorDataModel]> {
        return Observable.create { observer in
            FirestoreService.shared.fetchDocuments(
                collection: "tutors",
                type: TutorDataModel.self,
                limit: 5
            ) { tutorData in
                if let tutorData = tutorData {
                    print("seijfsjfs90jsf: \(tutorData)")
                    observer.onNext(tutorData)
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
    
    func fetchHomeNewsData() -> Observable<[NewsDataModel]> {
        return Observable.create { observer in
            FirestoreService.shared.fetchDocuments(
                collection: "news",
                type: NewsDataModel.self,
                limit: 5
            ) { newsData in
                if let newsData = newsData {
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
