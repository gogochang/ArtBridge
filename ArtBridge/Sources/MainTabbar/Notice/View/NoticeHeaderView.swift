//
//  NoticeHeaderView.swift
//  ArtBridge
//
//  Created by 김창규 on 1/26/25.
//

import UIKit

class NoticeHeaderView: UICollectionReusableView {
    // MARK: - Properties
    
    // MARK: - UI
    private let label: UILabel = {
        let label = UILabel()
        label.text = "전체 52개"
        label.textColor = .disableText
        label.font = .nanumEB15
        return label
    }()
    
//    let orderButton = SelectionButton(title: "최신순", icon: UIImage(named: "downArrow")).then {
//        $0.layer.borderWidth = 0
//    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        initialLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configure(with itemCount: Int) {
        isHidden = itemCount == 0
        label.text = "전체 \(itemCount)개"
    }
}

// MARK: - Layout
extension NoticeHeaderView {
    private func setupViews() {
        addSubviews([
            label,
//            orderButton
        ])
    }
    
    private func initialLayout() {
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(20)
        }
        
//        orderButton.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.right.equalToSuperview()
//        }
    }
}

extension NoticeHeaderView {
    static let id = "\(NoticeHeaderView.self)"
    
    static let size: CGSize = .init(width: UIScreen.main.bounds.width, height: 33)
}
