//
//  ButtonScrollView.swift
//  ArtBridge
//
//  Created by 김창규 on 1/23/25.
//

import UIKit
/**
 `ButtonScrollView` 클래스는 버튼들이 수평또는 수직으로 정렬된 스크롤 가능한 뷰를 제공합니다.
 
 이 클래스는 버튼들을 수평 또는 수직으로 배치할 수 있는 `UIStackView`를 활용하여, 사용자가 버튼을 스크롤할 수 있도록 합니다.
 
 - 주요 기능:
    - stackView: 버튼들을 수평 또는 수직으로 배치하는 스택 뷰입니다.
    - addArrangedSubviews: 버튼들을 스택 뷰에 추가하는 메서드입니다.
 
 - Author: 김창규
 - Version: 1.0
 - Since: 1/16/25
 */
final class ButtonScrollView: UIScrollView {
    // MARK: - Properties
    
    // MARK: - UI
    private let stackView = UIStackView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.alignment = .trailing
    }
    
    // MARK: - Init
    /**
     초기화 메서드로, 스택 뷰의 축과 간격을 설정할 수 있습니다.
     
     - Parameters:
        - axis: 스택 뷰의 축을 설정합니다. 기본값은 `.horizontal` 입니다.
        - spacing: 스택 뷰 내 버튼들 간의 간격을 설정합니다. 기본값은 `6` 입니다.
     */
    init(
        axis: NSLayoutConstraint.Axis = .horizontal,
        spacing: CGFloat = 6,
        alignment: UIStackView.Alignment = .leading
    ) {
        super.init(frame: .zero)
        setupViews()
        initialLayout()
        initialStackView(
            axis: axis,
            spacing: spacing
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    /**
     스택 뷰에 버튼들을 추가하는 메서드입니다.
     
     - Parameters:
        - buttons: `UIButton` 배열로, 스택 뷰에 추가할 버튼들을 전달합니다.
     */
    func addArrangedSubviews(buttons: [UIView]) {
        for button in buttons {
            stackView.addArrangedSubview(button)
        }
    }

    /**
     스택 뷰의 초기 설정을 수행하는 메서드입니다.
     
     - Parameters:
        - axis: 스택 뷰의 축(수평 또는 수직)을 설정합니다.
        - spacing: 스택 뷰 내 버튼들 사이의 간격을 설정합니다.
     */
    private func initialStackView(
        axis: NSLayoutConstraint.Axis,
        spacing: CGFloat
    ) {
        self.stackView.axis = .horizontal
        self.stackView.spacing = spacing
    }
}

// MARK: - Layout
extension ButtonScrollView {
    private func setupViews() {
        addSubviews([
            stackView
        ])
    }
    
    private func initialLayout() {
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
        stackView.snp.makeConstraints {
            $0.left.centerY.equalToSuperview()
        }
    }
}
