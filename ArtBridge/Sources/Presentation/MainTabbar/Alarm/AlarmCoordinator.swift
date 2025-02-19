//
//  AlarmCoordinator.swift
//  ArtBridge
//
//  Created by 김창규 on 6/16/24.
//

import UIKit

enum AlarmResult {
    case backward
}

final class AlarmCoordinator: BaseCoordinator<AlarmResult> {
    var component: AlarmComponent
    
    init(component: AlarmComponent,
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
            .map { AlarmResult.backward }
            .bind(to: closeSignal)
            .disposed(by: sceneDisposeBag)
    }
}
