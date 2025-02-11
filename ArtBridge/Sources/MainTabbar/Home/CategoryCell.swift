//
//  CategoryCell.swift
//  ArtBridge
//
//  Created by 김창규 on 2/7/25.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    // MARK: - Properties
    
    static let id = "\(CategoryCell.self)"
    
    // MARK: - UI
    private let titleLabel = UILabel().then {
        $0.font = .suitR16
        $0.textColor = .white
    }
    
    private let innerShadowView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.shadowColor = UIColor.white.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowRadius = 2
        $0.layer.shadowOpacity = 0.2
        
        $0.layer.borderWidth = 10
    }
    
    // MARK: - Init
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupViews()
        initialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(with title: String) {
        titleLabel.text = title
    }
}

// MARK: - Layout

extension CategoryCell {
    private func setupViews() {
        contentView.clipsToBounds = true
        
        contentView.backgroundColor = .white.withAlphaComponent(0.07)
        contentView.layer.cornerRadius = 20
        innerShadowView.layer.cornerRadius = 30
        
        contentView.addSubviews([
            innerShadowView,
            titleLabel
        ])
    }
    
    private func initialLayout() {
        innerShadowView.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(-10)
            $0.bottom.right.equalToSuperview().offset(10)
        }
        
        titleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
}

