//
//  AlarmComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 6/16/24.
//

import Foundation
import RxSwift

final class AlarmComponent {
    var scene: (VC: AlarmViewController, VM: AlarmViewModel) {
        return (VC: AlarmViewController(viewModel: viewModel), VM: viewModel)
    }
    
    var viewModel: AlarmViewModel = .init()
}
