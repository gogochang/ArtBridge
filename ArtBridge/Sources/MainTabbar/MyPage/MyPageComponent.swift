//
//  MyPageComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 4/29/24.
//

import Foundation

final class MyPageComponent {
    lazy var scene: (VC: MyPageViewController, VM: MyPageViewModel) = (VC: MyPageViewController(viewModel: viewModel), VM: viewModel)
    
    lazy var viewModel: MyPageViewModel = .init()
    
    var settingComponent: SettingComponent {
        return SettingComponent()
    }
}
