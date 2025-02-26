//
//  DetailUserContentCell.swift
//  ArtBridge
//
//  Created by 김창규 on 2/26/25.
//

import UIKit

final class DetailUserContentCell: UICollectionViewCell {
    // MARK: - Properties
    
    static let id = "\(DetailUserContentCell.self)"
    
    // MARK: - UI
    private let titleLabel = UILabel().then {
        $0.text = "안녕하세요. \n 피아니스트 이루마입니다."
        $0.textAlignment = .center
        $0.textColor = .white
        $0.font = .suitB20
        $0.numberOfLines = 2
    }
    
    private let contentTextView = UITextView().then {
        $0.text = """
        군 제대 후 2년 만에 복귀한 이루마입니다! 4일 방송 예정인 '클래식 오디세이'에 출연해 2년간의 공백기를 넘어 한층 성숙해진 저의 음악 세계를 공개할 예정입니다! 저는 지난 2년간 군복무와, 결혼, 첫 아이 출산 등 다양한 경험을 했습니다. 최근에는 '그랜드민트페스티벌 2008' 무대에 올라 6집 앨범 수록곡인 100일을 맞은 딸을 위해 만든 작품 '로안나'를 공개하기도 하는 등 성숙해진 면모를 드러내기도 했다.  '클래식 오디세이' 측에 따르면 이루마는 촬영 당일 "아침까지도 많은 생각으로 잠을 이룰 수 없었다"고 오랜만에 방송에 출연하게 된 소감을 밝혔다.  이어 "이전의 음악들은 더 나은 음악을 위한 스케치였으며, 더 완성된 작품을 위해 피아니스트로 불리기보단 작곡가로 남고 싶다"고 새로운 포부를 전했다.
"""
        $0.textColor = .white.withAlphaComponent(0.80)
        $0.font = .suitR16
        $0.backgroundColor = .clear
    }
    
    private let moreButton = ArtBridgeButton().then {
//        $0.setImage(UIImage(named: "more"), for: .normal)
        $0.setImage(UIImage(named: "하지만"), for: .normal)
        $0.setCornerRadius(20)
        $0.backgroundColor = .white.withAlphaComponent(0.08)
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

extension DetailUserContentCell {
    private func setupViews() {
        contentView.backgroundColor = .orange
        contentView.addSubviews([
            titleLabel,
            contentTextView,
            moreButton
        ])
    }
    
    private func initialLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
        }
        
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(24)
            $0.height.equalTo(96)
        }
        
        moreButton.snp.makeConstraints {
            $0.top.equalTo(contentTextView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(40)
        }
    }
}
