//
//  DetailNoticeViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 1/26/25.
//

import Foundation
import RxSwift

final class DetailNoticeViewModel: BaseViewModel {
    //MARK: - Properties
    struct Input {
        var backward = PublishSubject<Void>()
    }
    
    struct Output {
        
    }
    
    struct Route {
        var backward = PublishSubject<Void>()
    }
    
    struct RouteInputs {
        
    }
    
    private var disposeBag = DisposeBag()
    var inputs = Input()
    var outputs = Output()
    var routes = Route()
    var routeInputs = RouteInputs()
    
    //MARK: - Init
    override init() {
        super.init()
        
        inputs.backward
            .bind(to: routes.backward)
            .disposed(by: disposeBag)
    }
    
    //MARK: - Methods
}

