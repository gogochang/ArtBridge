//
//  HomeViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 4/25/24.
//


import UIKit
import RxSwift

struct HomeViewModelInput {
    let fetchHome               : Observable<Int>
    
    var showAlarm               = PublishSubject<Void>()
    
    var showDetailInstrument    = PublishSubject<Void>()
    var showPopularPostList     = PublishSubject<HeaderType>()
    var showDetailPost          = PublishSubject<Int>()
    var showDetailTutor         = PublishSubject<Int>()
    var showDetailNews          = PublishSubject<Int>()
    
    var showInfoList            = PublishSubject<Void>()
    var showUserList            = PublishSubject<Void>()
}


struct HomeViewModelOutput {
    var homeData                = PublishSubject<HomeData>()
}

struct HomeViewModelRouteInput {
    var needUpdate              = PublishSubject<Bool>()
}

struct HomeViewModelRoute {
    var alarm                   = PublishSubject<Void>()
    
    var detailInstrument        = PublishSubject<Void>()
    var popularPostList         = PublishSubject<HeaderType>()
    var detailPost              = PublishSubject<Int>()
    var detailTutor             = PublishSubject<Int>()
    var detailNews              = PublishSubject<Int>()
    
    var infoList                = PublishSubject<Void>()
    var userList                = PublishSubject<Void>()
    var newsList                = PublishSubject<Void>()
}

protocol HomeViewModel {
    // MARK: - Binding
    func transform(input: HomeViewModelInput) -> HomeViewModelOutput
    
    // MARK: - Route
    var routeInputs: HomeViewModelRouteInput { get }
    var routes: HomeViewModelRoute { get }
}

final class DefaultHomeViewModel: HomeViewModel {
    // MARK: - properties
    private var disposeBag = DisposeBag()
    private var homeData: HomeData?
    private let fetchHomeUseCase: FetchHomeUseCase
    
    var routeInputs = HomeViewModelRouteInput()
    var routes = HomeViewModelRoute()
    
    // MARK: - Init
    init(fetchHomeUseCase: FetchHomeUseCase = DefaultFetchHomeUseCase()) {
        self.fetchHomeUseCase = fetchHomeUseCase
    }
    
    // MARK: - Output
    var fetchHomeData = PublishSubject<HomeData>()
    
    // MARK: - Binding
    func transform(input: HomeViewModelInput) -> HomeViewModelOutput {
        input.fetchHome
            .bind { [weak self] userId in
                self?.fetch(userId: userId)
            }.disposed(by: disposeBag)
        
        input.showAlarm
            .bind(to: routes.alarm)
            .disposed(by: disposeBag)
        
        input.showPopularPostList
            .bind(to: routes.popularPostList)
            .disposed(by: disposeBag)
        
        input.showDetailNews
            .bind(to: routes.detailNews)
            .disposed(by: disposeBag)
        
        input.showDetailInstrument
            .bind(to: routes.detailInstrument)
            .disposed(by: disposeBag)
        
        input.showInfoList
            .bind(to: routes.infoList)
            .disposed(by: disposeBag)
        
        input.showUserList
            .bind(to: routes.userList)
            .disposed(by: disposeBag)
        
        return HomeViewModelOutput(homeData: fetchHomeData.asObserver())
    }
    
    // MARK: - Methods
    // Private
    private func fetch(userId: Int) {
        fetchHomeUseCase.execute(requestValue: .init(userId: userId))
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] homeData in
                self?.fetchHomeData.onNext(homeData)
            }).disposed(by: disposeBag)
    }
    
}
