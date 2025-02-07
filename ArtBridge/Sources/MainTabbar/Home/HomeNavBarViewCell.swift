//
//  HomeNavBarViewCell.swift
//  ArtBridge
//
//  Created by 김창규 on 2/7/25.
//

import UIKit

final class HomeNavBarViewCell: UICollectionViewCell {
    static let id = "\(HomeNavBarViewCell.self)"
    
    // MARK: UI
    private let navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setImage(UIImage(named: "logo"), for: .normal)
        $0.rightBtnItem.setImage(UIImage(systemName: "bell"), for: .normal)
        $0.searchView.isHidden = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        initialLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension HomeNavBarViewCell {
    private func setupViews() {
        addSubview(navBar)
    }
    
    private func initialLayout() {
        navBar.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
    }
}
