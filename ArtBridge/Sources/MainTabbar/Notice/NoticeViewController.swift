//
//  NoticeViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 1/25/25.
//

import UIKit

final class NoticeViewController: BaseViewController {
    //MARK: - Properties
    private let viewModel: NoticeViewModel
    
    //MARK: - UI
    private var navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setTitle("공고", for: .normal)
        $0.leftBtnItem.setTitleColor(.black, for: .normal)
        $0.leftBtnItem.titleLabel?.font = .jalnan20
        $0.searchView.isHidden = false
    }
    
    private let bannerView = UIImageView().then {
        $0.kf.setImage(with: URL(string: "https://siqqojzclugpskrqnwyu.supabase.co/storage/v1/object/sign/testImage/banner_temp.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJ0ZXN0SW1hZ2UvYmFubmVyX3RlbXAucG5nIiwiaWF0IjoxNzM3ODE0NDg3LCJleHAiOjE3Mzg0MTkyODd9.G7pDsR14BcE9ZkjvesnTVO6yF75o4UxK0jQYjrLafZg&t=2025-01-25T14%3A14%3A48.225Z")!)
    }
    
    private let kindButton = SelectionButton(title: "전체", icon: UIImage(named: "downArrow"))
    private let regionButton = SelectionButton(title: "지역", icon: UIImage(named: "downArrow"))
    private let careerButton = SelectionButton(title: "경력", icon: UIImage(named: "downArrow"))
    private let horizontalScrollFilterButtonView = ButtonScrollView()
    
    //MARK: - Init
    init(viewModel: NoticeViewModel) {
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
    let test = UIView()
    //MARK: - Methods
    private func viewModelInput() {
    }
    
    private func viewModelOutput() {
        
    }
    

}

//MARK: - Layout
extension NoticeViewController {
    private func setupViews() {
        horizontalScrollFilterButtonView.addArrangedSubviews(buttons: [kindButton, regionButton, careerButton])
        
        view.addSubviews([
            navBar,
            bannerView,
            horizontalScrollFilterButtonView
        ])
    }
    
    private func initialLayout() {
        navBar.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        bannerView.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        horizontalScrollFilterButtonView.snp.makeConstraints {
            $0.top.equalTo(bannerView.snp.bottom).offset(20)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(54)
        }
    }
}
