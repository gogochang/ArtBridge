//
//  MessageComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 4/29/24.
//

import Foundation

final class MessageComponent {
    lazy var scene: (VC: MessageViewController, VM: MessageViewModel) = (VC: MessageViewController(), VM: viewModel)
    
    lazy var viewModel: MessageViewModel = .init()
}
