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
    
    //MARK: - Properties
    private let bannerImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "BannerImage"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        initialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func configure(bannerModel: BannerModel) {
        bannerImage.backgroundColor = bannerModel.color
    }
}


//MARK: - CompositionalLayout
extension BannerCollectionViewCell {
    private func setupViews() {
        self.addSubviews([
            bannerImage,
            titleLabel])
    }
    
    private func initialLayout() {
        bannerImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
