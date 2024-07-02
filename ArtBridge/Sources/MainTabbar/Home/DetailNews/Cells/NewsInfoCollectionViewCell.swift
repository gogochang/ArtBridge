//
//  NewsInfoCollectionViewCell.swift
//  ArtBridge
//
//  Created by 김창규 on 6/3/24.
//

import UIKit
import Kingfisher

final class NewsInfoCollectionViewCell: UICollectionViewCell {
    static let id = "NewsInfoCollectionViewCell"
    
    //MARK: - UI
    private let categoryLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.textColor = .systemGray
        $0.text = "뉴스 > 공연"
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.text = "오늘 밤은 고고오케스트라로 채워집니다!🎉"
        $0.numberOfLines = 2
    }
    
    private let profileImageView = UIImageView().then {
        $0.backgroundColor = .systemGray6
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
    }
    
    private let nickNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textColor = .black
        $0.text = "ArtBride"
    }
    
    private let dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .systemGray3
        $0.text = "2024.06.03"
    }
    
    private let viewCountLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .systemGray3
        $0.text = "조회수 2.8만"
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        initialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Internal Methods
    func configure(with newsData: DetailNewsDataModel) {
        nickNameLabel.text = newsData.author.nickname
        profileImageView.kf.setImage(with: URL(string: newsData.author.profileImgUrl))
    }
    
}

//MARK: - Layout
extension NewsInfoCollectionViewCell {
    private func setupViews() {
        self.addSubviews([
            categoryLabel,
            titleLabel,
            profileImageView,
            nickNameLabel,
            dateLabel,
            viewCountLabel,
            lineView
        ])
    }
    
    private func initialLayout() {
        categoryLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.left.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(20)
            $0.left.right.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview()
            $0.size.equalTo(40)
        }
        
        nickNameLabel.snp.makeConstraints {
            $0.left.equalTo(profileImageView.snp.right).offset(8)
            $0.bottom.equalTo(profileImageView.snp.centerY).offset(-2)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.centerY).offset(2)
            $0.left.equalTo(profileImageView.snp.right).offset(8)
        }
        
        viewCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.left.equalTo(dateLabel.snp.right).offset(10)
        }
        
        lineView.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
