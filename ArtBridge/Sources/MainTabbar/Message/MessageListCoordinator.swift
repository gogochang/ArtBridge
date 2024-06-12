//
//  MessageListCoordinator.swift
//  ArtBridge
//
//  Created by 김창규 on 4/29/24.
//

import UIKit

final class MessageListCoordinator: BaseCoordinator<Void> {
    var component: MessageListComponent
    
    init(
        component: MessageListComponent,
        navController: UINavigationController
    ) {
        self.component = component
        super.init(navController: navController)
    }
    
    override func start(animated _: Bool = true) {
        let scene = component.scene
        
        scene.VM.routes.showMessage
            .map { scene.VM }
            .bind { [weak self] vm in
                self?.configureAndGetMessageScene(vm: vm, animated: true)
            }.disposed(by: sceneDisposeBag)
        
    }
    
    private func configureAndGetMessageScene(vm: MessageListViewModel, animated: Bool) {
        let comp = component.chatComponent
        let coord = MessageCoordinator(component: comp, navController: navigationController)
        
        coordinate(coordinator: coord, animated: animated) { coordResult in
            switch coordResult {
            case .backward:
                vm.routeInputs.needUpdate.onNext(false)
            }
            
        }
    }
}
