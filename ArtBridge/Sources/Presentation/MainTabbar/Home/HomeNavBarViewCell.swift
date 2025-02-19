//
//  HomeNavBarViewCell.swift
//  ArtBridge
//
//  Created by 김창규 on 2/7/25.
//

import UIKit
import RxSwift

final class HomeNavBarViewCell: UICollectionViewCell {
    // MARK: - Properties
    var disposeBag = DisposeBag()
    
    /// 셀에서 오른쪽 버튼의 탭 이벤트를 외부로 노출하는 subject
    let rightButtonTappedSubject = PublishSubject<Void>()
    
    // MARK: UI
    let navBar = ArtBridgeNavBar().then {
        $0.leftButton.setImage(UIImage(named: "logo"), for: .normal)
        $0.rightButton.setImage(UIImage(named: "notice"), for: .normal)
        $0.searchView.isHidden = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        initialLayout()
        bind()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Binding
    private func bind() {
        navBar.rightButton.rx.tapGesture()
            .when(.recognized)
            .map { _ in }
            .bind(to: rightButtonTappedSubject)
            .disposed(by: disposeBag)
    }
}

// MARK: - Layout
extension HomeNavBarViewCell {
    private func setupViews() {
        addSubview(navBar)
    }
    
    private func initialLayout() {
        navBar.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
    }
}

extension HomeNavBarViewCell {
    static let id = "\(HomeNavBarViewCell.self)"
}
