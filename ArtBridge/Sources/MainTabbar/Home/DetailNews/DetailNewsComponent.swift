//
//  DetailNewsComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 5/21/24.
//

import Foundation

final class DetailNewsComponent {
    var scene: (VC: DetailNewsViewController, VM: DetailNewsViewModel) {
        return (VC: DetailNewsViewController(viewModel: viewModel), VM: viewModel)
    }
    
    var viewModel: DetailNewsViewModel = .init()
}
