//
//  AlarmViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 6/16/24.
//

import RxSwift

final class AlarmViewModel {
    private var disposeBag = DisposeBag()
    var inputs = Input()
    var routes = Route()
    
    init() {
        inputs.backward
            .bind(to: routes.backward)
            .disposed(by: disposeBag)
    }
    
    struct Input {
        var backward = PublishSubject<Void>()
    }
    
    struct Route {
        var backward = PublishSubject<Void>()
    }
}
