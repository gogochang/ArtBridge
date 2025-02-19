//
//  HomeHeaderView.swift
//  ArtBridge
//
//  Created by 김창규 on 2/7/25.
//

import UIKit
import RxSwift

final class HomeHeaderView: UICollectionReusableView {
    static let id = "\(HomeHeaderView.self)"
    
    // MARK: - Properties
    var disposeBag = DisposeBag()
    
    /// 셀에서 오른쪽 버튼의 탭 이벤트를 외부로 노출하는 subject
    let rightButtonTappedSubject = PublishSubject<Void>()
    
    // MARK: - UI
    private let titleLabel = UILabel().then {
        $0.font = .suitB20
        $0.textColor = .white
    }
    
    let arrowButton = ArtBridgeButton().then {
        $0.setImage(UIImage(named: "iconGo"), for: .normal)
        $0.setCornerRadius(20)
        $0.backgroundColor = .white.withAlphaComponent(0.08)
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        initialLayout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    // MARK: - Binding
    private func bind() {
        arrowButton.rx.tapGesture()
            .when(.recognized)
            .map { _ in }
            .bind(to: rightButtonTappedSubject)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Methods
    func configure(
        title: String
    ) {
        titleLabel.text = title
    }
}

// MARK: - Layout
extension HomeHeaderView {
    private func setupViews() {
        addSubviews([
            titleLabel,
            arrowButton
        ])
    }
    
    private func initialLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview()
        }
        
        arrowButton.snp.makeConstraints {
            $0.right.top.bottom.equalToSuperview()
            $0.size.equalTo(40)
        }
    }
}
