//
//  MainTabCoordinator.swift
//  ArtBridge
//
//  Created by 김창규 on 4/20/24.
//

import UIKit

final class MainTabCoordinator: BaseCoordinator<Void> {
    //MARK: - LiftCycle
    init(
        component: MainTabComponent,
        navController: UINavigationController
    ) {
        self.component = component
        super.init(navController: navController)
    }
    
    //MARK: - Internal
    var component: MainTabComponent
    
    override func start(animated _: Bool = true) {
        startTabbarController()
    }
    
    //MARK: - Private
    private func startTabbarController() {
        let scene = component.scene
        UITabBar.appearance().backgroundColor = UIColor.orange
        
        scene.VC.viewControllers = [
            configureAndGetHomeScene(vm: scene.VM),
            configureAndGetCommunityScene(vm: scene.VM)
        ]
        
        navigationController.pushViewController(scene.VC, animated: false)
        
        closeSignal.subscribe(onNext: { [weak self] _ in
            self?.navigationController.popViewController(animated: false)
        }).disposed(by: sceneDisposeBag)
    }
    
    private func configureAndGetHomeScene(vm: MainTabViewModel) -> UIViewController {
        let comp = component.homeComponent
        let coord = HomeCoordinator(component: comp, navController: navigationController)
        
        coordinate(coordinator: coord, animated: false, needRelease: false) { coordResult in
        }
        
        vm.routes.home
            .subscribe(onNext: {
                comp.viewModel.routeInputs.needUpdate.onNext(true)
            })
            .disposed(by: sceneDisposeBag)
        
        return comp.scene.VC
    }
    
    private func configureAndGetCommunityScene(vm: MainTabViewModel) -> UIViewController {
        let comp = component.communityComponent
        let coord = CommunityCoordinator(component: comp, navController: navigationController)
        
        coordinate(coordinator: coord, animated: false, needRelease: false) { coordResult in
            
        }
        
        vm.routes.community
            .subscribe(onNext: {
                comp.viewModel.routeInputs.needUpdate.onNext(true)
            })
            .disposed(by: sceneDisposeBag)
        
        return comp.scene.VC
    }
}
