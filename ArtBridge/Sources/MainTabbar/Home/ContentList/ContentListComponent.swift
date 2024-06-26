//
//  ContentListComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 5/10/24.
//

import UIKit

final class ContentListComponent {
    var scene: (VC: ContentListViewController, VM: ContentListViewModel) {
        let viewModel = self.viewModel
        return (VC: ContentListViewController(viewModel: viewModel), VM: viewModel)
    }
    
    var viewModel: ContentListViewModel {
        return ContentListViewModel(listType: listType)
    }
    
    func detailPostComponent(postID: Int) -> DetailPostComponent {
        return DetailPostComponent(postID: postID)
    }
    
    var listType: HeaderType
    
    //MARK: - Init
    init(listType: HeaderType) {
        self.listType = listType
    }
}
