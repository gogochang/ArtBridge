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
    
    private let textContainerView = UIView().then {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 5
    }
    
    let textView = UITextView().then {
        $0.backgroundColor = .clear
        $0.text = "댓글을 입력해주세요."
        $0.textColor = .systemGray
        $0.font = .systemFont(ofSize: 16)
    }
    
    let createButton = UIButton().then {
        $0.setTitle("등록", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 5
        $0.isHidden = true
    }
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        
        setupViews()
        initialLayout()
        textView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - TextView Delegate
extension CommentInputView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "댓글을 입력해주세요." {
            textView.text = nil
            textView.textColor = .darkText
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let numberOfLine = textView.numberOfLine()
        
        createButton.isHidden = textView.text.isEmpty
        
        if numberOfLine >= 5 {
            return
        }
        
        let addHeight = ( textView.numberOfLine() - 1 ) * 19
        // Update textView's height
        contentView.snp.remakeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
            $0.height.equalTo(44 + 50 + addHeight)//TODO: safeArea bottom height
        }

        textContainerView.snp.updateConstraints {
            $0.height.equalTo(44 + addHeight)
        }

        // Animate layout changes
        UIView.animate(withDuration: 0.2) {
            self.superview?.layoutIfNeeded()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "댓글을 입력해주세요."
            textView.textColor = .systemGray
        }
    }
}

//MARK: - Layout
extension CommentInputView {
    private func setupViews() {
        addSubviews([
            contentView
        ])
        
        contentView.addSubviews([
            textContainerView,
        ])
        
        textContainerView.addSubviews([
            textView,
            createButton
        ])
    }
    
    private func initialLayout() {
        contentView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
            $0.height.equalTo(44 + 50)//TODO: safeArea bottom height
        }
        
        textContainerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }
        
        textView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.left.equalToSuperview().inset(8)
            $0.right.equalTo(createButton.snp.left).offset(-4)
        }
        
        createButton.snp.makeConstraints {
            $0.bottom.right.equalToSuperview().inset(8)
            $0.width.equalTo(50)
        }
    }
}


