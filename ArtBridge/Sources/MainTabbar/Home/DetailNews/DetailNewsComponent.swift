//
//  DetailNewsComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 5/21/24.
//

import Foundation

final class DetailNewsComponent {
    var scene: (VC: DetailNewsViewController, VM: DetailNewsViewModel) {
        let viewModel = self.viewModel
        return (VC: DetailNewsViewController(viewModel: viewModel), VM: viewModel)
    }
    
    var viewModel: DetailNewsViewModel {
        return DetailNewsViewModel(newsID: self.newsID)
    }
    
    let newsID: Int
    
    //MARK: - Init
    init(newsID: Int) {
        self.newsID = newsID
    }
}
