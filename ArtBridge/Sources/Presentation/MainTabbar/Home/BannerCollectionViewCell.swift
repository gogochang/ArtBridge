//
//  BannerCollectionViewCell.swift
//  ArtBridge
//
//  Created by 김창규 on 4/26/24.
//

import UIKit
import Kingfisher

final class BannerCollectionViewCell: UICollectionViewCell {
    static let id = "BannerCollectionViewCell"
    
    // MARK: - Properties
    private let bannerImage = UIImageView().then {
        $0.backgroundColor = .systemGray6
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.image = UIImage(named: "section-thumbnail-item")
    }
    
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
        bannerImage.image = nil
    }
    
    // MARK: - Methods
//    func configure(bannerModel: BannerModel) {
//        let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.1))]
//        
//        bannerImage.kf.setImage(
//            with: URL(string: bannerModel.imageUrl),
//            options: options
//        )
//    }
}

// MARK: - CompositionalLayout
extension BannerCollectionViewCell {
    private func setupViews() {
        self.addSubviews([
            bannerImage
        ])
    }
    
    private func initialLayout() {
        bannerImage.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
    }
}
