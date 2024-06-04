//
//  LoginViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 6/4/24.
//

import UIKit
import RxSwift

final class LoginViewController: UIViewController {
    //MARK: - Properties
    private var disposeBag = DisposeBag()
    private var viewModel: LoginViewModel
    
    //MARK: - UI
    private var backgroundView = UIView().then {
        $0.backgroundColor = .systemBrown
    }
    
    private var loginButtonVStackView = UIStackView.make(
        with: [],
        axis: .vertical,
        alignment: .center,
        distribution: .equalSpacing,
        spacing: 16
    )
    
    private var kakaoLoginButton = UIButton().then {
        $0.backgroundColor = .systemYellow
        $0.layer.cornerRadius = 5
    }
    
    private var naverLoginButton = UIButton().then {
        $0.backgroundColor = .systemGreen
        $0.layer.cornerRadius = 5
    }
    
    private var appleLoginButton = UIButton().then {
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 5
    }
    
    //MARK: - Init
    init(viewModel: LoginViewModel) {
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
        viewModelInputs()
    }
    
    private func viewModelInputs() {
        kakaoLoginButton.rx.tap
            .bind(to: viewModel.inputs.kakaoLogin)
            .disposed(by: disposeBag)
        
        naverLoginButton.rx.tap
            .bind(to: viewModel.inputs.kakaoLogin)
            .disposed(by: disposeBag)
        
        appleLoginButton.rx.tap
            .bind(to: viewModel.inputs.kakaoLogin)
            .disposed(by: disposeBag)
    }
}

//MARK: - Layout
extension LoginViewController {
    private func setupViews() {
        self.view.addSubviews([
            backgroundView,
            loginButtonVStackView
        ])
        loginButtonVStackView.addArrangedSubview(kakaoLoginButton)
        loginButtonVStackView.addArrangedSubview(naverLoginButton)
        loginButtonVStackView.addArrangedSubview(appleLoginButton)
    }
    
    private func initialLayout() {
        self.view.backgroundColor = .systemBrown
        backgroundView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
        
        loginButtonVStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-40)
            make.left.equalTo(view.snp.left).offset(16)
            make.right.equalTo(view.snp.right).offset(-16)
        }
        
        kakaoLoginButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        naverLoginButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        appleLoginButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(60)
        }
    }
}
