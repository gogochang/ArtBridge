//
//  TutorProfileCollectionViewCell.swift
//  ArtBridge
//
//  Created by 김창규 on 5/18/24.
//

import UIKit

class TutorProfileCollectionViewCell: UICollectionViewCell {
    static let id = "TutorProfileCollectionViewCell"
    
    //MARK: - UI
    private let imageView = UIImageView().then {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 20
    }
    
    private let userNameLabel = UILabel().then {
        $0.text = "UserName"
        $0.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        $0.textColor = .black
    }
    
    private let starStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 4
    }
    
    private let reviewCount = UILabel().then {
        $0.text = "(5)"
        $0.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        $0.textColor = .darkGray
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        initialLayout()
        
        setupStars()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStars() {
        for _ in 0..<5 {
            let starImageView = UIImageView().then {
                $0.image = UIImage(systemName: "star.fill")
                $0.tintColor = .systemYellow
                $0.contentMode = .scaleAspectFit
                $0.snp.makeConstraints {
                    $0.size.equalTo(12)
                }
            }
            
            starStackView.addArrangedSubview(starImageView)
        }
    }
}

//MARK: - Layout
extension TutorProfileCollectionViewCell {
    private func setupViews() {
        self.addSubviews([
            imageView,
            userNameLabel,
            starStackView,
            reviewCount,
            lineView
        ])
    }
    
    private func initialLayout() {
        imageView.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(20)
            $0.size.equalTo(40)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(12)
            $0.bottom.equalTo(imageView.snp.centerY).inset(4)
        }
        
        starStackView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.centerY).offset(4)
            $0.left.equalTo(imageView.snp.right).offset(12)
            $0.height.equalTo(12)
        }
        
        reviewCount.snp.makeConstraints {
            $0.left.equalTo(starStackView.snp.right).offset(4)
            $0.centerY.equalTo(starStackView)
        }
        
        lineView.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
