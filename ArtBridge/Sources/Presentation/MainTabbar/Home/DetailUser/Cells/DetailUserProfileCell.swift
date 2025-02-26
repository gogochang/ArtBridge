//
//  DetailUserProfileCell.swift
//  ArtBridge
//
//  Created by 김창규 on 2/26/25.
//

import UIKit

final class DetailUserProfileCell: UICollectionViewCell {
    // MARK: - Properties
    
    static let id = "\(DetailUserProfileCell.self)"
    
    // MARK: - UI
    private let profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .systemGray
        $0.image = UIImage(named: "section-thumbnail-item")
        $0.layer.cornerRadius = 80
        $0.layer.masksToBounds = true
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

extension DetailUserProfileCell {
    private func setupViews() {
        contentView.addSubviews([
            profileImageView
        ])
    }
    
    private func initialLayout() {
        profileImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.size.equalTo(160)
        }
    }
}
