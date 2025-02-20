//
//  ButtonBottomView.swift
//  ArtBridge
//
//  Created by 김창규 on 2/3/25.
//

import UIKit

final class ButtonBottomView: UIView {
    // MARK: - Properties
    
    // MARK: - UI
    private let divierView = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    
    private let contentView = UIView()
    
    let bookmarkButton = UIButton().then {
        $0.tintColor = .darkText
        // TODO: 북마크 이미지가 제공되면 변경 예정입니다.
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .medium)
        $0.setImage(UIImage(systemName: "bookmark", withConfiguration: largeConfig), for: .normal)
        $0.setImage(UIImage(systemName: "bookmark.fill", withConfiguration: largeConfig), for: .selected)
    }
    
    let goButton = UIButton().then {
        $0.setTitle("바로가기", for: .normal)
        $0.titleLabel?.font = .nanumEB20
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .black
    }
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        
        setupViews()
        inititalLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
}

// MARK: - Layout
extension ButtonBottomView {
    private func setupViews() {
        backgroundColor = .white
        addSubviews([
            divierView,
            contentView
        ])
        
        contentView.addSubviews([
            bookmarkButton,
            goButton
        ])
    }
    
    private func inititalLayout() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        let bottomSafeArea = window?.safeAreaInsets.bottom ?? 0
        
        divierView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(bottomSafeArea)
            $0.height.equalTo(60)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview()
        }
        
        goButton.snp.makeConstraints {
            $0.top.bottom.right.equalToSuperview()
            $0.left.equalTo(bookmarkButton.snp.right).offset(20)
        }
    }
}
