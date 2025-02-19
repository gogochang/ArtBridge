//
//  ComentCell.swift
//  ArtBridge
//
//  Created by 김창규 on 2/9/25.
//

import UIKit
import UIKit

final class ComentCell: UITableViewCell {
    //MARK: - Properties
    static let id: String = "\(ComentCell.self)"
    
    //MARK: - UI
    private let profileImageView = UIImageView().then {
        $0.backgroundColor = .systemGray
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "testProfile")
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    
    private let contentTextView = UITextView().then {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 24
        paragraphStyle.maximumLineHeight = 24
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.suitSB16,
            .foregroundColor: UIColor.white.withAlphaComponent(0.8),
            .paragraphStyle: paragraphStyle
        ]
        let text = "좋은 정보 공유해주셔서 감사합니다! :)\n두줄두줄두줄두줄 \n세줄세줄세줄세줄세줄세줄"
        $0.attributedText = NSAttributedString(string: text, attributes: attributes)
        $0.backgroundColor = .clear
        $0.isEditable = false
        $0.isScrollEnabled = false
        $0.textContainer.lineFragmentPadding = 0
        $0.textContainerInset = .zero
    }
    
//    private let contentLabel = UILabel().then {
//        $0.text = "좋은 정보 공유해주셔서 감사합니다! :)\n두줄두줄두줄두줄 \n세줄세줄세줄세줄세줄세줄"
//        $0.font = .suitSB16
//        $0.textColor = .white
//        $0.numberOfLines = 3
//    }
    
    private let subLabel = UILabel().then {
        $0.text = "이루마 • 1시간 전"
        $0.font = .suitR14
        $0.textColor = .white.withAlphaComponent(0.56)
    }
    
    //MARK: - Init
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
    
    //MARK: - Methods
    func configure() {
        
    }
}

//MARK: - Layout
extension ComentCell {
    private func setupViews() {
        backgroundColor = .clear
        contentView.addSubviews([
            profileImageView,
            contentTextView,
            subLabel
        ])
    }
    
    private func initialLayout() {
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.left.equalToSuperview().inset(8)
            $0.size.equalTo(40)
        }
        
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(profileImageView)
            $0.left.equalTo(profileImageView.snp.right).offset(8)
        }
        
        subLabel.snp.makeConstraints {
            $0.top.equalTo(contentTextView.snp.bottom).offset(4)
            $0.left.equalTo(contentTextView)
            $0.bottom.equalToSuperview().inset(12)
            $0.height.equalTo(24)
        }
    }
}
