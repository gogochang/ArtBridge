//
//  SettingViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 6/7/24.
//

import UIKit
import RxSwift

final class SettingViewController: UIViewController {
    //MARK: - Properties
    private let disposeBag = DisposeBag()
    private let viewModel: SettingViewModel
    
    //MARK: - UI
    private var navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.title.text = "설정하기"
    }
    
    //MARK: - Init
    init(viewModel: SettingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initialLayout()
        
        viewModelInput()
    }
    
    private func viewModelInput() {
        navBar.leftBtnItem.rx.tap
            .bind(to: viewModel.inputs.backward)
            .disposed(by: disposeBag)
    }
}

//MARK: - Layout
extension SettingViewController {
    private func setupViews() {
        self.view.addSubviews([
            navBar
        ])
    }
    
    private func initialLayout() {
        view.backgroundColor = .white
        
        navBar.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
    }
}
