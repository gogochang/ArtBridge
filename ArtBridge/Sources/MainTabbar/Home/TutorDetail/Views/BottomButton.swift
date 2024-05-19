//
//  BottomButton.swift
//  ArtBridge
//
//  Created by 김창규 on 5/19/24.
//

import UIKit

final class BottomButton: UIView {
    //MARK: - UI
    private let contentView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let bottomButton = UIButton().then {
        $0.layer.cornerRadius = 5
        $0.backgroundColor = .systemBrown
        $0.setTitle("메시지 보내기", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
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

//MARK: - Layout
extension BottomButton {
    private func setupViews() {
        self.addSubviews([
            contentView
        ])
        
        contentView.addSubview(bottomButton)
    }
    
    private func initialLayout() {
        contentView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
            $0.height.equalTo(44 + 50)//TODO: safeArea bottom height
        }
        
        bottomButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
    }
}
