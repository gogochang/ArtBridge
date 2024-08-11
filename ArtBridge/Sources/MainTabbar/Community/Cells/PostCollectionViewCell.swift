//
//  PostCollectionViewCell.swift
//  ArtBridge
//
//  Created by 김창규 on 4/28/24.
//

import UIKit
import SnapKit
import RxSwift

final class PostCollectionViewCell: UICollectionViewCell {
    static let id = "PostCollectionViewCell"
    //MARK: - Properties
    var disposeBag = DisposeBag()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        initialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    private let imageView = UIImageView().then {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 10
    }
    
    private let titelLabel = UILabel().then {
        $0.text = "Title"
        $0.textColor = .darkText
        $0.contentMode = .left
    }
    
    private let subTitelLabel = UILabel().then {
        $0.text = "SubTitle"
        $0.textColor = .darkText
        $0.contentMode = .left
    }
    
    let moreButton = UIButton().then {
        $0.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        $0.tintColor = .darkText
    }
    
    //MARK: - Methods
    func configure() {
        disposeBag = DisposeBag()
    }
}

//MARK: - Layout
extension PostCollectionViewCell {
    private func setupViews() {
        addSubviews([
            imageView,
            moreButton,
            titelLabel,
            subTitelLabel
        ])
    }
    
    private func initialLayout() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray6.cgColor
        
        imageView.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview().inset(8)
            $0.width.equalTo(imageView.snp.height)
        }
        
        titelLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.centerY).offset(-8)
            $0.left.equalTo(imageView.snp.right).offset(8)
            $0.right.equalToSuperview().inset(20)
        }
        
        subTitelLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.centerY).offset(8)
            $0.left.equalTo(imageView.snp.right).offset(8)
            $0.right.equalToSuperview().inset(20)
        }
        
        moreButton.snp.makeConstraints {
            $0.top.right.equalToSuperview().inset(8)
        }
    }
}
