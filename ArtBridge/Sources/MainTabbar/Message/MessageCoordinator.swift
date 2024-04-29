//
//  MessageCoordinator.swift
//  ArtBridge
//
//  Created by 김창규 on 4/29/24.
//

import UIKit

final class MessageCoordinator: BaseCoordinator<Void> {
    var component: MessageComponent
    
    init(
        component: MessageComponent,
        navController: UINavigationController
    ) {
        self.component = component
        super.init(navController: navController)
    }
    
    override func start(animated _: Bool = true) {
        let scene = component.scene
    }
}
