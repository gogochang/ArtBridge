//
//  NoticeComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 1/25/25.
//

import UIKit

final class NoticeComponent {
    var scene: (VC: UIViewController, VM: NoticeViewModel) {
        let viewModel = self.viewModel
        return (NoticeViewController(viewModel: viewModel), viewModel)
    }
    
    var viewModel: NoticeViewModel {
        return NoticeViewModel()
    }
}
