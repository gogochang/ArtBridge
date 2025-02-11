//
//  ModalViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 8/11/24.
//

import UIKit
import RxSwift
import BlurUIKit

class ModalViewController: UIViewController {
    //MARK: - Properties
    private var disposeBag = DisposeBag()
    
    //MARK: - UI
    private let blurView = VariableBlurView().then {
        $0.dimmingTintColor = .white.withAlphaComponent(0.08)
        $0.dimmingOvershoot = .relative(fraction: 1)
    }
    
    private let containerView = UIView().then {
        $0.layer.cornerRadius = 24
        $0.layer.masksToBounds = true
    }
    
    private let titleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .suitB20
        $0.textColor = .white
        $0.text = "알람 전부 지우기"
    }
    
    private let subTitleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.font = .suitL14
        $0.textColor = .white
        $0.text = "모든 알람이 목록에서 제거됩니다. \n전부 지우시겠습니까?"
    }
    
    private let agreeButton = SelectionButton().then {
        $0.setCornerRadius(32)
        $0.setTitle("전부 지우기")
    }
    
    private let cancelButton = SelectionButton().then {
        $0.setCornerRadius(32)
        $0.setTitle("돌아가기")
    }
    
    private let innerShadowView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.shadowColor = UIColor.white.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowRadius = 2
        $0.layer.shadowOpacity = 0.2
        
        $0.layer.borderWidth = 10
        $0.layer.cornerRadius = 34
    }
    
    //MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .black.withAlphaComponent(0.3)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("seijlfsjf ModalViewController viewDidload : ")
        setupViews()
        initiaLayout()
        
        inputView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    //MARK: - Methods
    private func inputView() {
        self.view.rx.tapGesture()
            .bind { _ in
                self.dismiss(animated: false)
            }.disposed(by: disposeBag)
    }
}

//MARK: - Layout
extension ModalViewController {
    private func setupViews() {
        view.addSubview(containerView)
        
        containerView.addSubviews([
            blurView,
            innerShadowView,
            titleLabel,
            subTitleLabel,
            agreeButton,
            cancelButton
        ])
    }
    
    private func initiaLayout() {
        blurView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(340 * 2) //FIXME: 근본적인 해결방법이 아닙니다.
        }
        
        innerShadowView.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(-10)
            $0.bottom.right.equalToSuperview().offset(10)
        }
        
        containerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(345)
            $0.height.equalTo(340)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(56)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.left.right.equalTo(titleLabel)
        }
        
        agreeButton.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(32)
            $0.height.equalTo(64)
        }
        
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(agreeButton.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(32)
            $0.height.equalTo(64)
        }
    }
}
