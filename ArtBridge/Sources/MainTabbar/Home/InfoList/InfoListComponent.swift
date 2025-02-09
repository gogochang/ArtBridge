//
//  InfoListComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 2/8/25.
//

import UIKit

final class InfoListComponent {
    var scene: (VC: UIViewController, VM: InfoListViewModel) {
        let viewModel = self.viewModel
        return (InfoListViewController(viewModel: viewModel), viewModel)
    }
    
    var viewModel: InfoListViewModel {
        return InfoListViewModel()
    }
}
