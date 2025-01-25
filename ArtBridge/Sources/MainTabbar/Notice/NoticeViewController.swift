//
//  NoticeViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 1/25/25.
//

import UIKit

final class NoticeViewController: BaseViewController {
    //MARK: - Properties
    private let viewModel: NoticeViewModel
    
    //MARK: - UI
    private var navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setTitle("공고", for: .normal)
        $0.leftBtnItem.setTitleColor(.black, for: .normal)
        $0.leftBtnItem.titleLabel?.font = .jalnan20
        $0.searchView.isHidden = true
    }
    
    //MARK: - Init
    init(viewModel: NoticeViewModel) {
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
extension NoticeViewController {
    private func setupViews() {
        view.backgroundColor = .orange
        view.addSubviews([
            navBar
        ])
    }
    
    private func initialLayout() {
        navBar.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
    }
}

