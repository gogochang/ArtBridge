//
//  MessageViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 4/29/24.
//

import UIKit
import RxSwift

final class MessageViewModel {
    private var disposeBag = DisposeBag()
    
    var routeInputs = RouteInput()
    
    init() {
        routeInputs.needUpdate
            .filter { $0 }
            .bind { result in
                print("EEEEEE")
            }.disposed(by: disposeBag)
    }
    struct RouteInput {
        var needUpdate = PublishSubject<Bool>()
    }
}
