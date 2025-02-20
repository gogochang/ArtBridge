//
//  ComentBottomSheetCoordinator.swift
//  ArtBridge
//
//  Created by 김창규 on 2/9/25.
//

import UIKit

enum ComentBottomSheetResult {
case backward
}

final class ComentBottomSheetCoordinator: BaseCoordinator<ComentBottomSheetResult> {
    var component: ComentBottomSheetComponent
    
    init(
        component: ComentBottomSheetComponent,
        navController: UINavigationController
    ) {
        self.component = component
        super.init(navController: navController)
    }
    
    override func start(animated: Bool = true) {
        let scene = component.scene
        
        scene.VC.modalPresentationStyle = .overCurrentContext
        navigationController.present(scene.VC, animated: animated)
        
        closeSignal
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .backward:
                    scene.VC.dismiss(animated: animated)
                }
                
            }).disposed(by: sceneDisposeBag)
        
        scene.VM.routes.backward
            .map { ComentBottomSheetResult.backward }
            .bind(to: closeSignal)
            .disposed(by: sceneDisposeBag)
    }
}
