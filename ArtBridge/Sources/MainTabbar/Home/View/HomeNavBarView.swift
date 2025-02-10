//
//  HomeNavBarView.swift
//  ArtBridge
//
//  Created by 김창규 on 2/7/25.
//

import UIKit

final class HomeNavBarView: UICollectionReusableView {
    static let id = "HomeNavBarView"
    
    private let navBar = ArtBridgeNavBar().then {
        $0.leftButton.setImage(UIImage(named: "logo"), for: .normal)
        $0.rightBtnItem.setImage(UIImage(systemName: "bell"), for: .normal)
        $0.searchView.isHidden = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(navBar)
        navBar.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
