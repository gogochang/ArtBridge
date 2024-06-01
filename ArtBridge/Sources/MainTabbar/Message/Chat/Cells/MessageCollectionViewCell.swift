//
//  MessageCollectionViewCell.swift
//  ArtBridge
//
//  Created by 김창규 on 6/1/24.
//

import UIKit

class MessageCollectionViewCell: UICollectionViewCell {
    static let id = "MessageCollectionViewCell"
    
    //MARK: - Properties
    
    //MARK: - UI
    private let profileImageView = UIImageView().then {
        $0.backgroundColor = .systemGray6
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
    }
    
    private let nickNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textColor = .black
        $0.text = "밤양갱"
    }
    
    private let messageContainerView = UIView().then {
        $0.layer.cornerRadius = 5
        $0.backgroundColor = .white
    }
    
    private let messageView = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.numberOfLines = 0
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.profileImageView.kf.setImage(with: URL(string:  "https://i.pravatar.cc/300?img=10"))
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(messageModel: MessageModel) {
        messageView.text = messageModel.message
        
        let currentUserId = 1 // 임시로 현재 로그인된 유저ID를 1로 설정
        let isMe = messageModel.userId == currentUserId
        if isMe {
            initialRightLayout()
        } else {
            initialLeftLayout()
        }
    }
}

//MARK: - Layout
extension MessageCollectionViewCell {
    private func setupViews() {
        self.addSubviews([
            profileImageView,
            nickNameLabel,
            messageContainerView,
        ])
        messageContainerView.addSubview(messageView)
    }
    
    private func initialLeftLayout() {
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.left.equalToSuperview().offset(10)
            $0.size.equalTo(40)
        }
        
        nickNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.top)
            $0.left.equalTo(profileImageView.snp.right).offset(8)
        }
        
        messageContainerView.backgroundColor = .white
        messageContainerView.snp.makeConstraints {
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(4)
            $0.left.equalTo(profileImageView.snp.right).offset(8)
            $0.bottom.equalToSuperview().inset(4)
            $0.right.lessThanOrEqualTo(self.snp.centerX)
        }
        
        messageView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview().inset(4)
        }
    }
    
    private func initialRightLayout() {
        
        messageContainerView.backgroundColor = .systemYellow
        messageContainerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.left.greaterThanOrEqualTo(self.snp.centerX)
            $0.right.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(4)
        }
        
        messageView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview().inset(4)
        }
    }
}
