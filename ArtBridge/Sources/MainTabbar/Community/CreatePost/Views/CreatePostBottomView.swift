//
//  CreatePostBottomView.swift
//  ArtBridge
//
//  Created by 김창규 on 9/27/24.
//

import UIKit

class CreatePostBottomView: UIView {
    //MARK: - Properties
    private let buttonTitles = ["사진", "태그"]
    private let buttonIcons = [
        UIImage(systemName: "photo"),
        UIImage(systemName: "tag")
    ]
    
    //MARK: - UI
    private let hDivider1 = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    
    let photoButton = UIButton().then {
        $0.tintColor = .systemGray
        $0.setImage(UIImage(systemName: "photo"), for: .normal)
        $0.setTitle("사진", for: .normal)
        $0.setTitleColor(.systemGray, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
    }
    
    let tagButton = UIButton().then {
        $0.tintColor = .systemGray
        $0.setImage(UIImage(systemName: "tag"), for: .normal)
        $0.setTitle("태그", for: .normal)
        $0.setTitleColor(.systemGray, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
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
}

//MARK: - Layout
extension CreatePostBottomView {
    private func setupViews() {
        addSubviews([
            hDivider1,
            photoButton,
            tagButton
        ])
    }
    
    private func initialLayout() {
        hDivider1.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        photoButton.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(16)
            $0.width.equalTo(60)
            $0.height.equalTo(20)
            
        }
        
        tagButton.snp.makeConstraints {
            $0.top.equalTo(photoButton)
            $0.left.equalTo(photoButton.snp.right).offset(8)
            $0.width.equalTo(60)
            $0.height.equalTo(20)
        }
    }
}

