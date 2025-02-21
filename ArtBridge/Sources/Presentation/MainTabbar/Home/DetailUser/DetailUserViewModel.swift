//
//  DetailUserViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 2/21/25.
//

import Foundation
import RxSwift

struct DetailUserViewModelInput {
    
}

struct DetailUserViewModelOutput {
    
}

struct DetailUserViewModelRouteInputs {
    
}

struct DetailUserViewModelRoute {
    var backward = PublishSubject<Void>()
}

protocol DetailUserViewModel {
    // MARK: - Binding
    func transform(input: DetailUserViewModelInput) -> DetailUserViewModelOutput
    
    // MARK: - Route
    var routeInputs: DetailUserViewModelRouteInputs { get }
    var routes: DetailUserViewModelRoute { get }
}

final class DefaultDetailUserViewModel: BaseViewModel, DetailUserViewModel {
    // MARK: - Properties
    private var disposeBag = DisposeBag()
    
    var routes = DetailUserViewModelRoute()
    var routeInputs = DetailUserViewModelRouteInputs()
    
    // MARK: - Init
    override init() {
        super.init()
    }
    
    // MARK: - Output
    
    // MARK: - Binding
    func transform(input: DetailUserViewModelInput) -> DetailUserViewModelOutput {
        return DetailUserViewModelOutput()
    }
    
    // MARK: - Methods
}
