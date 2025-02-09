//
//  PostListCoordinator.swift
//  ArtBridge
//
//  Created by 김창규 on 2/8/25.
//

import UIKit

enum PostListResult {
case backward
}

final class PostListCoordinator: BaseCoordinator<PostListResult> {
    var component: PostListComponent
    
    init(
        component: PostListComponent,
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
            .map { PostListResult.backward }
            .bind(to: closeSignal)
            .disposed(by: sceneDisposeBag)
    }
}

