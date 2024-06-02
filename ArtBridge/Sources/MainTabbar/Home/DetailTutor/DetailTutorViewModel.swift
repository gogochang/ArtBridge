//
//  DetailTutorViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 5/17/24.
//

import Foundation
import RxSwift

final class DetailTutorViewModel {
    private var disposeBag = DisposeBag()
    var inputs = Input()
    var routeInputs = RouteInput()
    var routes = Route()
    
    init() {
        inputs.backward
            .bind(to: routes.backward)
            .disposed(by: disposeBag)
        
        inputs.message
            .bind(to: routes.showmMssage)
            .disposed(by: disposeBag)
    }
    
    struct RouteInput {
        var needUpdate = PublishSubject<Bool>()
    }
    
    struct Input {
        var backward = PublishSubject<Void>()
        var message = PublishSubject<Void>()
    }
    
    struct Route {
        var backward = PublishSubject<Void>()
        var showmMssage = PublishSubject<Void>()
    }
}
