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
    }
    
    struct RouteInput {
        var needUpdate = PublishSubject<Bool>()
    }
    
    struct Input {
        var showPopularPostList = PublishSubject<Void>()
    }
    
    struct Route {
        var popularPostList = PublishSubject<Void>()
    }
}
