//
//  HeaderView.swift
//  ArtBridge
//
//  Created by 김창규 on 4/28/24.
//

import UIKit

final class HeaderView: UICollectionReusableView {
    static let id = "HeaderView"
    
    //MARK: - UI
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private let moreBtnLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .systemGray3
        $0.text = "전체보기"
    }
    
    private let rightIcon = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = .systemGray3
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        initialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Internal
    func configure(title: String) {
        titleLabel.text = title
    }
}

//MARK: - Layout
extension HeaderView {
    private func setupViews() {
        addSubviews([
            titleLabel,
            moreBtnLabel,
            rightIcon
        ])
    }
    
    private func initialLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        moreBtnLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.right.equalTo(rightIcon.snp.left).offset(-4)
        }
        
        rightIcon.snp.makeConstraints {
            $0.centerY.equalTo(moreBtnLabel)
            $0.right.equalToSuperview()
        }
    }
}
