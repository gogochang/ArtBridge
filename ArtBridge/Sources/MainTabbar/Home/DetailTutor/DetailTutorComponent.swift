//
//  DetailTutorComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 5/17/24.
//

import Foundation

final class DetailTutorComponent {
    var scene: (VC: DetailTutorViewController, VM: DetailTutorViewModel) {
        let viewModel = self.viewModel
        return (VC: DetailTutorViewController(viewModel: viewModel), VM: viewModel)
    }
    
    var viewModel: DetailTutorViewModel {
        return DetailTutorViewModel(tutorId: self.tutorId)
    }
    
    var chatComponent: MessageComponent {
        return MessageComponent()
    }
    
    let tutorId: Int
    
    //MARK: - Init
    init(tutorId: Int) {
        self.tutorId = tutorId
    }
}
