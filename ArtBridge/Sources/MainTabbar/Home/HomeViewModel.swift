//
//  HomeViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 4/25/24.
//


import UIKit
import RxSwift

final class HomeViewModel {
    //MARK: - properties
    private var disposeBag = DisposeBag()
    private var homeData: HomeDataModel?
    var inputs = Input()
    var outputs = Output()
    var routeInputs = RouteInput()
    var routes = Route()
    
    var categories: [String] = []
    // MARK: - Init
    init(
        homeAPIService: HomeAPIService = HomeAPIService()
    ) {
        categories = ["피아노", "플루트", "하프", "바이올린", "호른", "오카리나"]
        
        homeAPIService.fetchHomeData()
            .subscribe(onNext: { [weak self] homeData in
                self?.homeData = homeData
                self?.outputs.homeData.onNext(homeData)
            }, onError: { error in
                print("Error: \(error.localizedDescription)")
            }).disposed(by: disposeBag)
        
        outputs.categories.onNext(categories.map { CategoryConfig(title: $0)})
    }
    
    struct RouteInput {
        var needUpdate = PublishSubject<Bool>()
    }
    
    struct Input {
        //Navbar
        var showAlarm = PublishSubject<Void>()
        
        var showDetailInstrument = PublishSubject<Void>()
        var showPopularPostList = PublishSubject<HeaderType>()
        var showDetailPost = PublishSubject<Int>()
        var showDetailTutor = PublishSubject<Int>()
        var showDetailNews = PublishSubject<Int>()
    }
    
    struct Output {
        var homeData = PublishSubject<HomeDataModel>()
        var categories = ReplaySubject<[CategoryConfig]>.create(bufferSize: 1)
    }
    
    struct Route {
        //Navbar
        var alarm = PublishSubject<Void>()
        
        var detailInstrument = PublishSubject<Void>()
        var popularPostList = PublishSubject<HeaderType>()
        var detailPost = PublishSubject<Int>()
        var detailTutor = PublishSubject<Int>()
        var detailNews = PublishSubject<Int>()
    }
}
