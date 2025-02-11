//
//  NoticeCoordinator.swift
//  ArtBridge
//
//  Created by 김창규 on 1/25/25.
//

import UIKit

enum NoticeResult {
case backward
}

final class NoticeCoordinator: BaseCoordinator<NoticeResult> {
    var component: NoticeComponent
    
    init(
        component: NoticeComponent,
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
            .map { NoticeResult.backward }
            .bind(to: closeSignal)
            .disposed(by: sceneDisposeBag)
        
        scene.VM.routes.detailNotice
            .map { (vm: scene.VM, postId: $0) }
            .bind { [weak self] inputs in
                self?.pushDetailPostScene(
                    vm: inputs.vm,
                    postID: inputs.postId,
                    animated: true
                )
            }.disposed(by: sceneDisposeBag)
        
    }
    
    private func pushDetailPostScene(vm: NoticeViewModel, postID: Int, animated: Bool) {
        let comp = component.detailNoticeComponent(postID: postID)
        let coord = DetailNoticeCoordinator(component: comp, navController: navigationController)
        
        coordinate(coordinator: coord, animated: animated) { coordResult in
            switch coordResult {
            case .backward:
                vm.routeInputs.needUpdate.onNext(false)
            }
            
        }
    }
}

