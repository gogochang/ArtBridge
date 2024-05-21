//
//  DetailNewsCoordinator.swift
//  ArtBridge
//
//  Created by 김창규 on 5/21/24.
//

import UIKit

enum DetailNewsResult {
    case backward
}

final class DetailNewsCoordinator: BaseCoordinator<DetailNewsResult> {
    var component: DetailNewsComponent
    
    //MARK: - Init
    init(component: DetailNewsComponent,
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
        
        scene.VM.routes.bacward
            .debug()
            .map { DetailNewsResult.backward }
            .bind(to: closeSignal)
            .disposed(by: sceneDisposeBag)
    }
}
