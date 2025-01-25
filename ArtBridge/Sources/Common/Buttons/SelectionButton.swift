//
//  SelectionButton.swift
//  ArtBridge
//
//  Created by 김창규 on 1/26/25.
//

import UIKit

/**
 `SelectionButton` 클래스는 "ArtBridge" 앱의 디자인 가이드를 따라 구현된 선택형 버튼입니다.
 
 이 버튼은 선택 상태에 따라 스타일이 변경되며, 기본적으로 "착한의사" 앱의 스타일을 유지합니다.
 버튼의 텍스트, 선택 상태에 따른 색상 및 스타일 변경 등이 이 클래스에서 관리됩니다.
 
 - 주요 기능:
    - `isSelected`: 버튼의 선택 상태를 나타내는 프로퍼티로, 선택 시 버튼의 스타일이 변경됩니다.
    - `updateUI`: 선택 상태에 맞게 버튼의 스타일을 업데이트하는 메서드입니다.
    - `title`: 버튼에 표시할 텍스트를 설정하는 프로퍼티입니다.
 
 - Author: 김창규
 - Version: 1.0
 - Since: 1/16/25
 */

class SelectionButton: UIView {
    // MARK: - Properties
    private let title: String
    private let icon: UIImage?
    
    // 버튼의 선택 상태를 나타내는 프로퍼티. 선택 시 UI가 변경됩니다.
    var isSelected: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    var action: (() -> Void)?
    // MARK: - UI
    private let titleLabel = UILabel().then {
        $0.font = .nanumB13
        $0.textColor = .disableText
    }
    
    private let iconImageView = UIImageView().then {
        $0.snp.makeConstraints {
            $0.size.equalTo(12)
        }
    }
    // MARK: - Init
    /**
     버튼의 텍스트와 기본 선택 상태를 설정할 수 있습니다.
     
     - Parameters:
        - title: 버튼에 표시할 텍스트입니다.
        - icon: 우측 아이콘 이미지를 설정합니다. 기본값은 `nil`입니다.
     */
    init(
        title: String,
        icon: UIImage? = nil
    ) {
        self.title = title
        self.icon = icon
        super.init(frame: .zero)
        
        setupViews()
        initialLayout()
        updateUI()
        // Tap gesture recognizer to handle taps
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    /**
     버튼의 스타일을 선택 상태에 맞게 업데이트합니다.
     선택된 상태에서는 배경색, 테두리 색상 및 텍스트 색상이 변경됩니다.
     */
    private func updateUI() {
        titleLabel.text = title
        titleLabel.textColor = isSelected ? .black : .disableText
        
        iconImageView.image = icon

        layer.borderWidth = 1
        layer.cornerRadius = 4
        layer.borderColor = isSelected ? UIColor.black.cgColor : UIColor.disableBorder.cgColor
//        backgroundColor = isSelected ? .enableBg : .white
    }
    
    // MARK: - Actions
    @objc private func handleTap() {
        isSelected.toggle()
        action?()
    }
}

// MARK: - Layout
extension SelectionButton {
    private func setupViews() {
        
        addSubviews([
            titleLabel,
            iconImageView
        ])
    }
    
    private func initialLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview().inset(10)
        }
        
        iconImageView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.left.equalTo(titleLabel.snp.right).offset(8)
            $0.right.equalToSuperview().inset(10)
        }
    }
}
