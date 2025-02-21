//
//  DetailUserCoordinator.swift
//  ArtBridge
//
//  Created by 김창규 on 2/21/25.
//

import UIKit

enum DetailUserResult {
case backward
}

final class DetailUserCoordinator: BaseCoordinator<DetailUserResult> {
    var component: DetailUserComponent
    
    init(
        component: DetailUserComponent,
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
            .map { DetailUserResult.backward }
            .bind(to: closeSignal)
            .disposed(by: sceneDisposeBag)
    }
}
