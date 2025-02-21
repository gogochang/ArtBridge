//
//  UserListCoordinator.swift
//  ArtBridge
//
//  Created by 김창규 on 2/12/25.
//

import UIKit

enum UserResult {
case backward
}

final class UserListCoordinator: BaseCoordinator<UserResult> {
    var component: UserListComponent
    
    init(
        component: UserListComponent,
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
            .map { UserResult.backward }
            .bind(to: closeSignal)
            .disposed(by: sceneDisposeBag)
        
        scene.VM.routes.detailUser
            .map { (vm: scene.VM, user: $0) }
            .bind { [weak self] inputs in
                self?.pushDetailUserScene(
                    vm: inputs.vm,
                    user: inputs.user,
                    animated: true
                )
                
            }.disposed(by: sceneDisposeBag)
    }
    
    private func pushDetailUserScene(
        vm: UserListViewModel,
        user: User,
        animated: Bool
    ) {
        let comp = component.detailUserComponent(user: user)
        let coord = DetailUserCoordinator(
            component: comp,
            navController: navigationController
        )
        
        coordinate(
            coordinator: coord,
            animated: animated
        ) { coordResult in
            switch coordResult {
            case .backward:
//                vm.routeInputs.needUpdate.onNext(false)
                break
            }
        }
    }
}
