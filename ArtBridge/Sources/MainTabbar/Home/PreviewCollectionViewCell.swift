//
//  PreviewCollectionViewCell.swift
//  ArtBridge
//
//  Created by 김창규 on 4/28/24.
//

import UIKit
import Kingfisher

final class PreviewCollectionViewCell: UICollectionViewCell {
    static let id = "PreviewCollectionViewCell"
    
    //MARK: - UI
    private let imageView = UIImageView().then {
        $0.backgroundColor = .systemGray6
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.masksToBounds = true
    }
    
    private let title = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14,weight: .medium)
    }
    
    private let subTitle = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12,weight: .regular)
        $0.textColor = .systemGray
    }
    
    func configure(
        coverImgUrl: String?,
        title: String,
        subTitle: String
    ) {
        self.imageView.kf.setImage(with: URL(string: coverImgUrl ?? ""))
        self.title.text = title
        self.subTitle.text = subTitle
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        initialLayout()
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
            $0.left.right.equalToSuperview().inset(8)
        }
        
        subTitle.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(8)
            $0.left.equalToSuperview().inset(8)
        }
    }
}
