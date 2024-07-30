//
//  CreatePostComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 7/30/24.
//

import Foundation

final class CreatePostComponent {
    lazy var scene: (VC: CreatePostViewController, VM: CreatePostViewModel) = (VC: CreatePostViewController(viewModel: viewModel), VM: viewModel)
    
    lazy var viewModel: CreatePostViewModel = .init()
}
