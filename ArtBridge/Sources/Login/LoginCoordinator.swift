//
//  LoginCoordinator.swift
//  ArtBridge
//
//  Created by 김창규 on 6/4/24.
//

import UIKit

enum LoginResult {
    case loginSuccess
}

final class LoginCoordinator: BaseCoordinator<LoginResult> {
    //MARK: - Properties
    var component: LoginComponent
    
    //MARK: - Init
    init(
        component: LoginComponent,
        navController: UINavigationController
    ) {
        self.component = component
        super.init(navController: navController)
    }
    
    override func start(animated: Bool) {
        let scene = component.scene
        navigationController.pushViewController(scene.VC, animated: animated)
        
        closeSignal
            .debug()
            .bind { [weak self] result in
//                defer { scene.VC.removeFromParent() }
                switch result {
                case .loginSuccess:
                    break
                }
            }.disposed(by: sceneDisposeBag)
        
        scene.VM.routes.loginSuccess
            .debug()
            .map { _ in LoginResult.loginSuccess }
            .bind(to: closeSignal)
            .disposed(by: sceneDisposeBag)
    }
}
