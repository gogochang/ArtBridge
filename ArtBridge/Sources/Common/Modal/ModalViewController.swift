//
//  ModalViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 8/11/24.
//

import UIKit
import RxSwift

class ModalViewController: UIViewController {
    //MARK: - Properties
    private var disposeBag = DisposeBag()
    
    //MARK: - UI
    private let containerView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.backgroundColor = .systemGray6
    }
    
    private let vStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.spacing = 1
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
        view.addSubviews([
            containerView,
        ])
        
        containerView.addSubviews([
            vStackView
        ])
        
        let button1 = UIButton().then {
            $0.backgroundColor = .white
            $0.setTitle("수정", for: .normal)
            $0.setTitleColor(.darkText, for: .normal)
            $0.rx.tapGesture()
                .bind { _ in
                    print("Button1 is Clicked")
                    self.dismiss(animated: false)
                }.disposed(by: disposeBag)
        }
        
        let button2 = UIButton().then {
            $0.backgroundColor = .white
            $0.setTitle("삭제", for: .normal)
            $0.setTitleColor(.darkText, for: .normal)
            $0.rx.tapGesture()
                .bind { _ in
                    print("Button2 is Clicked")
                    self.dismiss(animated: false)
                }.disposed(by: disposeBag)
        }
        
        let button3 = UIButton().then {
            $0.backgroundColor = .white
            $0.setTitle("신고", for: .normal)
            $0.setTitleColor(.darkText, for: .normal)
            $0.rx.tapGesture()
                .bind { _ in
                    print("Button3 is Clicked")
                    self.dismiss(animated: false)
                }.disposed(by: disposeBag)
        }
        
        let buttons = [button1, button2, button3]
        
        buttons.forEach {
            vStackView.addArrangedSubview($0)
        }
    }
    
    private func initiaLayout() {
        vStackView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.top.bottom.equalTo(vStackView)
            $0.width.equalTo(240)
        }
    }
}
