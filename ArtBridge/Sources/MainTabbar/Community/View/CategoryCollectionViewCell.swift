//
//  CategoryCollectionViewCell.swift
//  ArtBridge
//
//  Created by 김창규 on 4/28/24.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    static let id = "CategoryCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        initialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "CategoryLabel"
    }
}

//MARK: - Layout
extension CategoryCollectionViewCell {
    private func setupViews() {
        addSubviews([
            titleLabel
        ])
    }
    
    private func initialLayout() {
        backgroundColor = .systemGray6
        layer.cornerRadius = 10
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
