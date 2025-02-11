//
//  FilterCollectionViewCell.swift
//  ArtBridge
//
//  Created by 김창규 on 1/26/25.
//

import UIKit

final class FilterCollectionViewCell: UICollectionViewCell {
    static let id = "FilterCollectionViewCell"
    
    // MARK: - Properties
    
    // MARK: - UI
    private let titleLabel = UILabel().then {
        $0.textColor = .darkGray
        $0.font = .nanumB12
    }
    
    private let icon = UIImageView().then {
        $0.image = UIImage(named: "downArrow")
        $0.snp.makeConstraints {
            $0.size.equalTo(12)
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        initialLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK: - Methods
    func configure(title: String) {
        titleLabel.text = title
    }
}


//MARK: - CompositionalLayout
extension FilterCollectionViewCell {
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray3.cgColor
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        
        contentView.addSubviews([
            titleLabel,
            icon
        ])
    }
    
    private func initialLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.left.equalToSuperview().inset(8)
        }
        
        icon.snp.makeConstraints {
            $0.left.equalTo(titleLabel.snp.right).offset(8)
            $0.right.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
        }
    }
}
