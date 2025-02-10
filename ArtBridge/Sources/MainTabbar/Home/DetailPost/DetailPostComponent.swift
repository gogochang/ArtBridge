//
//  DetailPostComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 5/12/24.
//

import UIKit

final class DetailPostComponent {
    //MARK: - Properties
    var scene: (VC: DetailPostViewController, VM: DetailPostViewModel) {
        let viewModel = self.viewModel
        return (VC: DetailPostViewController(viewModel: viewModel), VM: viewModel)
    }
    
    var viewModel: DetailPostViewModel {
        return DetailPostViewModel(postID: self.postID)
    }
    
    let postID: Int
    
    //MARK: - Init
    init(postID: Int) {
        self.postID = postID
    }
    
    func comentBottmSheet(postId: Int) -> ComentBottomSheetComponent {
        return ComentBottomSheetComponent(postId: postId)
    }
}
