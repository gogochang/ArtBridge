//
//  DetailPostTitleCell.swift
//  ArtBridge
//
//  Created by 김창규 on 2/9/25.
//

import UIKit

final class DetailPostTitleCell: UICollectionViewCell {
    // MARK: - Properties
    
    static let id = "\(DetailPostTitleCell.self)"
    
    // MARK: - UI
    private let typeLabel = UILabel().then {
        $0.text = "지금 인기있는 클래식 정보"
        $0.textColor = .darkYellow
        $0.font = .suitR16
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "이루마 클래식 라디오 DJ 발탁"
        $0.textColor = .white
        $0.font = .suitSB20
    }
    
    private let subTitleLabel = UILabel().then {
        $0.text = "2025년 2월 4일 화요일 • 조회수 160"
        $0.textColor = .white.withAlphaComponent(0.56)
        $0.font = .suitR16
    }
    
    private let buttonScrollView = ButtonScrollView()
    
    private let testButton1 = ArtBridgeTag().then {
        $0.setCornerRadius(20)
        $0.setTitle("뉴스")
    }
    private let testButton2 = ArtBridgeTag().then {
        $0.setCornerRadius(20)
        $0.setTitle("피아노")
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

extension DetailPostTitleCell {
    private func setupViews() {
        contentView.addSubviews([
            typeLabel,
            titleLabel,
            subTitleLabel,
            buttonScrollView
        ])
        
        buttonScrollView.addArrangedSubviews(buttons: [
            testButton1,
            testButton2
        ])
    }
    
    private func initialLayout() {
        typeLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom).offset(4)
            $0.left.equalToSuperview()
            $0.height.equalTo(32)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.left.equalToSuperview()
            $0.height.equalTo(24)
        }
        
        buttonScrollView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(4)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(72)
        }
    }
}
