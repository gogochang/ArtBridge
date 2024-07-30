//
//  CommunityViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 4/28/24.
//

import UIKit
import RxSwift

final class CommunityViewModel {
    //MARK: - properties
    private var disposeBag = DisposeBag()
    var inputs = Input()
    var routes = Route()
    
    init() {
        inputs.showDetailPost
            .bind(to: routes.detailPost)
            .disposed(by: disposeBag)
        
        inputs.tappedCreatePost
            .bind(to: routes.createPost)
            .disposed(by: disposeBag)
    }
    
    var routeInputs = RouteInput()
    
    struct RouteInput {
        var needUpdate = PublishSubject<Bool>()
    }
    
    struct Input {
        var showDetailPost = PublishSubject<Void>()
        var tappedCreatePost = PublishSubject<Void>()
    }
    
    struct Route {
        var detailPost = PublishSubject<Void>()
        var createPost = PublishSubject<Void>()
    }
}
