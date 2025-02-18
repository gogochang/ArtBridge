//
//  ComentBottomSheetComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 2/9/25.
//

import UIKit

final class ComentBottomSheetComponent {
    var scene: (VC: UIViewController, VM: ComentBottomSheetViewModel) {
        let viewModel = self.viewModel
        return (ComentBottomSheetViewController(viewModel: viewModel), viewModel)
    }
    
    var viewModel: ComentBottomSheetViewModel {
        return ComentBottomSheetViewModel()
    }
    
    let postId: Int
    
    // MARK: - Init
    init(postId: Int) {
        self.postId = postId
    }
    
}
