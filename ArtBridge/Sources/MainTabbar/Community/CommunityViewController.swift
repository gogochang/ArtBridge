//
//  CommunityViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 4/28/24.
//

import UIKit

final class CommunityViewController: UIViewController {
    private var navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setImage(UIImage(systemName: "apple.logo"), for: .normal)
        $0.rightBtnItem.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initialLayout()
    }
}

//MARK: - Layout
extension CommunityViewController {
    private func setupViews() {
        view.addSubviews([navBar])
        
    }
    
    private func initialLayout() {
        view.backgroundColor = .white
        
        navBar.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
    }
}
