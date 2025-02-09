//
//  InfoListViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 2/8/25.
//

import Foundation
import RxSwift

final class InfoListViewModel: BaseViewModel {
    //MARK: - Properties
    struct Input {
        
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
    }
    
    //MARK: - Methods
}

