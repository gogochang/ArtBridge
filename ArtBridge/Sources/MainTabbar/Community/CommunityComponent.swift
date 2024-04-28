//
//  CommunityComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 4/28/24.
//

import Foundation

final class CommunityComponent {
    lazy var scene: (VC: CommunityViewController, VM: CommunityViewModel) = (VC: CommunityViewController(), VM: viewModel)
    
    lazy var viewModel: CommunityViewModel = .init()
    
}
