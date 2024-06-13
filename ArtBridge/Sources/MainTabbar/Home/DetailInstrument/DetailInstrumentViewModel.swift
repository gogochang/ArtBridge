//
//  DetailInstrumentViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 6/13/24.
//

import Foundation
import RxSwift

final class DetailInstrumentViewModel {
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
