//
//  DetailPostViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 5/12/24.
//

import Foundation
import RxSwift

final class DetailPostViewModel {
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
