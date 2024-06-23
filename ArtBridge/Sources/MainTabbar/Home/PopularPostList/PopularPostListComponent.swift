//
//  PopularPostListComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 5/10/24.
//

import UIKit

final class PopularPostListComponent {
    var scene: (VC: PopularPostListViewController, VM: PopularPostListViewModel) {
        let viewModel = self.viewModel
        return (VC: PopularPostListViewController(viewModel: viewModel), VM: viewModel)
    }
    
    var viewModel: PopularPostListViewModel {
        return PopularPostListViewModel(listType: listType)
    }
    
    var detailPostComponent: DetailPostComponent {
        return DetailPostComponent()
    }
    
    var listType: HeaderType
    
    //MARK: - Init
    init(listType: HeaderType) {
        self.listType = listType
    }
}
