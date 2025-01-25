//
//  MainTabViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 4/20/24.
//

import Foundation
import RxSwift

class MainTabViewModel {
    //MARK: - Properties
    private var disposeBag = DisposeBag()
    
    var inputs = Input()
    var outputs = Output()
    var routes = Route()
    
    init() {
        inputs.homeSelected
            .subscribe(onNext: { [weak self] in
                self?.changeSceneIfMember(to: 0)
            })
            .disposed(by: disposeBag)
        
        inputs.noticeSelected
            .subscribe(onNext: { [weak self] in
                self?.changeSceneIfMember(to: 1)
            }).disposed(by: disposeBag)
        
        
        inputs.communitySelected
            .subscribe(onNext: { [weak self] in
                self?.changeSceneIfMember(to: 2)
            })
            .disposed(by: disposeBag)
        
        inputs.myPageSelected
            .subscribe(onNext: { [weak self] in
                self?.changeSceneIfMember(to: 3)
            }).disposed(by: disposeBag)
        
    }
    
    private func changeSceneIfMember(to index: Int) {
        outputs.selectScene.onNext(index)
        switch index {
        case 0:
            routes.home.onNext(())
        case 1:
            routes.community.onNext(())
        case 2:
            routes.message.onNext(())
        case 3:
            routes.myPage.onNext(())
        default:
            break
        }
    }
    
    struct Input {
        var homeSelected = PublishSubject<Void>()
        var noticeSelected = PublishSubject<Void>()
        var communitySelected = PublishSubject<Void>()
        var myPageSelected = PublishSubject<Void>()
    }
    
    struct Output {
        var selectScene = PublishSubject<Int>()
    }
    
    struct Route {
        var home = PublishSubject<Void>()
        var community = PublishSubject<Void>()
        var message = PublishSubject<Void>()
        var myPage = PublishSubject<Void>()
    }
}
