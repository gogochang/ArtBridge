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
        contentView.backgroundColor = .white.withAlphaComponent(0.07)
        contentView.layer.cornerRadius = 20
        
        contentView.addSubview(titleLabel)
    }
    
    private func initialLayout() {
        titleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
}

