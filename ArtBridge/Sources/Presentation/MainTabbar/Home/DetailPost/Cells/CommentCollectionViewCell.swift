//
//  CommentCollectionViewCell.swift
//  ArtBridge
//
//  Created by 김창규 on 5/12/24.
//

import UIKit

final class CommentCollectionViewCell: UICollectionViewCell {
    static let id = "CommentCollectionViewCell"
    
    // MARK: - UI
    private let nickNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .darkGray
        $0.text = "호박고구마"
    }
    
    private let categoryLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = .systemGray4
        $0.text = "첼로"
    }
    
    private let contentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .darkText
        $0.text = "동해물과 백두산이 마르고 닳도록."
        $0.numberOfLines = 2
        
        let attrString = NSMutableAttributedString(string: $0.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attrString.length))
        $0.attributedText = attrString
    }
    
    private let likeIcon = UIImageView().then {
        $0.image = UIImage(systemName: "heart")
        $0.tintColor = .darkGray
    }
    
    private let likeCount = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .darkGray
        $0.text = "28"
    }
    
    private let commentIcon = UIImageView().then {
        $0.image = UIImage(systemName: "ellipsis.message")
        $0.tintColor = .darkGray
    }
    
    private let commentCount = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .darkGray
        $0.text = "대댓글"
    }
    
    let moreButton = UIButton().then {
        $0.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        $0.tintColor = .systemGray3
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        initialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension CommentCollectionViewCell {
    private func setupViews() {
        addSubviews([
            nickNameLabel,
            categoryLabel,
            contentLabel,
            likeIcon,
            likeCount,
            commentIcon,
            commentCount,
            moreButton,
            lineView
        ])
    }
    
    private func initialLayout() {
        self.backgroundColor = .white
        
        nickNameLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(20)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.left.equalTo(nickNameLabel.snp.right).offset(4)
            $0.centerY.equalTo(nickNameLabel)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        likeIcon.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(8)
            $0.left.bottom.equalToSuperview().inset(20)
            $0.size.equalTo(12)
        }
        
        likeCount.snp.makeConstraints {
            $0.left.equalTo(likeIcon.snp.right).offset(8)
            $0.centerY.equalTo(likeIcon)
        }
        
        commentIcon.snp.makeConstraints {
            $0.left.equalTo(likeCount.snp.right).offset(16)
            $0.centerY.equalTo(likeIcon)
            $0.size.equalTo(12)
        }
        
        commentCount.snp.makeConstraints {
            $0.left.equalTo(commentIcon.snp.right).offset(8)
            $0.centerY.equalTo(likeIcon)
        }
        
        moreButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.right.equalToSuperview().inset(20)
        }
        
        lineView.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
