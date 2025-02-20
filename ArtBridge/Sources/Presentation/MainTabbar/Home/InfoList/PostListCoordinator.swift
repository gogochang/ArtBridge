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
        
        scene.VM.routes.detailPostList
            .map { (vm: scene.VM, postId: $0) }
            .bind { [weak self] inputs in
                self?.pushDetailPostScene(
                    vm: inputs.vm,
                    postID: inputs.postId,
                    animated: true
                )
            }.disposed(by: sceneDisposeBag)
    }
    
    private func pushDetailPostScene(vm: PostListViewModel, postID: Int, animated: Bool) {
        let comp = component.detailPostComponent(postID: postID)
        let coord = DetailPostCoordinator(component: comp, navController: navigationController)
        
        coordinate(coordinator: coord, animated: animated) { coordResult in
            switch coordResult {
            case .backward:
                vm.routeInputs.needUpdate.onNext(false)
            }
            
        }
    }
}
