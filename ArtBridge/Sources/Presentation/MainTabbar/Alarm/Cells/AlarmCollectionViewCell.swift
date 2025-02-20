//
//  AlarmCollectionViewCell.swift
//  ArtBridge
//
//  Created by 김창규 on 6/16/24.
//

import UIKit

final class AlarmCollectionViewCell: UICollectionViewCell {
    static let id = "AlarmCollectionViewCell"
    
    // MARK: - UI
    private let titleLabel = UILabel().then {
        $0.text = "알람 제목"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    private let dateLabel = UILabel().then {
        $0.text = "2024.06.14"
        $0.textColor = .systemGray3
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
    
    private let categoryContainer = UIView().then {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 10
    }
    
    private let categoryLabel = UILabel().then {
        $0.text = "카테고리"
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
    
    private let textLabel = UILabel().then {
        $0.text = "알람내용알람내용알람내용알람내용알람내용"
        $0.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        $0.numberOfLines = 1
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
extension AlarmCollectionViewCell {
    private func setupViews() {
        addSubviews([
            titleLabel,
            categoryContainer,
            textLabel,
            dateLabel,
            lineView
        ])
        
        categoryContainer.addSubview(categoryLabel)
    }
    
    private func initialLayout() {
        categoryContainer.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(8)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview().inset(4)
            $0.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(categoryLabel.snp.right).offset(8)
            $0.centerY.equalTo(categoryLabel)
        }
        
        dateLabel.snp.makeConstraints {
            $0.left.equalTo(titleLabel.snp.right).offset(8)
            $0.centerY.equalTo(titleLabel)
        }
        
        textLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.left.equalTo(categoryLabel)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(textLabel.snp.bottom).offset(8)
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
