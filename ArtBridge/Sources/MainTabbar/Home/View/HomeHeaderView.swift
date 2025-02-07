//
//  HomeHeaderView.swift
//  ArtBridge
//
//  Created by 김창규 on 2/6/25.
//

import UIKit

final class HomeHeaderView: UICollectionReusableView {
    // MARK: - UI
    private let titleLabel = UILabel().then {
        $0.text = "당신이 사랑하는 클래식 음악"
        $0.textColor = .white
        $0.font = .suitB20
    }
    
    private let rightButton = ArtBridgeButton(icon: UIImage(named: "notice")).then {
        $0.layer.cornerRadius = 20
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        initialLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configure(with title: String) {
        titleLabel.text = title
    }
}

// MARK: - Layout
extension HomeHeaderView {
    private func setupViews() {
        addSubviews([
            titleLabel,
            rightButton
        ])
    }
    
    private func initialLayout() {
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
    }
}

extension HomeHeaderView {
    static let id = "\(HomeHeaderView.self)"
    
    static let size: CGSize = .init(width: UIScreen.main.bounds.width, height: 33)
}
