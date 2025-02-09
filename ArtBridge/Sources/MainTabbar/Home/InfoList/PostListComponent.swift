//
//  PostListComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 2/8/25.
//

import UIKit

final class PostListComponent {
    var scene: (VC: UIViewController, VM: PostListViewModel) {
        let viewModel = self.viewModel
        return (PostListViewController(viewModel: viewModel), viewModel)
    }
    
    var viewModel: PostListViewModel {
        return PostListViewModel()
    }
}
