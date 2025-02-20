//
//  ComentInputView.swift
//  ArtBridge
//
//  Created by 김창규 on 2/9/25.
//

import UIKit

class ComentInputView: UIView {
    // MARK: - Properties
    
    // MARK: - UI
    private let profileImageView = UIImageView().then {
        $0.image = UIImage(named: "testProfile")
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .systemGray
        $0.layer.cornerRadius = 20
    }
    
    private let searchPlaceHolder = UILabel().then {
        $0.text = "감상평을 남겨보세요!"
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
    
    private let registerButton = SelectionButton().then {
        $0.setCornerRadius(20)
        $0.setTitle("남기기")
    }

    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setupViews()
        initialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
}

// MARK: - Layout
extension ComentInputView {
    private func setupViews() {
        clipsToBounds = true
        backgroundColor = .white.withAlphaComponent(0.08)
        layer.cornerRadius = 36
        innerShadowView.layer.cornerRadius = 46
        
        addSubviews([
            innerShadowView,
            profileImageView,
            searchPlaceHolder,
            registerButton
        ])
    }
    
    private func initialLayout() {
        innerShadowView.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(-10)
            $0.bottom.right.equalToSuperview().offset(10)
        }
        
        profileImageView.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(40)
        }
        
        searchPlaceHolder.snp.makeConstraints {
            $0.left.equalTo(profileImageView.snp.right).offset(8)
            $0.centerY.equalToSuperview()
        }
        
        registerButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(74)
            $0.height.equalTo(40)
        }
    }
}
