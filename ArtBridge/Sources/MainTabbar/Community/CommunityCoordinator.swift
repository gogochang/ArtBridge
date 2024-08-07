//
//  CommunityCoordinator.swift
//  ArtBridge
//
//  Created by 김창규 on 4/28/24.
//

import UIKit

final class CommunityCoordinator: BaseCoordinator<Void> {
    //MARK: - Properties
    var component: CommunityComponent
    
    //MARK: - Init
    init(
        component: CommunityComponent,
        navController: UINavigationController
    ) {
        self.component = component
        super.init(navController: navController)
    }
    
    override func start(animated _: Bool = true) {
        let scene = component.scene
        
        scene.VM.routes.detailPost
            .map { scene.VM }
            .bind { [weak self] vm in
                self?.pushDetailPostScene(vm: vm, animated: true)
            }.disposed(by: sceneDisposeBag)
        
        scene.VM.routes.createPost
            .map { scene.VM }
            .bind { [weak self] vm in
                self?.pushCreatePostScene(
                    vm: vm,
                    animated: true
                )
            }.disposed(by: sceneDisposeBag)
    }
    
    private func pushDetailPostScene(vm: CommunityViewModel, animated: Bool) {
        let comp = component.detailPostComponent(postID: 0)//FIXME: 임시로0처리
        let coord = DetailPostCoordinator(component: comp, navController: navigationController)
        
        coordinate(coordinator: coord, animated: animated) { coordResult in
            switch coordResult {
            case .backward:
                vm.routeInputs.needUpdate.onNext(false)
            }
            
        }
    }
    
    private func pushCreatePostScene(
        vm: CommunityViewModel,
        animated: Bool
    ) {
        let comp = component.createPostComponent
        let coord = CreatePostCoordinator(
            component: comp,
            navController: navigationController
        )
        
        coordinate(coordinator: coord, animated: animated) { coordResult in
            switch coordResult {
            case .backward:
                vm.routeInputs.needUpdate.onNext(false)
            }
        }
        
    }
}
