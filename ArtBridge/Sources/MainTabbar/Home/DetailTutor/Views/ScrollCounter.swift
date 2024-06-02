//
//  ScrollCounter.swift
//  ArtBridge
//
//  Created by 김창규 on 5/18/24.
//

import UIKit

final class ScrollCounter: UIView {
    //MARK: - Properties
    var currentPage: Int {
        didSet {
            counterLabel.text = "\(currentPage)/\(maxPage)"
        }
    }
    
    private let maxPage: Int
    
    //MARK: - UI
    private let counterLabel = UILabel().then {
        $0.text = "0/0"
        $0.textColor = .white
        $0.font = UIFont.monospacedSystemFont(ofSize: 12, weight: .bold)
    }
    
    //MARK: - Init
    init(currentPage: Int = 1, maxPage: Int) {
        self.currentPage = currentPage
        self.maxPage = maxPage
        super.init(frame: .zero)
        self.backgroundColor = .red
        setupViews()
        initialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Layout
extension ScrollCounter {
    private func setupViews() {
        self.addSubviews([
            counterLabel
        ])
    }
    
    private func initialLayout() {
        self.backgroundColor = .black
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.layer.opacity = 0.5
        
        counterLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.left.right.equalToSuperview().inset(4)
        }
    }
}
