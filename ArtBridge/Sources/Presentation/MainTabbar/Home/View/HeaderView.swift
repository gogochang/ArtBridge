//
//  HeaderView.swift
//  ArtBridge
//
//  Created by 김창규 on 4/28/24.
//

import UIKit
import RxSwift

enum HeaderType: String {
    case post
    case tutors
    case news
    case none
}

final class HeaderView: UICollectionReusableView {
    static let id = "HeaderView"
    var disposeBag = DisposeBag()
    var type: HeaderType = .none
    
    // MARK: - UI
    let titleView = UIView()
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private let icon = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = .black
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        initialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Internal
    func configure(
        type: HeaderType,
        title: String
    ) {
        disposeBag = DisposeBag()
        titleLabel.text = title
        self.type = type
    }
}

// MARK: - Layout
extension HeaderView {
    private func setupViews() {
        addSubviews([
            titleView
        ])
        
        titleView.addSubviews([
            titleLabel,
            icon
        ])
    }
    
    private func initialLayout() {
        titleView.snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.right.equalTo(icon)
            $0.bottom.equalTo(titleLabel)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview()
        }
        
        icon.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.left.equalTo(titleLabel.snp.right).offset(4)
        }
    }
}
