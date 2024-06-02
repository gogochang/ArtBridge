//
//  DetailPostCoordinator.swift
//  ArtBridge
//
//  Created by 김창규 on 5/12/24.
//

import UIKit

enum PostDetailResult {
    case backward
}

final class DetailPostCoordinator: BaseCoordinator<PostDetailResult> {
    var component: DetailPostComponent
    
    //MARK: - Init
    init(
        component: DetailPostComponent,
        navController: UINavigationController
    ) {
        self.component = component
        super.init(navController: navController)
    }
    
    override func start(animated : Bool) {
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
            .map { PostDetailResult.backward }
            .bind(to: closeSignal)
            .disposed(by: sceneDisposeBag)
    }
}
