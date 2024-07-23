//
//  QuickBtnCollectionViewCell.swift
//  ArtBridge
//
//  Created by 김창규 on 4/26/24.
//

import UIKit

class QuickBtnCollectionViewCell: UICollectionViewCell {
    static let id = "QuickBtnCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        initialLayout()
        backgroundColor = .white
        self.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(
        icon: UIImage?,
        title: String
    ) {
        self.icon.image = icon
        self.titleLabel.text = title
    }
    
    private let icon = UIImageView()
    private let titleLabel = UILabel().then {
        $0.textColor = .darkText
        $0.font = UIFont.systemFont(ofSize: 14)
    }
}

//MARK: - Layout
extension QuickBtnCollectionViewCell {
    private func setupViews() {
        self.addSubviews([
            icon,
            titleLabel
        ])
    }
    
    private func initialLayout() {
        icon.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(4)
            $0.centerX.equalToSuperview()
        }
    }
}
