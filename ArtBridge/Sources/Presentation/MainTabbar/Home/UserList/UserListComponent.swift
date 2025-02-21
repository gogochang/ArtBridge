//
//  UserListComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 2/12/25.
//

import UIKit

final class UserListComponent {
    var scene: (VC: UIViewController, VM: DefaultUserListViewModel) {
        let viewModel = self.viewModel
        return (UserListViewController(viewModel: viewModel), viewModel)
    }
    
    var viewModel: DefaultUserListViewModel {
        return DefaultUserListViewModel()
    }
    
    func detailUserComponent(user: User) -> DetailUserComponent {
        return DetailUserComponent(user: user)
    }
}
