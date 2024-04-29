//
//  ArtBridgeNavBar.swift
//  ArtBridge
//
//  Created by 김창규 on 4/26/24.
//

import UIKit

final class ArtBridgeNavBar: UIView {
    
    init() {
        super.init(frame: .zero)
        setupViews()
        initialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var contentView = UIView()
    
    //MARK: - Internal
    var leftBtnItem = UIButton().then {
        $0.tintColor = .black
    }
    var rightBtnItem = UIButton().then {
        $0.tintColor = .black
    }
}
//MARK: - Actions
extension ArtBridgeNavBar {
}

//MARK: - Layout
extension ArtBridgeNavBar {
    func setupViews() {
        addSubviews([
            contentView
        ])
        
        contentView.addSubviews([
            leftBtnItem,
            rightBtnItem
        ])
    }
    
    func initialLayout() {
        contentView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        leftBtnItem.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        rightBtnItem.snp.makeConstraints {
            $0.right.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
}
