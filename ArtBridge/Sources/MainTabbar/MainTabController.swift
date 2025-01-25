//
//  MainTabController.swift
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

final class MainTabController: UIViewController {
    //MARK: - Properties
    private var isInitialized = false
    
    override func viewDidLoad() {
        setupViews()
        initLayout()
        
        viewModelInput()
        viewModelOutput()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        /// [#00] 다른 페이지에서 이전 페이지로 이동 시 무조건 홈 화면으로 변경되는 문제 수정
        /// - viewDidload()에서 설정하면 safeArea가 없는상태(레이아웃이 만들어지기 전)이기 때문에 레이아웃 위치가 잘못 됨
        /// - 현재 viewDidAppear가 호출되는 시점을 설정하고, 최초 1회만 실행하도록 플래그 설정하여 문제 해결
        if !isInitialized {
            // 첫 화면을 홈화면으로 설정
            showSelectedVC(at: 0)
            self.viewModel.inputs.homeSelected.onNext(())
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
    
    //MARK: - Properties
    private var disposeBag = DisposeBag()
    private let viewModel: MainTabViewModel
    
    private func viewModelInput() {
        homeBtn.rx.tap
            .bind(to: viewModel.inputs.homeSelected)
            .disposed(by: disposeBag)
        
        noticeBtn.rx.tap
            .bind(to: viewModel.inputs.noticeSelected)
            .disposed(by: disposeBag)
        
        communityBtn.rx.tap
            .bind(to: viewModel.inputs.communitySelected)
            .disposed(by: disposeBag)
        
        myPageBtn.rx.tap
            .bind(to: viewModel.inputs.myPageSelected)
            .disposed(by: disposeBag)
    }
    
    private func viewModelOutput() {
        viewModel.outputs.selectScene
            .subscribe(onNext: { [weak self] index in
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

        homeBtn.isSelected = false
        noticeBtn.isSelected = false
        communityBtn.isSelected = false
        myPageBtn.isSelected = false

        switch index {
        case 0:
            homeBtn.isSelected = true
        case 1:
            noticeBtn.isSelected = true
        case 2:
            communityBtn.isSelected = true
        case 3:
            myPageBtn.isSelected = true
        default:
            break
        }
    }

    
    var viewControllers: [UIViewController] = []
    
    //MARK: - UI
    private let mainContentView = UIView().then { view in
        view.backgroundColor = .clear
    }
    
    private let bottomView = UIView().then { view in
        view.backgroundColor = .white
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    
    private let homeBtn = UIButton().then { button in
        button.setImage(UIImage(systemName: "house"), for: .normal)
        button.setImage(UIImage(systemName: "house.fill"), for: .selected)
        button.setTitle("홈", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = .nanumB12
        button.tintColor = .darkGray
        button.alignTextBelow()
        button.snp.makeConstraints { make in
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
    }
    
    private let communityBtn = UIButton().then { button in
        button.setImage(UIImage(systemName: "list.bullet.rectangle"), for: .normal)
        button.setImage(UIImage(systemName: "list.bullet.rectangle.fill"), for: .selected)
        button.setTitle("게시판", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = .nanumB12
        button.tintColor = .darkGray
        button.alignTextBelow()
        button.snp.makeConstraints { make in
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
    }
    
    private let noticeBtn = UIButton().then { button in
        button.setImage(UIImage(systemName: "clipboard"), for: .normal)
        button.setImage(UIImage(systemName: "clipboard.fill"), for: .selected)
        button.setTitle("공고", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = .nanumB12
        button.tintColor = .darkGray
        button.alignTextBelow()
        button.snp.makeConstraints { make in
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
    }
    
    private let myPageBtn = UIButton().then { button in
        button.setImage(UIImage(systemName: "person"), for: .normal)
        button.setImage(UIImage(systemName: "person.fill"), for: .selected)
        button.setTitle("내 정보", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = .nanumB12
        button.tintColor = .darkGray
        button.alignTextBelow()
        button.snp.makeConstraints { make in
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
    }
    
    private lazy var bottomContentHStack = UIStackView.make(
        with: [homeBtn, noticeBtn, communityBtn, myPageBtn],
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
        
        bottomView.addSubviews([
            lineView,
            bottomContentHStack
        ])
    }
    
    private func initLayout() {
        view.backgroundColor = .white
        
        mainContentView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top)
            $0.left.right.equalTo(view)
        }
        
        bottomView.snp.makeConstraints {
            $0.top.equalTo(mainContentView.snp.bottom)
            $0.left.right.equalTo(mainContentView)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(49)//FIXME: 임시로 처리
        }
        
        lineView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        bottomContentHStack.snp.makeConstraints { make in
            make.top.equalTo(bottomView.snp.top).offset(14)
            make.leading.equalTo(bottomView.snp.leading).offset(36)
            make.trailing.equalTo(bottomView.snp.trailing).offset(-36)
        }
    }
}
