//
//  SearchView.swift
//  ArtBridge
//
//  Created by 김창규 on 2/6/25.
//

import UIKit

final class SearchView: UIView {
    //MARK: - UI
    private let searchIcon = UIImageView().then {
        $0.image = UIImage(named: "search")
        $0.tintColor = .darkGray
    }
    
    private let searchPlaceHolder = UILabel().then {
        $0.text = "궁금한 것을 검색하세요!"
        $0.font = .suitR16
        $0.textColor = .white.withAlphaComponent(0.56) // TODO: 별로프로퍼티로 저장
    }
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        
        setupViews()
        initialLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addInnerShadow()
    }
}

//MARK: - Layout
extension SearchView {
    private func setupViews() {
        addSubviews([
            searchIcon,
            searchPlaceHolder
        ])
    }
    
    private func initialLayout() {
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
