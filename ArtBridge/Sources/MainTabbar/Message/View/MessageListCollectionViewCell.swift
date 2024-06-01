//
//  MessageListCollectionViewCell.swift
//  ArtBridge
//
//  Created by 김창규 on 4/29/24.
//

import UIKit

final class MessageListCollectionViewCell: UICollectionViewCell {
    static let id = "MessageCollectionViewCell"
    
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
        $0.layer.cornerRadius = 20
    }
    
    private let userNameLabel = UILabel().then {
        $0.text = "User"
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = .black
    }
    
    private let previewLabel = UILabel().then {
        $0.text = "동해물과 백두산이 마르고 닳도록"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = .systemGray
    }
    
    private let timeLabel = UILabel().then {
        $0.text = "오후 11:08"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = .systemGray3
    }
}

//MARK: - Layout
extension MessageListCollectionViewCell {
    private func setupViews() {
        addSubviews([
            imageView,
            userNameLabel,
            previewLabel,
            timeLabel
        ])
    }
    
    private func initialLayout() {
        imageView.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview().inset(8)
            $0.width.equalTo(imageView.snp.height)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.centerY).offset(-2)
            $0.left.equalTo(imageView.snp.right).offset(16)
        }
        
        previewLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.centerY).offset(2)
            $0.left.equalTo(imageView.snp.right).offset(16)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.right.equalToSuperview().inset(8)
        }
    }
}
