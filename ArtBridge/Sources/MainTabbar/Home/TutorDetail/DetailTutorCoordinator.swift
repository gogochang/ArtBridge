//
//  DetailTutorCoordinator.swift
//  ArtBridge
//
//  Created by 김창규 on 5/17/24.
//

import UIKit

enum DetailTutorResult {
    case backward
}

final class DetailTutorCoordinator: BaseCoordinator<DetailTutorResult> {
    var component: DetailTutorComponent
    
    //MARK: - Init
    init(component: DetailTutorComponent,
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
            .map { DetailTutorResult.backward }
            .bind(to: closeSignal)
            .disposed(by: sceneDisposeBag)
    }
}
