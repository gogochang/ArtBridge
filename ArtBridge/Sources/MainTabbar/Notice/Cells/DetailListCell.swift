//
//  DetailListCell.swift
//  ArtBridge
//
//  Created by 김창규 on 1/26/25.
//

import UIKit
final class DetailListCell: UITableViewCell {
    // MARK: - UI
    private let categoryLabel = UILabel().then {
        $0.text = "카테고리 제목"
        $0.textColor = .darkText
        $0.font = .nanumB15
    }
    
    private let contentLabel = UILabel().then {
        $0.text = "카테고리 내용"
        $0.textColor = .darkGray
        $0.font = .nanumR15
        $0.numberOfLines = 2
    }
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        initialLayout()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configure(title: String, content: String) {
        categoryLabel.text = title
        contentLabel.text = content
    }
}

// MARK: - Layout
extension DetailListCell {
    private func setupViews() {
        self.selectionStyle = .none
        
        contentView.addSubviews([
            categoryLabel,
            contentLabel
        ])
    }
    
    private func initialLayout() {
        categoryLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(60)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel)
            $0.left.equalTo(categoryLabel.snp.right).offset(12)
            $0.right.equalToSuperview()
        }
    }
}

extension DetailListCell {
    static let id: String = "\(DetailListCell.self)"
    static let height: CGFloat = 20
}
