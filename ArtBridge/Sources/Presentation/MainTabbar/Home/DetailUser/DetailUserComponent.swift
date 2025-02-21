//
//  DetailUserComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 2/21/25.
//

import UIKit

final class DetailUserComponent {
    var scene: (VC: UIViewController, VM: DetailUserViewModel) {
        let viewModel = self.viewModel
        return (DetailUserViewController(viewModel: viewModel), viewModel)
    }
    
    var viewModel: DetailUserViewModel {
        return DefaultDetailUserViewModel()
    }
    
    let user: User
    
    // MARK: - Init
    init(user: User) {
        self.user = user
    }
}
