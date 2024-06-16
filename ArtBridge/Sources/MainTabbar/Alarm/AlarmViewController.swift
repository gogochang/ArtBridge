//
//  AlarmViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 6/16/24.
//

import UIKit
import RxSwift

final class AlarmViewController: UIViewController {
    //MARK: - Properties
    private let viewModel: AlarmViewModel
    private var disposeBag = DisposeBag()
    
    //MARK: - UI
    private let navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.title.text = "알람"
    }
    
    //MARK: - Init
    init(viewModel: AlarmViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        setupViews()
        initialLayout()
        
        viewModelInput()
    }
    
    //MARK: - Methods
    private func viewModelInput() {
        navBar.leftBtnItem.rx.tap
            .bind(to: viewModel.inputs.backward)
            .disposed(by: disposeBag)
    }
}

//MARK: - Layout
extension AlarmViewController {
    private func setupViews() {
        view.addSubviews([
            navBar
        ])
    }
    
    private func initialLayout() {
        self.view.backgroundColor = .white
        
        navBar.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
    }
}
