//
//  HomeHeaderView.swift
//  ArtBridge
//
//  Created by 김창규 on 2/7/25.
//

import UIKit
import RxSwift

final class HomeHeaderView: UICollectionReusableView {
    static let id = "\(HomeHeaderView.self)"
    
    // MARK: - Properties
    var disposeBag = DisposeBag()
    
    // MARK: - UI
    private let titleLabel = UILabel().then {
        $0.font = .suitB20
        $0.textColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        initialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configure(
        title: String
    ) {
        disposeBag = DisposeBag()
        titleLabel.text = title
    }
}

// MARK: - Layout
extension HomeHeaderView {
    private func setupViews() {
        addSubviews([
            titleLabel
        ])
    }
    
    private func initialLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview()
        }
    }
}
