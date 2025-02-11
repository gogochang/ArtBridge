//
//  DetailNoticeComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 1/26/25.
//

import UIKit

final class DetailNoticeComponent {
    var scene: (VC: UIViewController, VM: DetailNoticeViewModel) {
        let viewModel = self.viewModel
        return (DetailNoticeViewController(viewModel: viewModel), viewModel)
    }
    
    var viewModel: DetailNoticeViewModel {
        return DetailNoticeViewModel()
    }
}
