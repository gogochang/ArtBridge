//
//  FloatingButton.swift
//  ArtBridge
//
//  Created by 김창규 on 7/27/24.
//

import UIKit

final class FloatingButton: UIView {
    //MARK: - Properties
    
    //MARK: - UI
    private let containerView = UIView()
    
    private let imageView = UIImageView().then {
        $0.tintColor = .white
    }
    
    private let label = UILabel().then {
        $0.textColor = .white
        
    }
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        setupViews()
        initialLayout()
        
        imageView.image = UIImage(systemName: "plus")
        
        label.text = "글쓰기"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Layout
extension FloatingButton {
    
    private func setupViews() {
        self.addSubviews([
            imageView,
            label
            
        ])
    }
    
    private func initialLayout() {
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(10)
            $0.size.equalTo(32)
        }
        
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(imageView.snp.right).offset(8)
            $0.right.equalToSuperview()
        }
    }
}
