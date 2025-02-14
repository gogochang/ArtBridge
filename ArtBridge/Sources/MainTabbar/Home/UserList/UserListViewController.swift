//
//  UserListViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 2/12/25.
//

import UIKit

final class UserListViewController: BaseViewController {
    //MARK: - Properties
    private let viewModel: UserListViewModel
    
    //MARK: - UI
    
    //MARK: - Init
    init(viewModel: UserListViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        initialLayout()
        
        viewModelInput()
        viewModelOutput()
    }
    
    //MARK: - Methods
    private func viewModelInput() {
        
    }
    
    private func viewModelOutput() {
        
    }
}

//MARK: - Layout
extension UserListViewController {
    private func setupViews() {
        
    }
    
    private func initialLayout() {
        
    }
}

