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
    
    private let focusBottom = UIView().then {
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
        
        for title in titles {
            createButton(title: title)
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
            focusBottom
        ])
    }
    
    private func createButton(title: String) {
        let topButton = UIButton().then {
            $0.setTitle(title, for: .normal)
            $0.setTitleColor(.darkGray, for: .normal)
            $0.setTitleColor(.black, for: .selected)
            $0.setBackgroundColor(.white, for: .normal)
            $0.snp.makeConstraints {
                $0.width.equalTo(80)
            }
        }
        
        stackView.addArrangedSubview(topButton)
    }
    
    private func initialLayout() {
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview() // Adjust top margin as needed
            $0.left.equalToSuperview().offset(8) // Adjust left margin as needed
            $0.bottom.equalToSuperview().inset(8)
        }
        
        separatorView.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(0.5)
        }
        
        focusBottom.snp.makeConstraints {
            $0.left.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview()
            $0.width.equalTo(80)
            $0.height.equalTo(2)
        }
    }
}
