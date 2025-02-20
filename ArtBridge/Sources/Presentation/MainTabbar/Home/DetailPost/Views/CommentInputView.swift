//
//  CommentFooterView.swift
//  ArtBridge
//
//  Created by 김창규 on 5/13/24.
//

import UIKit

// TODO: 이름 변경 (댓글, 채팅 등등 여러환경에서 사용하기 때문에 좀 더 포괄적인 의미를 담은 이름 필요)
final class CommentInputView: UIView {
    // MARK: - Properties
    private var placeHolder: String?
    
    // MARK: - UI
    private let contentView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let textContainerView = UIView().then {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 5
    }
    
    let textView = UITextView().then {
        $0.backgroundColor = .clear
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
    
    private let lineView = UIView().then {
        $0.backgroundColor = .systemGray5
    }
    
    // MARK: - Init
    init(placeHolder: String) {
        super.init(frame: .zero)
        
        self.placeHolder = placeHolder
        textView.text = placeHolder
        
        setupViews()
        initialLayout()
        textView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - TextView Delegate
extension CommentInputView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == self.placeHolder {
            textView.text = nil
            textView.textColor = .darkText
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        let numberOfLine = textView.numberOfLine()
        
        createButton.isHidden = textView.text.isEmpty
        
        if numberOfLine >= 5 {
            return
        }
        
        let addHeight = ( textView.numberOfLine() - 1 ) * 19
        // Update textView's height
        contentView.snp.remakeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
            $0.height.equalTo(44 + 50 + addHeight)// TODO: safeArea bottom height
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
            textView.text = self.placeHolder
            textView.textColor = .systemGray
        }
    }
}

// MARK: - Layout
extension CommentInputView {
    private func setupViews() {
        addSubviews([
            contentView
        ])
        
        contentView.addSubviews([
            lineView,
            textContainerView
        ])
        
        textContainerView.addSubviews([
            textView,
            createButton
        ])
    }
    
    private func initialLayout() {
        contentView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
            $0.height.equalTo(44 + 50)// TODO: safeArea bottom height
        }
        
        lineView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(1)
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
