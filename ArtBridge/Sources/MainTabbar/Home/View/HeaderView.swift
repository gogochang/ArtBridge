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
    
    let moreButton = UIButton().then {
        $0.setTitle("전체보기", for: .normal)
        $0.setTitleColor(.systemGray3, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.tintColor = .systemGray3
        $0.semanticContentAttribute = .forceRightToLeft
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
            moreButton
        ])
    }
    
    private func initialLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        moreButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.right.equalToSuperview()
        }
    }
}
