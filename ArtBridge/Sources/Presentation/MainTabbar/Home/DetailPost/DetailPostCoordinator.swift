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
    
    // MARK: - Init
    init(
        component: DetailPostComponent,
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
            .map { PostDetailResult.backward }
            .bind(to: closeSignal)
            .disposed(by: sceneDisposeBag)
        
        scene.VM.routes.comentBottomSheet
            .debug()
            .map { (vm: scene.VM, postId: $0) }
            .bind { [weak self] inputs in
                self?.pushComentBottomSheetScene(
                    vm: inputs.vm,
                    postId: inputs.postId,
                    animated: true
                )
            }.disposed(by: sceneDisposeBag)
    }
    
    private func pushComentBottomSheetScene(vm: DetailPostViewModel, postId: Int, animated: Bool) {
        let comp = component.comentBottmSheet(postId: postId)
        let coord = ComentBottomSheetCoordinator(component: comp, navController: navigationController)
        
        coordinate(coordinator: coord, animated: animated) { coordResult in
            switch coordResult {
            case .backward:
                vm.routeInputs.needUpdate.onNext(false)
            }
            
        }
    }
}
