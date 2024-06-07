//
//  MyPageViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 4/29/24.
//

import UIKit
import RxSwift

final class MyPageViewModel {
    //MARK: - Properties
    private var disposeBag = DisposeBag()
    var inputs = Input()
    var routeInputs = RouteInput()
    var routes = Route()
    
    //MARK: - Init
    init() {
        inputs.showSetting
            .bind(to: routes.setting)
            .disposed(by: disposeBag)
    }
    
    struct RouteInput {
        var needUpdate = PublishSubject<Bool>()
    }
    
    struct Input {
        var showSetting = PublishSubject<Void>()
    }
    
    struct Route {
        var setting = PublishSubject<Void>()
    }
}
