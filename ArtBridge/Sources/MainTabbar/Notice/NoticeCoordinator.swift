//
//  NoticeCoordinator.swift
//  ArtBridge
//
//  Created by 김창규 on 1/25/25.
//

import UIKit

enum NoticeResult {
case backward
}

final class NoticeCoordinator: BaseCoordinator<NoticeResult> {
    var component: NoticeComponent
    
    init(
        component: NoticeComponent,
        navController: UINavigationController
    ) {
        self.component = component
        super.init(navController: navController)
    }
    
    override func start(animated: Bool = true) {
        let scene = component.scene
        navigationController.pushViewController(scene.VC, animated: animated)
        
        closeSignal
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .backward:
                    self?.navigationController.popViewController(animated: animated)
                }
                
            }).disposed(by: sceneDisposeBag)
        
        scene.VM.routes.backward
            .map { NoticeResult.backward }
            .bind(to: closeSignal)
            .disposed(by: sceneDisposeBag)
    }
}

