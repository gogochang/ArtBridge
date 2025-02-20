//
//  UserListCoordinator.swift
//  ArtBridge
//
//  Created by 김창규 on 2/12/25.
//

import UIKit

enum UserResult {
case backward
}

final class UserListCoordinator: BaseCoordinator<UserResult> {
    var component: UserListComponent
    
    init(
        component: UserListComponent,
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
            .map { UserResult.backward }
            .bind(to: closeSignal)
            .disposed(by: sceneDisposeBag)
    }
}
