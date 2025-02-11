//
//  DetailNoticeCoordinator.swift
//  ArtBridge
//
//  Created by 김창규 on 1/26/25.
//

import UIKit

enum DetailNoticeResult {
case backward
}

final class DetailNoticeCoordinator: BaseCoordinator<DetailNoticeResult> {
    var component: DetailNoticeComponent
    
    init(
        component: DetailNoticeComponent,
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
            .map { DetailNoticeResult.backward }
            .bind(to: closeSignal)
            .disposed(by: sceneDisposeBag)
    }
}

