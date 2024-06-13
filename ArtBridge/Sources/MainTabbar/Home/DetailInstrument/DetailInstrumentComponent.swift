//
//  DetailInstrumentComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 6/13/24.
//

import Foundation

final class DetailInstrumentComponent {
    var scene: (VC: DetailInstrumentViewController, VM: DetailInstrumentViewModel) {
        return (VC: DetailInstrumentViewController(viewModel: viewModel), VM: viewModel)
    }
    
    var viewModel: DetailInstrumentViewModel = .init()
}
