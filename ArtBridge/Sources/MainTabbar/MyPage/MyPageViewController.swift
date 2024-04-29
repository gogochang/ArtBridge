//
//  MyPageViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 4/29/24.
//

import UIKit

final class MyPageViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initialLayout()
    }
    
    private let navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setImage(UIImage(systemName: "apple.logo"), for: .normal)
        $0.rightBtnItem.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
    }
}

//MARK: - Layout
extension MyPageViewController {
    private func setupViews() {
        view.addSubviews([
            navBar
        ])
    }
    
    private func initialLayout() {
        view.backgroundColor = .white
        navBar.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
    }
}
