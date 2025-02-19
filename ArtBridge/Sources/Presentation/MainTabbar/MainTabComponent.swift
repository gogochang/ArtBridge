//
//  MainTabComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 4/20/24.
//

import Foundation

final class MainTabComponent {
    lazy var scene: (VC: MainTabViewController, VM: MainTabViewModel) = (
        VC: MainTabViewController(viewModel: viewModel),
        VM: viewModel
    )
    
    lazy var viewModel = DefaultMainTabViewModel()
    
    var homeComponent: HomeComponent {
        return HomeComponent()
    }
}
