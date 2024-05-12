//
//  DetailPostComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 5/12/24.
//

import UIKit

final class DetailPostComponent {
    var scene: (VC: DetailPostViewController, VM: DetailPostViewModel) {
        return (VC: DetailPostViewController(viewModel: viewModel), VM: viewModel)
    }
    
    var viewModel: DetailPostViewModel = .init()
}
