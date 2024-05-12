//
//  PopularPostListViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 5/10/24.
//

import Foundation
import RxSwift

final class PopularPostListViewModel {
    private var disposeBag = DisposeBag()
    var routeInputs = RouteInput()
    var routes = Route()
    var inputs = Input()
    
    init() {
        inputs.backward
            .bind(to: routes.backward)
            .disposed(by: disposeBag)
        
        inputs.showDetailPost
            .bind(to: routes.detailPost)
            .disposed(by: disposeBag)
    }
    
    struct RouteInput {
        var needUpdate = PublishSubject<Bool>()
    }
    
    struct Input {
        var backward = PublishSubject<Void>()
        var showDetailPost = PublishSubject<Void>()
    }
    
    struct Route {
        var backward = PublishSubject<Void>()
        var detailPost = PublishSubject<Void>()
    }
}
