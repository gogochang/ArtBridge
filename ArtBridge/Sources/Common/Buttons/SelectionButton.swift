//
//  SelectionButton.swift
//  ArtBridge
//
//  Created by 김창규 on 1/26/25.
//

import UIKit

final class SelectionButton: UIView {
    // MARK: - Properties
    var isSelected: Bool = false {
        didSet {
            updateUI()
        }
    }
    private var title: String = ""
    private var normalIcon: UIImage?
    private var selectedIcon: UIImage?
    
    //MARK: - UI
    private let contentView = UIView()
    
    private let iconView = UIImageView()
    
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
        setupGesture()
        initialLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    func setTitle(_ title: String) {
        self.title = title
        self.titleLabel.text = title
    }
    
    func setImage(_ image: UIImage?, for state: UIControl.State) {
        if state == .normal {
            normalIcon = image
            iconView.image = image
        } else if state == .selected {
            selectedIcon = image
        }
    }
    
    func setCornerRadius(_ radius: CGFloat) {
        innerShadowView.layer.cornerRadius = radius + 10
        layer.cornerRadius = radius
    }
}

// MARK: - Gesture
extension SelectionButton {
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
    }
    
    @objc private func handleTap() {
        isSelected.toggle()
    }
}

//MARK: - Layout
extension SelectionButton {
    private func setupViews() {
        backgroundColor = .white.withAlphaComponent(0.04)
        
        addSubview(contentView)
        addSubview(innerShadowView)
        
        contentView.addSubviews([
            iconView,
            titleLabel
        ])
    }
    
    private func initialLayout() {
        contentView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        iconView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(iconView.snp.right).offset(4)
            $0.right.equalToSuperview()
            $0.centerY.equalTo(iconView)
        }
        
        innerShadowView.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(-10)
            $0.bottom.right.equalToSuperview().offset(10)
        }
    }
    
    private func updateUI() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            backgroundColor = isSelected ? .primary : .white.withAlphaComponent(0.04)
            iconView.image = isSelected ? (selectedIcon ?? normalIcon) : normalIcon
            layoutIfNeeded()
        }
    }
}

