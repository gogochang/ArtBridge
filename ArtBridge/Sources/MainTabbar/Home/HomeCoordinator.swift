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
    }
    
}
