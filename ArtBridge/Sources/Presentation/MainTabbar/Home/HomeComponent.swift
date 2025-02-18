//
//  HomeComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 4/25/24.
//

import UIKit

final class HomeComponent {
    lazy var scene: (VC: HomeViewController, VM: HomeViewModel) = (VC: HomeViewController(viewModel: viewModel), VM: viewModel)
    
    lazy var viewModel: HomeViewModel = .init()
    
    var alarmComponent: AlarmComponent {
        return AlarmComponent()
    }
    
    func detailPostComponent(postID: Int) -> DetailPostComponent {
        return DetailPostComponent(postID: postID)
    }
    
    var infoListComponent: PostListComponent {
        return PostListComponent()
    }
    
    var userListComponent: UserListComponent {
        return UserListComponent()
    }
}
