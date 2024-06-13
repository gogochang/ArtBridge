//
//  DetailInstrumentViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 6/13/24.
//

import UIKit
import RxSwift

fileprivate enum Section: Hashable {
    
}

fileprivate enum Item: Hashable {
    
}

final class DetailInstrumentViewController: UIViewController {
    //MARK: - Properties
    private let viewModel: DetailInstrumentViewModel
    private let disposeBag = DisposeBag()
    
    //MARK: - UI
    private let navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.title.text = "악기 상세보기"
    }
    
    //MARK: - Init
    init(viewModel: DetailInstrumentViewModel) {
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
extension DetailInstrumentViewController {
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
