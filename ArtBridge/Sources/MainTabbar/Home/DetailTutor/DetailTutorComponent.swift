//
//  DetailTutorComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 5/17/24.
//

import Foundation

final class DetailTutorComponent {
    var scene: (VC: DetailTutorViewController, VM: DetailTutorViewModel) {
        return (VC: DetailTutorViewController(viewModel: viewModel), VM: viewModel)
    }
    
    var viewModel: DetailTutorViewModel = .init()
    
    var chatComponent: MessageComponent {
        return MessageComponent()
    }
}
