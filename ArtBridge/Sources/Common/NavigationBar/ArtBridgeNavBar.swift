//
//  ArtBridgeNavBar.swift
//  ArtBridge
//
//  Created by 김창규 on 4/26/24.
//

import UIKit
import Then

final class ArtBridgeNavBar: UIView {
    //MARK: - UI
    private var contentView = UIView()
    
    let leftBtnItem = UIButton().then {
        $0.tintColor = .black
    }
    
    let rightBtnItem = UIButton().then {
        $0.titleLabel?.font? = .systemFont(ofSize: 14, weight: .medium)
        $0.setTitleColor(.black, for: .normal)
        $0.setTitleColor(.systemGray3, for: .disabled)
        $0.tintColor = .black
    }
    
    let title = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    let searchView = UIView().then {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 15
        $0.isHidden = true
    }
    
    private let searchIcon = UIImageView().then {
        $0.image = UIImage(systemName: "magnifyingglass")
        $0.tintColor = .darkGray
    }
    
    private let searchPlaceHolder = UILabel().then {
        $0.text = "검색어를 입력해주세요."
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .darkGray
    }
    
    let hDivider = UIView().then {
        $0.backgroundColor = .systemGray6
        $0.isHidden = true
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
}

//MARK: - Actions
extension ArtBridgeNavBar {
}

//MARK: - Layout
extension ArtBridgeNavBar {
    func setupViews() {
        addSubviews([
            contentView,
            hDivider
        ])
        
        contentView.addSubviews([
            leftBtnItem,
            rightBtnItem,
            title,
            searchView
        ])
        
        searchView.addSubviews([
            searchIcon,
            searchPlaceHolder
        ])
    }
    
    func initialLayout() {
        backgroundColor = .white
        contentView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        leftBtnItem.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        rightBtnItem.snp.makeConstraints {
            $0.right.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(20)
        }
        
        title.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        searchView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.left.equalTo(leftBtnItem.snp.right).offset(20)
            $0.right.equalTo(rightBtnItem.snp.left).offset(-20)
            $0.centerY.equalToSuperview()
        }
        
        searchIcon.snp.makeConstraints {
            $0.left.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(16)
        }
        
        searchPlaceHolder.snp.makeConstraints {
            $0.left.equalTo(searchIcon.snp.right).offset(4)
            $0.centerY.equalToSuperview()
        }
        
        hDivider.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
