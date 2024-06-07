//
//  SettingCoordinator.swift
//  ArtBridge
//
//  Created by 김창규 on 6/7/24.
//

import UIKit

enum SettingResult {
    case backward
}

final class SettingCoordinator: BaseCoordinator<SettingResult> {
    var component: SettingComponent
    
    //MARK: - Init
    init(
        component: SettingComponent,
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
            .map { SettingResult.backward }
            .bind(to: closeSignal)
            .disposed(by: sceneDisposeBag)
    }
    
}
