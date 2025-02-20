//
//  LoginViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 6/4/24.
//

import UIKit
import RxSwift
import RxGesture

final class LoginViewController: UIViewController {
    // MARK: - Properties
    private var disposeBag = DisposeBag()
    private var viewModel: LoginViewModel
    
    // MARK: - UI
    private var backgroundImageView = UIImageView().then {
        $0.backgroundColor = .systemBrown
        $0.image = UIImage(named: "Launch")
        $0.contentMode = .scaleAspectFill
    }
    
    private let iconImageView = UIImageView().then {
        $0.backgroundColor = .systemBrown
        $0.contentMode = .scaleAspectFill
        $0.isHidden = true
    }
    
    private var loginButtonVStackView = UIStackView.make(
        with: [],
        axis: .vertical,
        alignment: .center,
        distribution: .equalSpacing,
        spacing: 16
    )
    
    private var kakaoLoginButton = UIImageView().then {
        $0.image = UIImage(named: "Kakao_login")
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 5
    }
    
    private var naverLoginButton = UIImageView().then {
        $0.image = UIImage(named: "Naver_login")
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 5
    }
    
    private var appleLoginButton = UIImageView().then {
        $0.image = UIImage(named: "Apple_login")
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: - Init
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initialLayout()
        viewModelInputs()
    }
    
    private func viewModelInputs() {
        kakaoLoginButton.rx.tapGesture()
            .debug()
            .when(.recognized).map { _ in }
            .bind(to: viewModel.inputs.kakaoLogin)
            .disposed(by: disposeBag)
        
        naverLoginButton.rx.tapGesture()
            .debug()
            .when(.recognized).map { _ in }
            .bind(to: viewModel.inputs.kakaoLogin)
            .disposed(by: disposeBag)
        
        appleLoginButton.rx.tapGesture()
            .debug()
            .when(.recognized).map { _ in }
            .bind(to: viewModel.inputs.kakaoLogin)
            .disposed(by: disposeBag)
    }
}

// MARK: - Layout
extension LoginViewController {
    private func setupViews() {
        self.view.addSubviews([
            backgroundImageView,
            iconImageView,
            loginButtonVStackView
        ])
        loginButtonVStackView.addArrangedSubview(kakaoLoginButton)
        loginButtonVStackView.addArrangedSubview(naverLoginButton)
        loginButtonVStackView.addArrangedSubview(appleLoginButton)
    }
    
    private func initialLayout() {
        self.view.backgroundColor = .systemBrown
        backgroundImageView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(200)
            $0.width.centerX.equalToSuperview()
            $0.height.equalTo(100)
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
