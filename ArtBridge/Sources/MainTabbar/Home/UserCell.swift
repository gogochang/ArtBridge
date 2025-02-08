//
//  UserCell.swift
//  ArtBridge
//
//  Created by 김창규 on 2/7/25.
//

import UIKit

final class UserCell: UICollectionViewCell {
    // MARK: - Properties
    
    static let id = "\(UserCell.self)"
    
    // MARK: - UI
    private let profileImageView = UIImageView().then {
        $0.backgroundColor = .systemGray
        $0.layer.cornerRadius = 62
        $0.clipsToBounds = true
        $0.image = UIImage(named: "testuser")
    }
    
    private let nameLabel = UILabel().then {
        $0.text = "홍진호"
        $0.font = .suitSB16
        $0.textColor = .white
    }
    
    private let jobLabel = UILabel().then {
        $0.text = "바이올린"
        $0.font = .suitL14
        $0.textColor = .white.withAlphaComponent(56)
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

extension UserCell {
    private func setupViews() {
        contentView.addSubviews([
            profileImageView,
            nameLabel,
            jobLabel
        ])
    }
    
    private func initialLayout() {
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.size.equalTo(124)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        jobLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(12)
        }
    }
}

