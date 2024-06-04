//
//  LoginViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 6/4/24.
//

import RxSwift

final class LoginViewModel {
    //MARK: - Properties
    private var disposeBag = DisposeBag()
    
    var inputs = Input()
    var outputs = Output()
    var routes = Route()
    
    //MARK: - Init
    init() {
        inputs.kakaoLogin
            .debug()
            .bind { [weak self] _ in
                self?.routes.loginSuccess.onNext(true)
            }.disposed(by: disposeBag)
        inputs.naverLogin
            .debug()
            .bind { [weak self] _ in
                self?.routes.loginSuccess.onNext(true)
            }.disposed(by: disposeBag)
        
        inputs.appleLogin
            .debug()
            .bind { [weak self] _ in
                self?.routes.loginSuccess.onNext(true)
            }.disposed(by: disposeBag)
    }
    
    struct Input {
        var kakaoLogin = PublishSubject<Void>()
        var naverLogin = PublishSubject<Void>()
        var appleLogin = PublishSubject<Void>()
    }
    
    struct Output {
        let loginFailure = PublishSubject<Void>()
    }
    
    struct Route {
        let loginSuccess = PublishSubject<Bool>()
    }
}
