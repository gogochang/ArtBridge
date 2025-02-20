//
//  AlarmCell.swift
//  ArtBridge
//
//  Created by 김창규 on 2/11/25.
//

import UIKit

final class AlarmCell: UITableViewCell {
    // MARK: - Properties
    static let id = "\(AlarmCell.self)"
    
    // MARK: - UI
    private let alarmIconView = UIImageView().then {
        $0.image = UIImage(named: "iconNotice_fill")
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .suitSB16
        $0.textColor = .white
        $0.text = "읽지않은 알람 제목"
    }
    
    private let moreButton = UIButton().then {
        $0.setImage(UIImage(named: "iconMore"), for: .normal)
    }
    
    private let contentTextLabel = UILabel().then {
        $0.font = .suitL14
        $0.textColor = .white.withAlphaComponent(0.64)
        $0.numberOfLines = 2
        $0.text = "내용은 최대 2줄까지 내용은 최대 2줄까지 내용은 최대 2줄까지 내용은 최대 2줄까지 내용은 최대 2줄까지 내용은 최대 2줄까지 내용은 최대 2줄까지 "
    }
    
    private let categoryLabel = UILabel().then {
        $0.font = .suitR14
        $0.textColor = .darkYellow
        $0.text = "카테고리"
    }
    
    private let dateLabel = UILabel().then {
        $0.font = .suitR14
        $0.textColor = .white.withAlphaComponent(0.64)
        $0.text = "2025.02.04"
    }
    
    private let innerShadowView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.shadowColor = UIColor.white.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowRadius = 2
        $0.layer.shadowOpacity = 0.2
        
        $0.layer.borderWidth = 10
        $0.layer.cornerRadius = 34
    }
    
    // MARK: - Init
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews() // cell 세팅
        initialLayout() // cell 레이아웃 설정
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configure() {
        
    }
}

extension AlarmCell {
    private func setupViews() {
        backgroundColor = .clear
        contentView.backgroundColor = .white.withAlphaComponent(0.08)
        contentView.layer.cornerRadius = 24
        contentView.clipsToBounds = true
        
        contentView.addSubviews([
            innerShadowView,
            alarmIconView,
            titleLabel,
            moreButton,
            contentTextLabel,
            categoryLabel,
            dateLabel
        ])
    }
    
    private func initialLayout() {
        contentView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16) // 위쪽만 16pt 여백
            $0.left.right.bottom.equalToSuperview() // 나머지는 꽉 채움
        }

        innerShadowView.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(-10)
            $0.bottom.right.equalToSuperview().offset(10)
        }
        
        alarmIconView.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(16)
            $0.size.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(alarmIconView.snp.right).offset(8)
            $0.centerY.equalTo(alarmIconView)
        }
        
        moreButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(16)
            $0.centerY.equalTo(alarmIconView)
            $0.size.equalTo(24)
        }
        
        contentTextLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(32)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(contentTextLabel.snp.bottom).offset(8)
            $0.left.equalTo(contentTextLabel)
            $0.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(24)
        }
        
        dateLabel.snp.makeConstraints {
            $0.left.equalTo(categoryLabel.snp.right).offset(16)
            $0.centerY.equalTo(categoryLabel)
            $0.height.equalTo(24)
        }
    }
}
