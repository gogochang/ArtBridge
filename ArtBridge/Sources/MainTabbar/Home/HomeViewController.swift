//
//  HomeViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 4/25/24.
//

import UIKit
import RxSwift

final class HomeViewController: BaseViewController {
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let viewModel: HomeViewModel
    
    // MARK: - UI
    private var navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setImage(UIImage(named: "logo"), for: .normal)
        $0.rightBtnItem.setImage(UIImage(systemName: "bell"), for: .normal)
        $0.searchView.isHidden = false
    }
    
    private var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    private var stackView = UIStackView().then {
        $0.spacing = 20
        $0.axis = .vertical
        $0.alignment = .fill
    }
    
    // MARK: - Init
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initialLayout()
        

        viewModelInputs()
        viewModelOutput()

    }
    
    // MARK: - Methods
    private func viewModelInputs() {
        navBar.rightBtnItem.rx.tap
            .bind(to: viewModel.inputs.showAlarm)
            .disposed(by: disposeBag)
    }
    
    private func viewModelOutput() {
    }
}

//MARK: - Layout
extension HomeViewController {
    private func setupViews() {
        view.addSubviews([
            scrollView
        ])
        
        scrollView.addSubview(stackView)  // stackView를 scrollView에 추가
        stackView.addArrangedSubview(navBar)
    }
    
    private func initialLayout() {
        scrollView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
            $0.width.equalToSuperview()  // stackView의 너비를 scrollView와 같게 설정
        }
    }
}
