//
//  ButtonCollectionViewCell.swift
//  ArtBridge
//
//  Created by 김창규 on 4/28/24.
//

import UIKit

final class ButtonCollectionViewCell: UICollectionViewCell {
    static let id = "ButtonCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        initialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let leftButton = UIButton().then {
        $0.setTitle("사는 얘기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    private let rightButton = UIButton().then {
        $0.setTitle("음악", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    private let separatorView = UIView().then {
        $0.backgroundColor = .systemGray6
    }
}

//MARK: - Layout
extension ButtonCollectionViewCell {
    private func setupViews() {
        addSubviews([
            leftButton,
            rightButton,
            separatorView
        ])
    }
    
    private func initialLayout() {
        
        leftButton.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
        
        rightButton.snp.makeConstraints {
            $0.top.right.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
        
        separatorView.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}

