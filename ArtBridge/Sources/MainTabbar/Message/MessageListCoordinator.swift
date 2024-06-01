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
    }
}
