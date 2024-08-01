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
        $0.text = "바이올린"
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .darkGray
    }
    
    func configure(title: String) {
        titleLabel.text = title
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
        backgroundColor = .systemGray5
        layer.cornerRadius = 15
        
        titleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
        }
    }
}
