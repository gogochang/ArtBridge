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
    }
    
}
