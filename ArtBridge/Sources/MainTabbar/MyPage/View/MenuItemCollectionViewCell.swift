//
//  MenuItemCollectionViewCell.swift
//  ArtBridge
//
//  Created by 김창규 on 5/1/24.
//

import UIKit

final class MenuItemCollectionViewCell: UICollectionViewCell {
    static let id = "SingleCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        initialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let icon = UIImageView().then {
        $0.image = UIImage(systemName: "folder")
    }
    
    private let title = UILabel().then {
        $0.text = "Menu Item Title"
    }
}

//MARK: - Layout
extension MenuItemCollectionViewCell {
    private func setupViews() {
        addSubviews([
            icon,
            title
        ])
    }
    
    private func initialLayout() {
        icon.snp.makeConstraints {
            $0.left.centerY.equalToSuperview()
            $0.size.equalTo(25)
        }
        
        title.snp.makeConstraints {
            $0.left.equalTo(icon.snp.right).offset(16)
            $0.centerY.equalToSuperview()
        }
    }
}
