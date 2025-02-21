//
//  DetailUserViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 2/21/25.
//

import UIKit

final class DetailUserViewController: BaseViewController {
    // MARK: - Properties
    private let viewModel: DetailUserViewModel
    
    // MARK: - UI
    
    // MARK: - Init
    init(viewModel: DetailUserViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        initialLayout()
        
        bind()
    }
    
    // MARK: - Binding
    private func bind() {
        let input = DetailUserViewModelInput()
        let output = viewModel.transform(input: input)
    }
    
    // MARK: - Methods
}

// MARK: - Layout
extension DetailUserViewController {
    private func setupViews() {
        
    }
    
    private func initialLayout() {
        
    }
}
