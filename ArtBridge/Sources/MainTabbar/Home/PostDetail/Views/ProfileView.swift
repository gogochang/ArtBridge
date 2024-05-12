//
//  ProfileView.swift
//  ArtBridge
//
//  Created by 김창규 on 5/12/24.
//

import UIKit
import Kingfisher

//MARK: 모델로 이동
struct ProfileData {
    var profileImgURL: String
    var nickname: String
    var category: String //TODO: UI관련 구현이 완료되면 카테고리 유틸로 따로 관리
}

final class ProfileView: UIView {
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
    }
    
    private let timeLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 10, weight: .regular)
        $0.textColor = .systemGray3
    }
    
    private let categoryLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = .systemGray4
    }
    
    //MARK: - Init
    init(profile: ProfileData) {
        self.profileImageView.kf.setImage(with: URL(string: profile.profileImgURL))
        self.nickNameLabel.text = profile.nickname
        self.categoryLabel.text = profile.category
        self.timeLabel.text = "10시간" //TODO: 시간관련 계산 유틸로 따로 관리
        super.init(frame: .zero)
        setupViews()
        initialLayout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Layout
extension ProfileView {
    private func setupViews() {
        addSubviews([
            profileImageView,
            nickNameLabel,
            timeLabel,
            categoryLabel
        ])
    }
    
    private func initialLayout() {
        
        profileImageView.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview()
            $0.size.equalTo(40)
        }
        
        nickNameLabel.snp.makeConstraints {
            $0.left.equalTo(profileImageView.snp.right).offset(8)
            $0.bottom.equalTo(profileImageView.snp.centerY).offset(-2)
        }
        
        timeLabel.snp.makeConstraints {
            $0.left.equalTo(nickNameLabel.snp.right).offset(4)
            $0.centerY.equalTo(nickNameLabel)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.centerY).offset(2)
            $0.left.equalTo(nickNameLabel)
        }
    }
}
