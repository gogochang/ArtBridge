//
//  CreatePostViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 7/30/24.
//

import Foundation
import RxSwift

final class CreatePostViewModel {
    //MARK: - Properties
    private var disposeBag = DisposeBag()
    var routeInputs = RouteInput()
    var routes = Route()
    var inputs = Input()
    var outputs = Output()
    
    init() {
        inputs.backward
            .bind(to: routes.backward)
            .disposed(by: disposeBag)
    }
    
    struct RouteInput{
        
    }
    
    struct Input {
        var backward = PublishSubject<Void>()
    }
    
    struct Output {
        
    }
    
    struct Route {
        var backward = PublishSubject<Void>()
    }
}
