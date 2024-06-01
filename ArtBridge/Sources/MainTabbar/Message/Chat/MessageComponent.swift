//
//  MessageComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 5/31/24.
//

import Foundation

final class MessageComponent {
    var scene: (VC: MessageViewController, VM: MessageViewModel) {
        return (VC: MessageViewController(viewModel: viewModel), VM: viewModel)
    }
    
    var viewModel: MessageViewModel = .init()
}
