//
//  PostListViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 2/8/25.
//

import Foundation
import RxSwift

final class PostListViewModel: BaseViewModel {
    // MARK: - Properties
    struct Input {
        var showDetailPost = PublishSubject<Int>()
    }
    
    struct Output {
        
    }
    
    struct Route {
        var backward = PublishSubject<Void>()
        var detailPostList = PublishSubject<Int>()
    }
    
    struct RouteInputs {
        var needUpdate = PublishSubject<Bool>()
    }
    
    private var disposeBag = DisposeBag()
    var inputs = Input()
    var outputs = Output()
    var routes = Route()
    var routeInputs = RouteInputs()
    
    // MARK: - Init
    override init() {
        super.init()
        
        inputs.showDetailPost
            .bind(to: routes.detailPostList)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Methods
}
