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
        
        scene.VM.routes.popularPostList
            .map { scene.VM }
            .bind { [weak self] vm in
                self?.pushPopularPostListScene(vm: vm, animated: true)
            }.disposed(by: sceneDisposeBag)
        
        scene.VM.routes.detailPost
            .map { scene.VM }
            .bind { [weak self] vm in
                self?.pushDetailPostScene(vm: vm, animated: true)
                
            }.disposed(by: sceneDisposeBag)
    }
    
    private func pushPopularPostListScene(vm: HomeViewModel, animated: Bool) {
        let comp = component.popularPostListComponent
        let coord = PopularPostListCoordinator(component: comp, navController: navigationController)
        
        coordinate(coordinator: coord, animated: animated) { coordResult in
            switch coordResult {
            case .backward:
                vm.routeInputs.needUpdate.onNext(false)
            }
        }
    }
    
    private func pushDetailPostScene(vm: HomeViewModel, animated: Bool) {
        let comp = component.detailPostComponent
        let coord = DetailPostCoordinator(component: comp, navController: navigationController)
        
        coordinate(coordinator: coord, animated: animated) { coordResult in
            switch coordResult {
            case .backward:
                vm.routeInputs.needUpdate.onNext(false)
            }
            
        }
    }
    
}
