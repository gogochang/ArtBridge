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
                print("AAAAA")
                self?.changeSceneIfMember(to: 0)
            })
            .disposed(by: disposeBag)
    }
    
    private func changeSceneIfMember(to index: Int) {
        outputs.selectScene.onNext(index)
        routes.home.onNext(())
    }
    
    struct Input {
        var homeSelected = PublishSubject<Void>()
    }
    
    struct Output {
        var selectScene = PublishSubject<Int>()
    }
    
    struct Route {
        var home = PublishSubject<Void>()
    }
}
