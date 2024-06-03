//
//  NewsContentCollectionViewCell.swift
//  ArtBridge
//
//  Created by 김창규 on 6/3/24.
//

import UIKit
//TODO: - DetailPost와 DetailNews의 Content가 중복되어 사용되기 때문에 통일 필요
final class NewsContentCollectionViewCell: UICollectionViewCell {
    static let id = "NewsContentCollectionViewCell"
    
    //MARK: - UI
    private let content = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.text = "국회의원의 선거구와 비례대표제 기타 선거에 관한 사항은 법률로 정한다. 헌법재판소의 조직과 운영 기타 필요한 사항은 법률로 정한다. 헌법재판소는 법률에 저촉되지 아니하는 범위안에서 심판에 관한 절차, 내부규율과 사무처리에 관한 규칙을 제정할 수 있다. 평화통일정책의 수립에 관한 대통령의 자문에 응하기 위하여 민주평화통일자문회의를 둘 수 있다.국회의원의 선거구와 비례대표제 기타 선거에 관한 사항은 법률로 정한다. 헌법재판소의 조직과 운영 기타 필요한 사항은 법률로 정한다. 헌법재판소는 법률에 저촉되지 아니하는 범위안에서 심판에 관한 절차, 내부규율과 사무처리에 관한 규칙을 제정할 수 있다. 평화통일정책의 수립에 관한 대통령의 자문에 응하기 위하여 민주평화통일자문회의를 둘 수 있다.국회의원의 선거구와 비례대표제 기타 선거에 관한 사항은 법률로 정한다. 헌법재판소의 조직과 운영 기타 필요한 사항은 법률로 정한다. 헌법재판소는 법률에 저촉되지 아니하는 범위안에서 심판에 관한 절차, 내부규율과 사무처리에 관한 규칙을 제정할 수 있다. 평화통일정책의 수립에 관한 대통령의 자문에 응하기 위하여 민주평화통일자문회의를 둘 수 있다."
        $0.numberOfLines = 0
        
        let attrString = NSMutableAttributedString(string: $0.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        $0.attributedText = attrString
    }
    
    private let likeIcon = UIImageView().then {
        $0.image = UIImage(systemName: "heart")
        $0.tintColor = .darkText
    }
    
    private let likeCount = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .darkText
        $0.text = "28"
    }
    
    private let commentIcon = UIImageView().then {
        $0.image = UIImage(systemName: "ellipsis.message")
        $0.tintColor = .darkText
    }
    
    private let commentCount = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .darkText
        $0.text = "62"
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        initialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Layout
extension NewsContentCollectionViewCell {
    private func setupViews() {
        addSubviews([
            content,
            likeIcon,
            likeCount,
            commentIcon,
            commentCount
        ])
    }
    
    private func initialLayout() {
        content.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        likeIcon.snp.makeConstraints {
            $0.top.equalTo(content.snp.bottom).offset(40)
            $0.left.bottom.equalToSuperview().inset(20)
            $0.size.equalTo(20)
        }
        
        likeCount.snp.makeConstraints {
            $0.left.equalTo(likeIcon.snp.right).offset(12)
            $0.centerY.equalTo(likeIcon)
        }
        
        commentIcon.snp.makeConstraints {
            $0.top.equalTo(content.snp.bottom).offset(40)
            $0.left.equalTo(likeCount.snp.right).offset(32)
            $0.size.equalTo(20)
        }
        
        commentCount.snp.makeConstraints {
            $0.left.equalTo(commentIcon.snp.right).offset(12)
            $0.centerY.equalTo(likeIcon)
        }
    }
}
