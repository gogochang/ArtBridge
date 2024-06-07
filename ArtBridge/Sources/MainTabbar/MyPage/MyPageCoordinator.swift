//
//  MyPageCoordinator.swift
//  ArtBridge
//
//  Created by 김창규 on 4/29/24.
//

import UIKit

final class MyPageCoordinator: BaseCoordinator<Void> {
    var component: MyPageComponent
    
    init(
        component: MyPageComponent,
        navController: UINavigationController
    ) {
        self.component = component
        super.init(navController: navController)
    }
    
    override func start(animated _: Bool = true) {
        let scene = component.scene
        
        scene.VM.routes.setting
            .map { scene.VM }
            .bind { [weak self] vm in
                self?.pushSettingScene(vm: vm, animated: true)
            }.disposed(by: sceneDisposeBag)
    }
    
    private func pushSettingScene(vm: MyPageViewModel, animated: Bool) {
        let comp = component.settingComponent
        let coord = SettingCoordinator(component: comp, navController: navigationController)
        
        coordinate(coordinator: coord, animated: animated) { coordResult in
            switch coordResult {
            case .backward:
                vm.routeInputs.needUpdate.onNext(false)
            }}
    }
}
