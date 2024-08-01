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
    }
    
    private let leftButton = UIButton().then {
        $0.setTitle("사는 얘기", for: .normal)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.setTitleColor(.black, for: .selected)
        $0.setBackgroundColor(.white, for: .normal)
        $0.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    }
    
    private let rightButton = UIButton().then {
        $0.setTitle("음악", for: .normal)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.setTitleColor(.black, for: .selected)
        $0.setBackgroundColor(.white, for: .normal)
        $0.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12) // Adjust insets as needed
    }
    
    private let separatorView = UIView().then {
        $0.backgroundColor = .systemGray2
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        initialLayout()
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
            separatorView
        ])
        
        stackView.addArrangedSubview(leftButton)
        stackView.addArrangedSubview(rightButton)
    }
    
    private func initialLayout() {
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview() // Adjust top margin as needed
            $0.left.equalToSuperview().offset(8) // Adjust left margin as needed
            $0.bottom.equalToSuperview() // Adjust bottom margin as needed
        }
        
        separatorView.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
}
