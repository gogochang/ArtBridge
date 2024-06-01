//
//  MessageCoordinator.swift
//  ArtBridge
//
//  Created by 김창규 on 5/31/24.
//

import UIKit

enum ChatResult {
    case backward
}

final class MessageCoordinator: BaseCoordinator<ChatResult> {
    //MARK: - Properties
    var component: MessageComponent
    
    //MARK: - Init
    init(component: MessageComponent,
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
                switch result {
                case .backward:
                    self?.navigationController.popViewController(animated: true)
                }
            }.disposed(by: sceneDisposeBag)
        
        scene.VM.routes.backward
            .debug()
            .map { ChatResult.backward }
            .bind(to: closeSignal)
            .disposed(by: sceneDisposeBag)

    }
}
