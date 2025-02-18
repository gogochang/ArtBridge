//
//  HomeCoordinator.swift
//  ArtBridge
//
//  Created by 김창규 on 4/26/24.
//

import UIKit

final class HomeCoordinator: BaseCoordinator<Void> {
    //MARK: - Properties
    var component: HomeComponent
    
    //MARK: - Init
    init(
        component: HomeComponent,
        navController: UINavigationController
    ) {
        self.component = component
        super.init(navController: navController)
    }
    
    override func start(animated _: Bool = true) {
        let scene = component.scene
        
        scene.VM.routes.alarm
            .map { scene.VM }
            .bind { [weak self] vm in
                self?.pushAlarmScene(vm: vm, animated: true)
            }.disposed(by: sceneDisposeBag)

        scene.VM.routes.detailPost
            .map { (vm: scene.VM, postId: $0) }
            .bind { [weak self] inputs in
                self?.pushDetailPostScene(
                    vm: inputs.vm,
                    postID: inputs.postId,
                    animated: true
                )
            }.disposed(by: sceneDisposeBag)
        
        scene.VM.routes.infoList
            .map { scene.VM }
            .bind { [weak self] vm in
                self?.pushInfoListScene(
                    vm: vm,
                    animated: true
                )
            }.disposed(by: sceneDisposeBag)
        
        scene.VM.routes.userList
            .map { scene.VM }
            .bind { [weak self] vm in
                self?.pushUserListScene(
                    vm: vm,
                    animated: true
                )
            }.disposed(by: sceneDisposeBag)
    }
    
    private func pushAlarmScene(vm: HomeViewModel, animated: Bool) {
        let comp = component.alarmComponent
        let coord = AlarmCoordinator(component: comp, navController: navigationController)
        
        coordinate(coordinator: coord, animated: animated) { coordResult in
            switch coordResult {
            case .backward:
                vm.routeInputs.needUpdate.onNext(false)
            }
        }
    }
    
    private func pushDetailPostScene(vm: HomeViewModel, postID: Int, animated: Bool) {
        let comp = component.detailPostComponent(postID: postID)
        let coord = DetailPostCoordinator(component: comp, navController: navigationController)
        
        coordinate(coordinator: coord, animated: animated) { coordResult in
            switch coordResult {
            case .backward:
                vm.routeInputs.needUpdate.onNext(false)
            }
            
        }
    }
    
    private func pushInfoListScene(vm: HomeViewModel, animated: Bool) {
        let comp = component.infoListComponent
        let coord = PostListCoordinator(component: comp, navController: navigationController)
        
        coordinate(coordinator: coord, animated: animated) { coordResult in
            switch coordResult {
            case .backward:
                vm.routeInputs.needUpdate.onNext(false)
            }
        }
    }
    
    private func pushUserListScene(vm: HomeViewModel, animated: Bool) {
        let comp = component.userListComponent
        let coord = UserListCoordinator(component: comp, navController: navigationController)
        
        coordinate(coordinator: coord, animated: animated) { coordResult in
            switch coordResult {
            case .backward:
                vm.routeInputs.needUpdate.onNext(false)
            }
        }
    }
    
}
