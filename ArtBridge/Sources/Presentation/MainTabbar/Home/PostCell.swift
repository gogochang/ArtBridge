//
//  PostCell.swift
//  ArtBridge
//
//  Created by 김창규 on 2/7/25.
//

import UIKit
import RxSwift
import BlurUIKit

final class PostCell: UICollectionViewCell {
    // MARK: - Properties
    
    static let id = "\(PostCell.self)"
    var disposeBag = DisposeBag()
    
    // MARK: - UI
    private let blurView = VariableBlurView()
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .systemGray
        $0.image = UIImage(named: "section-thumbnail-item")
    }
    
    private let profileImageView = UIImageView().then {
        $0.backgroundColor = .systemGray
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.image = UIImage(named: "testProfile")
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "이루마 클래식 라디오 DJ 발탁"
        $0.textColor = .white
        $0.font = .suitR16
    }
    
    private let countLabel = UILabel().then {
        $0.text = "조회수 0  •  관객 0"
        $0.textColor = .white.withAlphaComponent(0.56)
        $0.font = .suitR14
    }
    
    // MARK: - Init
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupViews()
        initialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    // MARK: - Methods
    
    func configure() {}
}

// MARK: - Layout

extension PostCell {
    private func setupViews() {
        contentView.layer.cornerRadius = 24
        contentView.clipsToBounds = true
        contentView.addSubviews([
            imageView,
            blurView,
            profileImageView,
            titleLabel,
            countLabel
        ])
        
        blurView.dimmingTintColor = .black.withAlphaComponent(0.4)
        blurView.dimmingOvershoot = .relative(fraction: 1)
    }
    
    private func initialLayout() {
        imageView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
        
        blurView.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(72)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.bottom.equalTo(blurView).inset(16)
            $0.left.equalTo(blurView).inset(8)
            $0.size.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView)
            $0.left.equalTo(profileImageView.snp.right).offset(8)
            $0.right.equalTo(blurView).inset(8)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.left.right.equalTo(titleLabel)
        }
    }
}
