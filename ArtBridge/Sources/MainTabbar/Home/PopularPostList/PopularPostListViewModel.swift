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
    var routes = Route()
    var inputs = Input()
    
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
