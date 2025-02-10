//
//  TagButton.swift
//  ArtBridge
//
//  Created by 김창규 on 2/9/25.
//

import UIKit

final class ArtBridgeTag: UIView {
    // MARK: - Properties
    
    //MARK: - UI
    private let titleLabel = UILabel().then {
        $0.font = .suitSB14
        $0.textColor = .white
    }
    
    private let innerShadowView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.shadowColor = UIColor.white.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowRadius = 2
        $0.layer.shadowOpacity = 0.2
        
        $0.layer.borderWidth = 10
    }
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        
        clipsToBounds = true
        setupViews()
        initialLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    func setTitle(_ title: String) {
        self.titleLabel.text = title
    }
    
    func setCornerRadius(_ radius: CGFloat) {
        innerShadowView.layer.cornerRadius = radius + 10
        layer.cornerRadius = radius
    }
}

//MARK: - Layout
extension ArtBridgeTag {
    private func setupViews() {
        backgroundColor = .white.withAlphaComponent(0.04)
        
        addSubviews([
            titleLabel,
            innerShadowView
        ])
    }
    
    private func initialLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.left.right.equalToSuperview().inset(16)
            $0.center.equalToSuperview()
            $0.height.equalTo(24)
        }
        
        innerShadowView.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(-10)
            $0.bottom.right.equalToSuperview().offset(10)
        }
    }
}
