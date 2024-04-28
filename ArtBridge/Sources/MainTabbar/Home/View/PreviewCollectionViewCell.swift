//
//  PreviewCollectionViewCell.swift
//  ArtBridge
//
//  Created by 김창규 on 4/28/24.
//

import UIKit

final class PreviewCollectionViewCell: UICollectionViewCell {
    static let id = "PreviewCollectionViewCell"
    
    func configure(
        previewImage: UIImage?,
        title: String,
        subTitle: String
    ) {
        self.imageView.image = previewImage
        self.title.text = title
        self.subTitle.text = subTitle
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        initialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let imageView = UIImageView().then {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 15
    }
    private let title = UILabel()
    private let subTitle = UILabel()
}

//MARK: - Layout
extension PreviewCollectionViewCell {
    private func setupViews() {
        addSubviews([
            imageView,
            title,
            subTitle
        ])
    }
    
    private func initialLayout() {
        imageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.6)
        }
        
        title.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.left.equalToSuperview()
        }
        
        subTitle.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(8)
            $0.left.equalToSuperview()
        }
    }
}
