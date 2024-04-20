//
//  MainTabController.swift
//  ArtBridge
//
//  Created by 김창규 on 4/20/24.
//

import UIKit
import Then
import SnapKit

class MainTabController: UIViewController {
    override func viewDidLoad() {
        setupViews()
        initLayout()
    }
    
    init(viewModel: MainTabViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Properties
    private let viewModel: MainTabViewModel
    
    var viewControllers: [UIViewController] = []
    
    //MARK: - UI
    private var mainContentView = UIView().then { view in
        view.backgroundColor = .orange
    }
    
    private var bottomView = UIView().then { view in
        view.backgroundColor = .blue
    }
}

//MARK: - Layout
extension MainTabController {
    private func setupViews() {
        view.addSubviews([
            mainContentView,
            bottomView,
        ])
    }
    
    private func initLayout() {
        mainContentView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top)
            $0.left.right.equalTo(view)
        }
        
        bottomView.snp.makeConstraints {
            $0.top.equalTo(mainContentView.snp.bottom)
            $0.left.right.equalTo(mainContentView)
            $0.bottom.equalTo(view.snp.bottom)
            $0.height.equalTo(100)//FIXME: 임시로 처리
        }
    }
}
