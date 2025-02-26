//
//  DetailUserCategoryCell.swift
//  ArtBridge
//
//  Created by 김창규 on 2/26/25.
//

import UIKit

final class DetailUserCategoryCell: UICollectionViewCell {
    // MARK: - Properties
    
    static let id = "\(DetailUserCategoryCell.self)"
    
    // MARK: - UI
    private let titleLabel = UILabel().then {
        $0.text = "사랑하는 클래식 음악"
        $0.textColor = .white.withAlphaComponent(0.56)
        $0.font = .suitSB16
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
    
    func configure() {}
}

// MARK: - Layout

extension DetailUserCategoryCell {
    private func setupViews() {
        contentView.addSubviews([
            titleLabel
        ])
    }
    
    private func initialLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
        }
    }
}
