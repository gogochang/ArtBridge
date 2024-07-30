//
//  CreatePostCoordinator.swift
//  ArtBridge
//
//  Created by 김창규 on 7/30/24.
//

import UIKit
enum CreatePostResult {
    case backward
}

final class CreatePostCoordinator: BaseCoordinator<CreatePostResult> {
    //MARK: - Properties
    var component: CreatePostComponent
    
    //MARK: - Init
    init(
        component: CreatePostComponent,
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
            .map { CreatePostResult.backward }
            .bind(to: closeSignal)
            .disposed(by: sceneDisposeBag)
    }
}
