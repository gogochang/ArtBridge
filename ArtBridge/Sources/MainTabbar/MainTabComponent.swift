//
//  MainTabComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 4/20/24.
//

import Foundation

final class MainTabComponent {
    lazy var scene: (VC: MainTabController, VM: MainTabViewModel) = (
        VC: MainTabController(viewModel: viewModel),
        VM: viewModel
    )
    
    lazy var viewModel = MainTabViewModel()
    
    var homeComponent: HomeComponent {
        return HomeComponent()
    }
    
    var communityComponent: CommunityComponent {
        return CommunityComponent()
    }
    
    var myPageComponent: MyPageComponent {
        return MyPageComponent()
    }
}
