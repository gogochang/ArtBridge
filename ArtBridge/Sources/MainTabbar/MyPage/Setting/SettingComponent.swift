//
//  SettingComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 6/7/24.
//

import UIKit

final class SettingComponent {
    var scene: (VC: SettingViewController, VM: SettingViewModel) {
        return (VC: SettingViewController(viewModel: viewModel), VM: viewModel)
    }
    
    var viewModel: SettingViewModel = .init()
}
