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
        view.backgroundColor = .systemGray6
    }
    
    private var homeBtn = UIButton().then { button in
        button.setTitle("홈", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.snp.makeConstraints { make in
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
    }
    
    private var postBtn = UIButton().then { button in
        button.setTitle("게", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.snp.makeConstraints { make in
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
    }
    
    private var messageBtn = UIButton().then { button in
        button.setTitle("메", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.snp.makeConstraints { make in
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
    }
    
    private var myPageBtn = UIButton().then { button in
        button.setTitle("내", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.snp.makeConstraints { make in
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
    }
    
    private lazy var bottomContentHStack = UIStackView.make(
        with: [homeBtn,postBtn, messageBtn, myPageBtn],
        axis: .horizontal,
        alignment: .center,
        distribution: .equalCentering,
        spacing: 0
    )
}

//MARK: - Layout
extension MainTabController {
    private func setupViews() {
        view.addSubviews([
            mainContentView,
            bottomView,
        ])
        
        bottomView.addSubviews([bottomContentHStack])
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
        
        bottomContentHStack.snp.makeConstraints { make in
            make.top.equalTo(bottomView.snp.top).offset(14)
            make.leading.equalTo(bottomView.snp.leading).offset(36)
            make.trailing.equalTo(bottomView.snp.trailing).offset(-36)
        }
    }
}
