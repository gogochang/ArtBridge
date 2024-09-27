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
        $0.rightBtnItem.setTitle("등록", for: .normal)
        $0.title.text = "게시글 작성"
        $0.hDivider.isHidden = false
    }
    
    private let selectCategoryView = SelectCategoryView()
    
    private let hDivider1 = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    
    private let titleTextField = UITextField().then {
        $0.placeholder = "제목을 입력해주세요."
        $0.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    private let artBridgeInputTextView = ArtBridgeInputTextView()
    
    private let createPostBottomView = CreatePostBottomView().then {
        $0.backgroundColor = .orange
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
            navBar,
            selectCategoryView,
            hDivider1,
            titleTextField,
            artBridgeInputTextView,
            createPostBottomView
        ])
    }
    
    private func initialLayout() {
        view.backgroundColor = .white
        
        navBar.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        selectCategoryView.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        
        hDivider1.snp.makeConstraints {
            $0.top.equalTo(selectCategoryView.snp.bottom)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
        
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(hDivider1.snp.bottom)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }
        
        artBridgeInputTextView.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(20)
            $0.bottom.equalTo(createPostBottomView.snp.top).offset(-20)
        }
        
        createPostBottomView.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(100)
        }
    }
}
