//
//  ArtBridgeButton.swift
//  ArtBridge
//
//  Created by 김창규 on 2/6/25.
//

import UIKit

final class ArtBridgeButton: UIView {
    //MARK: - UI
    private let iconView = UIImageView()
    
    //MARK: - Init
    init(icon: UIImage?) {
        super.init(frame: .zero)
        
        clipsToBounds = true
        iconView.image = icon
        setupViews()
        initialLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addInnerShadow()
    }
}

//MARK: - Layout
extension ArtBridgeButton {
    private func setupViews() {
        addSubviews([
            iconView
        ])
    }
    
    private func initialLayout() {
        iconView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
