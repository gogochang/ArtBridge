//
//  NoticeCell.swift
//  ArtBridge
//
//  Created by 김창규 on 1/26/25.
//

import UIKit

/**
 `PharmacyCell` 클래스는 약국 정보를 표시하는 커스텀 `UICollectionViewCell`입니다.
 
 약국 태그, 이름, 주소, 운영 시간을 포함한 다양한 정보를 사용자에게 보여줍니다. 또한,
 거리 정보와 운영 시간에 따라 UI 레이아웃이 동적으로 변경됩니다.
 
 - 주요 구성 요소:
    - `tagLabel`: 약국의 태그를 표시하는 라벨.
    - `titleLabel`: 약국의 이름을 표시하는 라벨.
    - `addressLabel`: 약국의 주소와 거리 정보를 표시하는 라벨.
    - `pharmacyTimeView`: 약국의 운영 시간을 표시하는 커스텀 뷰.
 
 - 주요 메서드:
    - `configure(with:)`: `Pharmacy` 객체를 기반으로 셀을 설정합니다.
    - `configurePharmacyTimeView(with:)`: 운영 시간 뷰를 설정합니다.
    - `updateAddressLabelBottomConstraint(shouldMoveToBottom:)`: 주소 라벨의 제약 조건을 업데이트합니다.
 
 - 상수:
    - `id`: 셀의 식별자.
    - `size`: 셀의 크기.
 
 - Author: 김창규
 - Version: 1.0
 - Since: 1/16/25
 */
final class NoticeCell: UICollectionViewCell {
    
    // MARK: - UI
    
    // 공고 이미지
    private let imageView = UIImageView().then {
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    private let bookmark = UIImageView(image: UIImage(systemName: "bookmark")).then {
        $0.tintColor = .white
    }
    
    // 공고 제목
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .defaultText6
        label.font = .nanumB15
        return label
    }()
    
    // 조직 이름
    private let organizationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .nanumB12
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupViews()
        initialLayout()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // layoutIfNeeded()로 레이아웃 강제 업데이트
        imageView.layoutIfNeeded()
        // 이미지뷰의 크기가 확정된 후 그라데이션을 다시 설정
        addGradientToImageView()
    }
    
    // MARK: - Methods
    /**
     `PharmacyCell`를 설정하는 메서드입니다.
     
     - Parameters:
        - item: `Pharmacy` 객체로, 셀을 설정하는 데 필요한 정보를 담고 있습니다.
     */
    func configure(with item: (imageURL: String, title: String, organizationName: String)) {
        imageView.kf.setImage(with: URL(string: item.imageURL))
        titleLabel.text = item.title
        organizationLabel.text = item.organizationName
    }
    
    private func addGradientToImageView() {
        
        // 기존의 그라데이션 레이어를 제거
        imageView.layer.sublayers?.forEach { layer in
            if layer is CAGradientLayer {
                layer.removeFromSuperlayer()
            }
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = imageView.bounds
        gradientLayer.colors = [
            UIColor.black.withAlphaComponent(0.2).cgColor, // 상단 그라데이션
            UIColor.clear.cgColor // 하단은 투명
        ]
        gradientLayer.locations = [0, 1] // 그라데이션이 위에서 아래로 내려가게
        imageView.layer.addSublayer(gradientLayer)
    }
}
// MARK: - Layout
extension NoticeCell {
    private func setupViews() {
        
        layer.shadowOpacity = 0.12
        layer.shadowRadius = 6
        contentView.addSubviews([
            imageView,
            titleLabel,
            organizationLabel,
            bookmark
        ])
        
//        imageView.addSubviews([
//            
//        ])
        
    }
    
    private func initialLayout() {
        contentView.snp.makeConstraints {
            $0.width.equalTo((UIScreen.main.bounds.width / 2) - 20)
        }
        
        imageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(contentView.frame.width * 0.6)
        }
        
        bookmark.snp.makeConstraints {
            $0.top.right.equalToSuperview().inset(10)
            $0.size.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.left.equalTo(imageView).offset(4)
        }
        
        organizationLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.left.equalTo(titleLabel)
            $0.bottom.equalToSuperview().inset(10)
        }

    }
}

// MARK: - Constant
extension NoticeCell {
    static let id = "\(NoticeCell.self)"
    static let size: CGSize = .init(width: (UIScreen.main.bounds.width / 2) - 20, height: 108)
}
