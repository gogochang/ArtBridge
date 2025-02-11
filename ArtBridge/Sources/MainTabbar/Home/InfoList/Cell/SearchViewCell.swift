//
//  SearchViewCell.swift
//  ArtBridge
//
//  Created by 김창규 on 2/8/25.
//

import UIKit

final class SearchViewCell: UICollectionViewCell {
    static let id = "\(SearchViewCell.self)"
    
    // MARK: UI
    private let searchView = SearchView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        initialLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension SearchViewCell {
    private func setupViews() {
        addSubview(searchView)
    }
    
    private func initialLayout() {
        searchView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
    }
}
