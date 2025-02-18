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
    
    init(
        homeAPIService: HomeAPIService = HomeAPIService()
    ) {
        homeAPIService.fetchHomeData()
            .subscribe(onNext: { [weak self] homeData in
                self?.homeData = homeData
                self?.outputs.homeData.onNext(homeData)
            }, onError: { error in
                print("Error: \(error.localizedDescription)")
            }).disposed(by: disposeBag)
        
        inputs.showAlarm
            .bind(to: routes.alarm)
            .disposed(by: disposeBag)
        
        inputs.showPopularPostList
            .bind(to: routes.popularPostList)
            .disposed(by: disposeBag)
        
        inputs.showDetailPost
            .compactMap { self.homeData?.popularPosts[$0].id }
            .bind(to: routes.detailPost)
            .disposed(by: disposeBag)
        
        inputs.showDetailTutor
            .compactMap { self.homeData?.popularTutors[$0].id }
            .bind(to: routes.detailTutor)
            .disposed(by: disposeBag)
        
        inputs.showDetailNews
            .bind(to: routes.detailNews)
            .disposed(by: disposeBag)
        
        inputs.showDetailInstrument
            .bind(to: routes.detailInstrument)
            .disposed(by: disposeBag)
        
        inputs.showInfoList
            .bind(to: routes.infoList)
            .disposed(by: disposeBag)
        
        inputs.showUserList
            .bind(to: routes.userList)
            .disposed(by: disposeBag)
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
        
        var showInfoList = PublishSubject<Void>()
        var showUserList = PublishSubject<Void>()
    }
    
    struct Output {
        var homeData = PublishSubject<HomeDataModel>()
    }
    
    struct Route {
        //Navbar
        var alarm = PublishSubject<Void>()
        
        var detailInstrument = PublishSubject<Void>()
        var popularPostList = PublishSubject<HeaderType>()
        var detailPost = PublishSubject<Int>()
        var detailTutor = PublishSubject<Int>()
        var detailNews = PublishSubject<Int>()
        
        var infoList = PublishSubject<Void>()
        var userList = PublishSubject<Void>()
    }
}
