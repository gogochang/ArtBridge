//
//  MainTabViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 4/20/24.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import FirebaseAnalytics
import BlurUIKit

final class MainTabViewController: UIViewController {
    //MARK: - Properties
    private var disposeBag = DisposeBag()
    private let viewModel: MainTabViewModel
    private var isInitialized = false
    
    override func viewDidLoad() {
        setupViews()
        initLayout()
        
        bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        /// [#00] 다른 페이지에서 이전 페이지로 이동 시 무조건 홈 화면으로 변경되는 문제 수정
        /// - viewDidload()에서 설정하면 safeArea가 없는상태(레이아웃이 만들어지기 전)이기 때문에 레이아웃 위치가 잘못 됨
        /// - 현재 viewDidAppear가 호출되는 시점을 설정하고, 최초 1회만 실행하도록 플래그 설정하여 문제 해결
        if !isInitialized {
            // 첫 화면을 홈화면으로 설정
            showSelectedVC(at: 0)
            tabSelected(at: 0)
            isInitialized = true
        }
    }
    
    init(viewModel: MainTabViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        let className = String(describing: type(of: self))
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
          AnalyticsParameterItemID: "id-\(className)",
          AnalyticsParameterItemName: className,
          AnalyticsParameterContentType: "cont",
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Binding
    private func bind() {
        let input = MainTabViewModelInput(
            homeSelected: homeButton.rx.tapGesture().asObservable(),
            adevertiseSelected: homeButton.rx.tapGesture().asObservable(),
            postSelected: homeButton.rx.tapGesture().asObservable(),
            myPageSelected: homeButton.rx.tapGesture().asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        output.selectScene
            .subscribe(onNext: { [weak self] index in
                // FIXME: 나머지 화면 구현이 완료되면 수정필요합니다.
                if index != 0 { return }
                self?.tabSelected(at: index)
                self?.showSelectedVC(at: index)
                
            }).disposed(by: disposeBag)
    }
    
    private func showSelectedVC(at index: Int) {
        for (idx, viewController) in viewControllers.enumerated() {
            viewController.view.isHidden = !(idx == index)
        }
        
        if !mainContentView.subviews.contains(where: {$0 == viewControllers[index].view }) {
            mainContentView.addSubview(viewControllers[index].view)
            viewControllers[index].view.snp.makeConstraints { make in
                make.top.equalTo(mainContentView.snp.top)
                make.leading.equalTo(mainContentView.snp.leading)
                make.trailing.equalTo(mainContentView.snp.trailing)
                make.bottom.equalTo(mainContentView.snp.bottom)
            }
        }
    }
    
    private func tabSelected(at index: Int) {
        guard index < 4 else { return }
        
        let buttons = [homeButton, advertiseButton, postButton, myButton]

        // 모든 버튼 초기화
        buttons.forEach { button in
            button.isSelected = false
            button.snp.updateConstraints {
                $0.width.equalTo(64)
            }
        }

        // 선택된 버튼 업데이트
        let selectedButton = buttons[index]
        selectedButton.isSelected = true

        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            selectedButton.snp.updateConstraints {
                $0.width.equalTo(86)
            }
            selectedButton.superview?.layoutIfNeeded()
        }
    }
    
    var viewControllers: [UIViewController] = []
    
    //MARK: - UI
    private let mainContentView = UIView().then { view in
        view.backgroundColor = .red
    }
    
    private let bottomBlurView = VariableBlurView().then {
        $0.dimmingTintColor = .black
        $0.dimmingOvershoot = .relative(fraction: 1)
    }
    
    private let bottomView = UIView().then {
        $0.layer.cornerRadius = 40
        $0.clipsToBounds = true
    }
    
    private let homeButton = ArtBridgeButton().then {
        $0.setCornerRadius(32)
        $0.setTitle("홈")
        $0.setImage(UIImage(named: "home"), for: .normal)
        $0.setImage(UIImage(named: "home_fill"), for: .selected)
    }
    
    private let advertiseButton = ArtBridgeButton().then {
        $0.setCornerRadius(32)
        $0.setTitle("공고")
        $0.setImage(UIImage(named: "advertise"), for: .normal)
        $0.setImage(UIImage(named: "advertise_fill"), for: .selected)
    }
    
    private let postButton = ArtBridgeButton().then {
        $0.setCornerRadius(32)
        $0.setTitle("게시판")
        $0.setImage(UIImage(named: "post"), for: .normal)
        $0.setImage(UIImage(named: "post_fill"), for: .selected)
    }
    
    private let myButton = ArtBridgeButton().then {
        $0.setCornerRadius(32)
        $0.setTitle("내정보")
        $0.setImage(UIImage(named: "my"), for: .normal)
        $0.setImage(UIImage(named: "my_fill"), for: .selected)
    }
    
    private lazy var bottomContentHStack = UIStackView.make(
        with: [homeButton,advertiseButton, postButton, myButton],
        axis: .horizontal,
        alignment: .center,
        distribution: .equalSpacing,
        spacing: 0
    )
    
    private let innerShadowView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.shadowColor = UIColor.white.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowRadius = 2
        $0.layer.shadowOpacity = 0.2
        
        $0.layer.borderWidth = 10
        $0.layer.cornerRadius = 50
    }
}

//MARK: - Layout
extension MainTabViewController {
    private func setupViews() {
        view.addSubviews([
            mainContentView,
            bottomView,
            bottomBlurView
        ])
        
        bottomView.addSubviews([
            bottomBlurView,
            innerShadowView,
            bottomContentHStack,
        ])
    }
    
    private func initLayout() {
        mainContentView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(80)
        }
        
        bottomBlurView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
        
        bottomContentHStack.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview().inset(8)
        }
        
        homeButton.snp.makeConstraints {
            $0.size.equalTo(64)
        }
        
        advertiseButton.snp.makeConstraints {
            $0.size.equalTo(64)
        }
        
        postButton.snp.makeConstraints {
            $0.size.equalTo(64)
        }
        
        myButton.snp.makeConstraints {
            $0.size.equalTo(64)
        }
        
        innerShadowView.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(-10)
            $0.bottom.right.equalToSuperview().offset(10)
        }
    }
}
