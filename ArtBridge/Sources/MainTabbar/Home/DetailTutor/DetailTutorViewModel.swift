//
//  DetailTutorViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 5/17/24.
//

import Foundation
import RxSwift

final class DetailTutorViewModel {
    private var disposeBag = DisposeBag()
    var inputs = Input()
    var outputs = Output()
    var routeInputs = RouteInput()
    var routes = Route()
    
    init(
        tutorID: Int,
        tutorAPIService: TutorAPIService = TutorAPIService()
    ) {
        
        tutorAPIService.fetchDetailTutor(tutorID: tutorID)
            .subscribe(onNext: { [weak self] postData in
                self?.outputs.tutorData.onNext(postData)
            }, onError: { error in
                print("Error: \(error.localizedDescription)")
            }).disposed(by: disposeBag)
        
        tutorAPIService.fetchUserData(userID: 0)
            .subscribe(onNext: { [weak self] userData in
                self?.outputs.userData.onNext(userData)
            }, onError: { error in
                print("Error: \(error.localizedDescription)")
            }).disposed(by: disposeBag)
        
        inputs.backward
            .bind(to: routes.backward)
            .disposed(by: disposeBag)
        
        inputs.message
            .bind(to: routes.showmMssage)
            .disposed(by: disposeBag)
    }
    
    struct RouteInput {
        var needUpdate = PublishSubject<Bool>()
    }
    
    struct Input {
        var backward = PublishSubject<Void>()
        var message = PublishSubject<Void>()
    }
    
    struct Output {
        var tutorData = ReplaySubject<ContentDataModel>.create(bufferSize: 1)
        var userData = ReplaySubject<UserDataModel>.create(bufferSize: 1)
    }
    
    struct Route {
        var backward = PublishSubject<Void>()
        var showmMssage = PublishSubject<Void>()
    }
}
