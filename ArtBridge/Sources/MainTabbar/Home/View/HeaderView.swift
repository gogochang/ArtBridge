//
//  HeaderView.swift
//  ArtBridge
//
//  Created by 김창규 on 4/28/24.
//

import UIKit

final class HeaderView: UICollectionReusableView {
    static let id = "HeaderView"
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
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
        addSubviews([titleLabel])
    }
    
    private func initialLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
    }
}
