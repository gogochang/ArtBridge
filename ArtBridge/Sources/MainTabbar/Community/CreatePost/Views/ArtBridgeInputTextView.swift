//
//  ArtBridgeInputTextView.swift
//  ArtBridge
//
//  Created by 김창규 on 9/19/24.
//

import UIKit

final class ArtBridgeInputTextView: UIView {
    //MARK: - Properties
    //MARK: - UI
    private let placeHolderLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .lightGray
    }
    
    private let textView = UITextView().then {
        $0.contentInset = .zero
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textContainerInset = .zero
        $0.textContainer.lineFragmentPadding = 0
    }
    
    //MARK: - Init
    init(placeHolder: String = "내용을 입력해주세요.") {
        super.init(frame: .zero)
        
        placeHolderLabel.text = placeHolder
        setupViews()
        initialLayout()
        
        textView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
}

//MARK: - UITextViewDelegate
extension ArtBridgeInputTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeHolderLabel.isHidden = !textView.text.isEmpty
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.isHidden = true
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.isHidden = false
            textView.textColor = .lightGray
        }
    }
}

//MARK: - Layout
extension ArtBridgeInputTextView {
    private func setupViews() {
        addSubviews([
            textView,
        ])
        
        textView.addSubview(placeHolderLabel)
    }
    
    private func initialLayout() {
        textView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
        
        placeHolderLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview()
        }
    }
}
