//
//  MessageListViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 4/29/24.
//

import UIKit
import RxSwift

final class MessageListViewModel {
    private var disposeBag = DisposeBag()
    var input = Input()
    var routeInputs = RouteInput()
    var routes = Route()
    
    init() {
        routeInputs.needUpdate
            .filter { $0 }
            .bind { result in
                print("EEEEEE")
            }.disposed(by: disposeBag)
        
        input.message
            .bind(to: routes.showMessage)
            .disposed(by: disposeBag)
    }
    struct RouteInput {
        var needUpdate = PublishSubject<Bool>()
    }
    
    struct Input {
        var message = PublishSubject<Void>()
    }
    
    struct Route {
        var showMessage = PublishSubject<Void>()
    }
}
