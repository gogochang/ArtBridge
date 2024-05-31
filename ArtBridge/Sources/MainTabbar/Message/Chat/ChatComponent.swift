//
//  ChatComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 5/31/24.
//

import Foundation

final class ChatComponent {
    var scene: (VC: ChatViewController, VM: ChatViewModel) {
        return (VC: ChatViewController(viewModel: viewModel), VM: viewModel)
    }
    
    var viewModel: ChatViewModel = .init()
}
