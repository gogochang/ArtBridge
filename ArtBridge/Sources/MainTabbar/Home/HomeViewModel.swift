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
    var inputs = Input()
    var routeInputs = RouteInput()
    var routes = Route()
    
    init() {
        inputs.showPopularPostList
            .bind(to: routes.popularPostList)
            .disposed(by: disposeBag)
        
        inputs.showDetailPost
            .bind(to: routes.detailPost)
            .disposed(by: disposeBag)
        
        inputs.showDetailTutor
            .bind(to: routes.detailTutor)
            .disposed(by: disposeBag)
        
        inputs.showDetailNews
            .bind(to: routes.detailNews)
            .disposed(by: disposeBag)
    }
    
    struct RouteInput {
        var needUpdate = PublishSubject<Bool>()
    }
    
    struct Input {
        var showPopularPostList = PublishSubject<Void>()
        var showDetailPost = PublishSubject<Void>()
        var showDetailTutor = PublishSubject<Void>()
        var showDetailNews = PublishSubject<Void>()
    }
    
    struct Route {
        var popularPostList = PublishSubject<Void>()
        var detailPost = PublishSubject<Void>()
        var detailTutor = PublishSubject<Void>()
        var detailNews = PublishSubject<Void>()
    }
}
