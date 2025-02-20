//
//  AppCoordinator.swift
//  ArtBridge
//
//  Created by 김창규 on 4/20/24.
//

import UIKit

final class AppCoordinator: BaseCoordinator<Void> {
    var window: UIWindow
    
    // MARK: - LiftCycle
    init(
        component: AppComponent,
        window: UIWindow
    ) {
        self.component = component
        self.window = window
        let navController = UINavigationController()
        window.rootViewController = navController
        super.init(navController: navController)
    }
    
    // MARK: - Internal
    var component: AppComponent
    
    override func start(animated _: Bool = true) {
//        BasicLoginKeyChainService.shared.clearIfFirstLaunched()
        window.makeKeyAndVisible()
        self.showLogin(animated: false)
//        self.showMain(animated: false)
//        component.loginService.checkLogin()
//            .subscribe(onNext: { result in
//                switch result {
//                case .member:
//                    self.showMain(animated: false)
//                case .memberWaitCertification:
//                    self.showMain(animated: false)
//                case .nonMember:
//                    self.showLoggedOut(animated: false)
//                case .stopped:
//                    self.showLoggedOut(animated: false)
//                }
//            })
//            .disposed(by: sceneDisposeBag)
    }
    
    func showMain(animated: Bool) {
        let comp = component.mainTabComponent
        let coord = MainTabCoordinator(
            component: comp,
            navController: navigationController
        )
        
        coordinate(coordinator: coord, animated: animated) { coordResult in
//            switch coordResult {
//            case .logout:
//                self?.showLoggedOut(animated: false)
//            }
        }
    }
    
    func showLogin(animated: Bool) {
        let comp = component.loginComponent
        let coord = LoginCoordinator(component: comp, navController: navigationController)
        
        coordinate(coordinator: coord, animated: animated) { [weak self] coordResult in
            switch coordResult {
            case .loginSuccess:
                self?.showMain(animated: false)
            }
        }
    }
}
