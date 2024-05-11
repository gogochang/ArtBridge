//
//  PopularPostListViewcontroller.swift
//  ArtBridge
//
//  Created by 김창규 on 5/10/24.
//

import UIKit
import RxSwift

fileprivate enum Section {
    
}

fileprivate enum Item {
    
}

final class PopularPostListViewcontroller: UIViewController {
    //MARK: - Properties
    private let viewModel: PopularPostListViewModel
    private let disposeBag: DisposeBag = DisposeBag()
    
    //MARK: - UI
    private var navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.rightBtnItem.setImage(UIImage(systemName: "bell"), for: .normal)
    }
    
    //MARK: - Init
    init(viewModel: PopularPostListViewModel) {
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
            .bind (to: viewModel.inputs.backward )
            .disposed(by: disposeBag)
    }
}

//MARK: - Layout
extension PopularPostListViewcontroller {
    private func setupViews() {
        view.addSubviews([
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
