//
//  SelectCategoryView.swift
//  ArtBridge
//
//  Created by 김창규 on 9/27/24.
//

import UIKit

class SelectCategoryView: UIView {
    //MARK: - Properties
    
    //MARK: - UI
    private let selectedCategoryName = UILabel().then {
        $0.text = "카테고리를 선택해주세요."
        $0.textColor = .darkText
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    private let chevronIcon = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = .darkText
    }
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        setupViews()
        initialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
}

//MARK: - Layout
extension SelectCategoryView {
    private func setupViews() {
        addSubviews([
            selectedCategoryName,
            chevronIcon
        ])
    }
    
    private func initialLayout() {
        selectedCategoryName.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview().inset(20)
        }
        
        chevronIcon.snp.makeConstraints {
            $0.top.bottom.right.equalToSuperview().inset(20)
        }
    }
}
