//
//  TutorInfoCollectionViewCell.swift
//  ArtBridge
//
//  Created by 김창규 on 5/19/24.
//

import UIKit

class TutorInfoCollectionViewCell: UICollectionViewCell {
    static let id = "TutorInfoCollectionViewCell"
    //MARK: - Properties
    //TODO: 외부에서 받아서 사용
    let title = ["악기종류", "지역", "가격대", "추가내용"]
    let subTitle = ["바이올린", "서울", "4,5000원", "상담가능"]
    
    //MARK: - UI
    private let infoStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 20
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        initialLayout()
        setupInfo()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Layout
extension TutorInfoCollectionViewCell {
    private func setupViews() {
        self.addSubviews([
            infoStackView
        ])
        
    }
    
    private func initialLayout() {
        infoStackView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
    }
    
    private func setupInfo() {
        for i in 0..<title.count{
            let containerView = UIView()
            
            let title = UILabel().then {
                $0.font = .systemFont(ofSize: 16, weight: .bold)
                $0.textColor = .systemGray4
                $0.text = self.title[i]
            }
            
            let subTitle = UILabel().then {
                $0.font = .systemFont(ofSize: 16, weight: .bold)
                $0.textColor = .darkGray
                $0.text = self.subTitle[i]
            }
            
            containerView.addSubviews([title, subTitle])
            
            title.snp.makeConstraints {
                $0.left.equalToSuperview()
                $0.centerY.equalToSuperview()
                $0.width.equalTo(80)
            }
            
            subTitle.snp.makeConstraints {
                $0.left.equalTo(title.snp.right).offset(20)
                $0.centerY.equalToSuperview()
            }
            
            infoStackView.addArrangedSubview(containerView)
        }
    }
}
