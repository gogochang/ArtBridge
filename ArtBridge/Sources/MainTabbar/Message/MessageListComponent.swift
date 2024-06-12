//
//  MessageListComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 4/29/24.
//

import Foundation

final class MessageListComponent {
    lazy var scene: (VC: MessageListViewController, VM: MessageListViewModel) = (VC: MessageListViewController(viewModel: viewModel), VM: viewModel)
    
    lazy var viewModel: MessageListViewModel = .init()
    
    var chatComponent: MessageComponent {
        return MessageComponent()
    }
}
