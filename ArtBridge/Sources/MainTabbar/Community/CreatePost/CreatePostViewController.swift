//
//  CreatePostViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 7/30/24.
//

import UIKit
import RxSwift

final class CreatePostViewController: UIViewController {
    //MARK: - Properties
    private let viewModel: CreatePostViewModel
    private let disposeBag = DisposeBag()
    
    //MARK: - UI
    private let navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.title.text = "게시글 작성"
    }
    
    //MARK: - Init
    init(viewModel: CreatePostViewModel) {
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
extension CreatePostViewController {
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
