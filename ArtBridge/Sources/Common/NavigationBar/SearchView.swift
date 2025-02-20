//
//  SearchView.swift
//  ArtBridge
//
//  Created by 김창규 on 2/6/25.
//

import UIKit

final class SearchView: UIView {
    // MARK: - UI
    private let searchIcon = UIImageView().then {
        $0.image = UIImage(named: "search")
        $0.tintColor = .darkGray
    }
    
    private let searchPlaceHolder = UILabel().then {
        $0.text = "궁금한 것을 검색하세요!"
        $0.font = .suitR16
        $0.textColor = .white.withAlphaComponent(0.56) // TODO: 별로프로퍼티로 저장
    }
    
    private let innerShadowView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.shadowColor = UIColor.white.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowRadius = 2
        $0.layer.shadowOpacity = 0.2
        
        $0.layer.borderWidth = 10
    }
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        
        setupViews()
        initialLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension SearchView {
    private func setupViews() {
        clipsToBounds = true
        backgroundColor = .white.withAlphaComponent(0.08)
        layer.cornerRadius = 28
        innerShadowView.layer.cornerRadius = 38
        
        addSubviews([
            innerShadowView,
            searchIcon,
            searchPlaceHolder
        ])
    }
    
    private func initialLayout() {
        innerShadowView.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(-10)
            $0.bottom.right.equalToSuperview().offset(10)
        }
        
        searchIcon.snp.makeConstraints {
            $0.left.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        searchPlaceHolder.snp.makeConstraints {
            $0.left.equalTo(searchIcon.snp.right).offset(8)
            $0.centerY.equalToSuperview()
        }
    }
}
