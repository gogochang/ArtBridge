//
//  CategoryCell.swift
//  ArtBridge
//
//  Created by 김창규 on 2/6/25.
//

import UIKit
import RxSwift

final class CategoryCell: UICollectionViewCell {
    static let id = "\(CategoryCell.self)"
    
    // MARK: - Properties
    var disposeBag = DisposeBag()
    
    // MARK: - UI
    private let titleLabel = UILabel().then {
        $0.text = "타이틀"
        $0.textColor = .white.withAlphaComponent(0.72)
        $0.font = .suitR16
    }
    
    // MARK: - Init
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupViews()
        initialLayout()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addInnerShadow()
    }
    
    // MARK: - Methods
    func configure(with item: CategoryConfig) {
        titleLabel.text = item.title
    }
}

// MARK: - Layout
extension CategoryCell {
    private func setupViews() {
        backgroundColor = .white.withAlphaComponent(0.08)
        layer.cornerRadius = 20
        clipsToBounds = true
        contentView.addSubviews([
            titleLabel
        ])
    }
    
    private func initialLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.left.right.equalToSuperview().inset(16)
            $0.center.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
}
