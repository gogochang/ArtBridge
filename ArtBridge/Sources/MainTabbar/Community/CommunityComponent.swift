//
//  CommunityComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 4/28/24.
//

import Foundation

final class CommunityComponent {
    lazy var scene: (VC: CommunityViewController, VM: CommunityViewModel) = (VC: CommunityViewController(viewModel: viewModel), VM: viewModel)
    
    lazy var viewModel: CommunityViewModel = .init()
    
    func detailPostComponent(postID: Int) -> DetailPostComponent {
        return DetailPostComponent(postID: postID)
    }
    
    var createPostComponent: CreatePostComponent {
        return CreatePostComponent()
    }
}
