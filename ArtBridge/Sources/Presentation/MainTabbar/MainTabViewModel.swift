//
//  MainTabViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 4/20/24.
//

import UIKit
import RxSwift

struct MainTabViewModelInput {
    var homeSelected: Observable<UITapGestureRecognizer>
    var adevertiseSelected: Observable<UITapGestureRecognizer>
    var postSelected: Observable<UITapGestureRecognizer>
    var myPageSelected: Observable<UITapGestureRecognizer>
}

struct MainTabViewModelOutput {
    var selectScene         = PublishSubject<Int>()
}

struct MainTabViewModelRoute {
    var home                = PublishSubject<Void>()
    var community           = PublishSubject<Void>()
    var message             = PublishSubject<Void>()
    var myPage              = PublishSubject<Void>()
}

protocol MainTabViewModel {
    // MARK: - Binding
    func transform(input: MainTabViewModelInput) -> MainTabViewModelOutput
}

final class DefaultMainTabViewModel: MainTabViewModel {
    // MARK: - Properties
    private var disposeBag = DisposeBag()
    
    // MARK: - Init
    init() {}
    
    // MARK: - Output
    var selectedScene = PublishSubject<Int>()
    
    // MARK: - Binding
    func transform(input: MainTabViewModelInput) -> MainTabViewModelOutput {
        input.homeSelected
            .map { _ in 0 }
            .bind(to: selectedScene)
            .disposed(by: disposeBag)
        
        input.adevertiseSelected
            .map { _ in 1 }
            .bind(to: selectedScene)
            .disposed(by: disposeBag)
        
        input.postSelected
            .map { _ in 2 }
            .bind(to: selectedScene)
            .disposed(by: disposeBag)
        
        input.myPageSelected
            .map { _ in 3 }
            .bind(to: selectedScene)
            .disposed(by: disposeBag)
        
        return MainTabViewModelOutput(selectScene: selectedScene.asObserver())
    }
}
