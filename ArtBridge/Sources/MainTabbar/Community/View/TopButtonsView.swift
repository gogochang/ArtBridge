//
//  TopButtonsView.swift
//  ArtBridge
//
//  Created by 김창규 on 8/1/24.
//

import UIKit

final class TopButtonsView: UIView {
    //MARK: - Properties
    
    //MARK: - UI
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .leading
        $0.spacing = 8
        $0.distribution = .fillEqually
    }
    
    private let focusBottomBar = UIView().then {
        $0.backgroundColor = .systemBrown
    }
    
    private let separatorView = UIView().then {
        $0.backgroundColor = .systemGray2
    }
    
    //MARK: - Init
    init(titles: [String]) {
        super.init(frame: .zero)
        setupViews()
        initialLayout()
        
        for (index, title) in titles.enumerated() {
            createButton(title: title, tag: index)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Layout
extension TopButtonsView {
    private func setupViews() {
        addSubviews([
            stackView,
            separatorView,
            focusBottomBar
        ])
    }
    
    private func createButton(title: String, tag: Int) {
        let topButton = UIButton().then {
            $0.setTitle(title, for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            $0.setTitleColor(.darkGray, for: .normal)
            $0.setTitleColor(.black, for: .selected)
            $0.backgroundColor = .white
            $0.snp.makeConstraints {
                $0.width.equalTo(80)
            }
            $0.tag = tag
            if tag == 0 {
                $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
                $0.isSelected = true
            }
            $0.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
        
        stackView.addArrangedSubview(topButton)
    }
    
    private func initialLayout() {
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(8)
        }
        
        separatorView.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(0.5)
        }
        
        focusBottomBar.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalTo(96)
            $0.height.equalTo(2)
        }
    }
}

//MARK: - Actions
extension TopButtonsView {
    @objc private func buttonTapped(_ sender: UIButton) {
        // 모든 버튼의 선택 상태를 초기화하고 폰트 설정
        for case let button as UIButton in stackView.arrangedSubviews {
            button.isSelected = false
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        }
        
        // 클릭된 버튼의 선택 상태를 true로 설정하고 볼드체로 변경
        sender.isSelected = true
        sender.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        guard let _ = sender.superview else { return }
        
        // 클릭된 버튼의 x 위치와 너비를 이용해 새로운 제약 조건을 계산
        let newLeftConstraint = sender.frame.origin.x
        let buttonWidth = sender.frame.width + 16
        
        UIView.animate(withDuration: 0.2) {
            self.focusBottomBar.snp.updateConstraints {
                $0.left.equalToSuperview().offset(newLeftConstraint)
                $0.width.equalTo(buttonWidth)
            }
            self.layoutIfNeeded()
        }
    }
}
