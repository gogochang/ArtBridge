//
//  DetailNewsViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 5/21/24.
//

import Foundation
import RxSwift

final class DetailNewsViewModel {
    private var disposeBag = DisposeBag()
    var inputs = Input()
    var routes = Route()
    
    init() {
        inputs.backward
            .bind(to: routes.bacward)
            .disposed(by: disposeBag)
    }
    
    struct Input {
        var backward = PublishSubject<Void>()
    }
    
    struct Route {
        var bacward = PublishSubject<Void>()
    }
}
