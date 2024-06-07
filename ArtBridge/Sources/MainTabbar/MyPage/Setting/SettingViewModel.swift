//
//  SettingViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 6/7/24.
//

import UIKit
import RxSwift

final class SettingViewModel {
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
