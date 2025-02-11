//
//  NoticeViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 1/25/25.
//

import Foundation
import RxSwift

final class NoticeViewModel: BaseViewModel {
    //MARK: - Properties
    struct Input {
        var showDetailPost = PublishSubject<Int>()
    }
    
    struct Output {
        
    }
    
    struct Route {
        var backward = PublishSubject<Void>()
        var detailNotice = PublishSubject<Int>()
    }
    
    struct RouteInputs {
        var needUpdate = PublishSubject<Bool>()
    }
    
    private var disposeBag = DisposeBag()
    var inputs = Input()
    var outputs = Output()
    var routes = Route()
    var routeInputs = RouteInputs()
    
    //MARK: - Init
    override init() {
        super.init()
        
        inputs.showDetailPost
//            .compactMap { self.homeData?.popularPosts[$0].id }
//            .compactMap { _ in 0 }
            .bind(to: routes.detailNotice)
            .disposed(by: disposeBag)
    }
    
    //MARK: - Methods
}

