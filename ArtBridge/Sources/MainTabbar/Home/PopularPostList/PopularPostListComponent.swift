//
//  PopularPostListComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 5/10/24.
//

import UIKit

final class PopularPostListComponent {
    var scene: (VC: PopularPostListViewController, VM: PopularPostListViewModel) {
        return (VC: PopularPostListViewController(viewModel: viewModel), VM: viewModel)
    }
    
    var viewModel: PopularPostListViewModel = .init()
    
    var detailPostComponent: DetailPostComponent {
        return DetailPostComponent()
    }
}
