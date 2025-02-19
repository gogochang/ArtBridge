//
//  LoginComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 6/4/24.
//

import Foundation

final class LoginComponent {
    var scene: (VC: LoginViewController, VM: LoginViewModel) {
        return (VC: LoginViewController(viewModel: viewModel), VM: viewModel)
    }
    
    var viewModel: LoginViewModel = .init()
}
