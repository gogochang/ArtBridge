//
//  ProfileCollectionViewCell.swift
//  ArtBridge
//
//  Created by 김창규 on 4/30/24.
//

import UIKit

final class ProfileCollectionViewCell: UICollectionViewCell {
    static let id = "ProfileCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        initialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let imageView = UIImageView().then {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 40
    }
    
    private let userNameLabel = UILabel().then {
        $0.text = "UserName"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .black
    }
    
    private let categoryLabel = UILabel().then {
        $0.text = "바이올린 - 강사"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = .systemGray
    }
    
    private let likeIcon = UIImageView().then {
        $0.image = UIImage(systemName: "heart.fill")
        $0.tintColor = .red
    }
    
    private let likeCountLabel = UILabel().then {
        $0.text = "0"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = .black
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = .systemGray6
    }
}

//MARK: - Layout
extension ProfileCollectionViewCell {
    private func setupViews() {
        addSubviews([
            imageView,
            userNameLabel,
            categoryLabel,
            likeIcon,
            likeCountLabel,
            lineView
        ])
    }
    
    private func initialLayout() {
        imageView.snp.makeConstraints {
            $0.left.centerY.equalToSuperview()
            $0.size.equalTo(80)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.bottom.equalTo(categoryLabel.snp.top).inset(-4)
            $0.left.equalTo(imageView.snp.right).offset(16)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.centerY.equalTo(imageView)
            $0.left.equalTo(userNameLabel)
        }
        
        likeIcon.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(4)
            $0.left.equalTo(userNameLabel)
        }
        
        likeCountLabel.snp.makeConstraints {
            $0.left.equalTo(likeIcon.snp.right).offset(4)
            $0.centerY.equalTo(likeIcon)
        }
        
        lineView.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(2)
        }
    }
}
