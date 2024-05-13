//
//  CommentFooterView.swift
//  ArtBridge
//
//  Created by 김창규 on 5/13/24.
//

import UIKit

final class CommentInputView: UIView {
    //MARK: - UI
    private let contentView = UIView().then {
        $0.backgroundColor = .white
    }
    
    let textView = UITextView().then {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 15
        $0.text = "댓글을 입력해주세요."
    }
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        
        setupViews()
        initialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Layout
extension CommentInputView {
    private func setupViews() {
        addSubviews([
            contentView
        ])
        
        contentView.addSubviews([
            textView,
        ])
    }
    
    private func initialLayout() {
        contentView.snp.makeConstraints {
            $0.left.bottom.right.top.equalToSuperview()
            $0.height.equalTo(44 + 50)//TODO: safeArea bottom height
        }
        
        textView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }
    }
}


