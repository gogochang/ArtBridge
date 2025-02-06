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
    
    let rightButton = ArtBridgeButton(icon: UIImage(named: "notice")).then {
        $0.layer.cornerRadius = 20
        $0.backgroundColor = .white.withAlphaComponent(0.08)
    }
    
    let title = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark) // 💡 블러 스타일 선택
        let view = UIVisualEffectView(effect: blurEffect)
        return view
    }()
    
    let searchView = SearchView().then {
        $0.layer.cornerRadius = 28
        $0.backgroundColor = .white.withAlphaComponent(0.08)
        $0.clipsToBounds = true
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
            contentView
        ])
        
        contentView.addSubviews([
            leftBtnItem,
            rightBtnItem,
            title,
            searchView,
            rightButton,
        ])
    }
    
    func initialLayout() {
        contentView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(56)
        }
        
        leftBtnItem.snp.makeConstraints {
            $0.left.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
        
        rightButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(40)
        }
        
        title.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        searchView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalTo(leftBtnItem.snp.right).offset(8)
            $0.right.equalTo(rightButton.snp.left).offset(-8)
            $0.centerY.equalToSuperview()
        }
    }
}
