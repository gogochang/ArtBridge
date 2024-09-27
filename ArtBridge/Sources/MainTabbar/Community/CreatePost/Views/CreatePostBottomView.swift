//
//  CreatePostBottomView.swift
//  ArtBridge
//
//  Created by 김창규 on 9/27/24.
//

import UIKit

class CreatePostBottomView: UIView {
    //MARK: - Properties
    private let buttonTitles = ["사진", "동영상", "파일", "태그"]
    private let buttonIcons = [
        UIImage(systemName: "photo"),
        UIImage(systemName: "video"),
        UIImage(systemName: "doc"),
        UIImage(systemName: "tag")
    ]
    
    //MARK: - UI
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 20
        $0.distribution = .fillEqually
        $0.alignment = .leading  // 왼쪽 정렬
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
    
    // MARK: - Methods
    private func createButton(title: String, icon: UIImage?) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setImage(icon, for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        
        // 버튼의 이미지와 텍스트 간격 설정
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
        
        return button
    }
}

//MARK: - Layout
extension CreatePostBottomView {
    private func setupViews() {
        addSubviews([
            stackView
        ])
        
        // 4개의 버튼을 stackView에 추가
        for (index, title) in buttonTitles.enumerated() {
            let button = createButton(title: title, icon: buttonIcons[index])
            stackView.addArrangedSubview(button)
        }
    }
    
    private func initialLayout() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
}

