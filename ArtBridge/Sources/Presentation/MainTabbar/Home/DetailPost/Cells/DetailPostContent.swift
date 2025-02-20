//
//  DetailPostContent.swift
//  ArtBridge
//
//  Created by 김창규 on 2/9/25.
//

import UIKit

final class DetailPostContentCell: UICollectionViewCell {
    // MARK: - Properties
    
    static let id = "\(DetailPostContentCell.self)"
    
    // MARK: - UI
    private let textView = UITextView().then {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 24
        paragraphStyle.maximumLineHeight = 24
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.suitR16,
            .foregroundColor: UIColor.white.withAlphaComponent(0.8),
            .paragraphStyle: paragraphStyle
        ]
        
        let text = "피아니스트 이루마가 군 제대 후 2년 만에 방송에 출연, 음악 활동에 박차를 가할 예정이다.\n\n 이루마는 4일 방송 예정인 '클래식 오디세이'에 출연해 2년간의 공백기를 넘어 한층 성숙해진 그의 음악 세계를 공개할 예정이다.\n\n 이루마는 지난 2년간 군복무와, 결혼, 첫 아이 출산 등 다양한 경험을 했다. 최근에는 '그랜드민트페스티벌 2008' 무대에 올라 6집 앨범 수록곡인 100일을 맞은 딸을 위해 만든 작품 '로안나'를 공개하기도 하는 등 성숙해진 면모를 드러내기도 했다. '클래식 오디세이' 측에 따르면 이루마는 촬영 당일 \"아침까지도 많은 생각으로 잠을 이룰 수 없었다\"고 오랜만에 방송에 출연하게 된 소감을 밝혔다. 이어 \"이전의 음악들은 더 나은 음악을 위한 스케치였으며, 더 완성된 작품을 위해 피아니스트로 불리기보단 작곡가로 남고 싶다\"고 새로운 포부를 전했다."
        
        $0.attributedText = NSAttributedString(string: text, attributes: attributes)
        $0.backgroundColor = .clear
        $0.isEditable = false
        $0.isScrollEnabled = false
        $0.textContainer.lineFragmentPadding = 0
        $0.textContainerInset = .zero
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

extension DetailPostContentCell {
    private func setupViews() {
        contentView.addSubview(textView)
    }
    
    private func initialLayout() {
        textView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().priority(.low) // 내용에 따라 자동 조절
        }
    }
}
