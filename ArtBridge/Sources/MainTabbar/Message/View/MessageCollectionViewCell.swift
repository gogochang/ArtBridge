//
//  MessageCollectionViewCell.swift
//  ArtBridge
//
//  Created by 김창규 on 4/29/24.
//

import UIKit

final class MessageCollectionViewCell: UICollectionViewCell {
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
        $0.text = "Post Title"
    }
    
    private let previewLabel = UILabel().then {
        $0.text = "Post SubTitle"
    }
}

//MARK: - Layout
extension MessageCollectionViewCell {
    private func setupViews() {
        addSubviews([
            imageView,
            userNameLabel,
            previewLabel
        ])
    }
    
    private func initialLayout() {
        imageView.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview().inset(8)
            $0.width.equalTo(imageView.snp.height)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.centerY).offset(-8)
            $0.left.equalTo(imageView.snp.right).offset(16)
        }
        
        previewLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.centerY).offset(8)
            $0.left.equalTo(imageView.snp.right).offset(16)
        }
    }
}
