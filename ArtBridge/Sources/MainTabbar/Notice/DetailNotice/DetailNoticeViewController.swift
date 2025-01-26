//
//  DetailNoticeViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 1/26/25.
//

import UIKit
import RxSwift

final class DetailNoticeViewController: BaseViewController {
    //MARK: - Properties
    private let viewModel: DetailNoticeViewModel
    private let disposeBag: DisposeBag = DisposeBag()
    
    //MARK: - UI
    private let navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.rightBtnItem.setImage(UIImage(systemName: "ellipsis"), for: .normal)
    }
    
    //MARK: - Init
    init(viewModel: DetailNoticeViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        initialLayout()
        
        viewModelInput()
        viewModelOutput()
    }
    
    //MARK: - Methods
    private func viewModelInput() {
        navBar.leftBtnItem.rx.tap
            .bind(to: viewModel.inputs.backward)
            .disposed(by: disposeBag)
    }
    
    private func viewModelOutput() {
        
    }
}

//MARK: - Layout
extension DetailNoticeViewController {
    private func setupViews() {
        view.addSubviews([
            navBar
        ])
    }
    
    private func initialLayout() {
        navBar.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
    }
}

