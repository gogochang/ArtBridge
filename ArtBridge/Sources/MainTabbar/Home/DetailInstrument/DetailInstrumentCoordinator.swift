//
//  DetailInstrumentCoordinator.swift
//  ArtBridge
//
//  Created by 김창규 on 6/13/24.
//

import UIKit

enum DetailInstrumentResult {
    case backward
}

final class DetailInstrumentCoordinator: BaseCoordinator<DetailInstrumentResult> {
    var component: DetailInstrumentComponent
    
    //MARK: - Init
    init(component: DetailInstrumentComponent,
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
            .map { DetailInstrumentResult.backward }
            .bind(to: closeSignal)
            .disposed(by: sceneDisposeBag)
    }
}
