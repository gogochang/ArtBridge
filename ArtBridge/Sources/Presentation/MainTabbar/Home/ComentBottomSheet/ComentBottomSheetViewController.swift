//
//  ComentBottomSheetViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 2/9/25.
//

import UIKit
import RxSwift
import BlurUIKit

final class ComentBottomSheetViewController: BaseViewController {
    // MARK: Properties
    private let viewModel: ComentBottomSheetViewModel
    private var disposeBag = DisposeBag()
    private var dataSource: UITableViewDiffableDataSource<Int, String>!
    // 더미 데이터
    private var comments: [String] = [
        "첫 번째 댓글입니다.",
        "두 번째 댓글입니다.",
        "세 번째 댓글입니다.",
        "네 번째 댓글입니다.",
        "다섯 번째 댓글입니다."
    ]
    
    // MARK: - UI
    private let bottomSheetBackground = VariableBlurView().then {
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
        $0.dimmingTintColor = .black
    }
    
    private let navBar = ArtBridgeNavBar().then {
        $0.leftButton.setImage(UIImage(named: "iconBack"), for: .normal)
        $0.rightButton.isHidden = true
        $0.title.text = "감상평 26"
    }
    
    private lazy var comentTableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ComentCell.self, forCellReuseIdentifier: ComentCell.id)
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100 // 기본 높이 설정 추가
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private let commentInputView = ComentInputView()
    
    // MARK: - Init
    init(viewModel: ComentBottomSheetViewModel) {
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
        
        configureDataSource()
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0]) // 섹션 추가
        snapshot.appendItems(comments) // 데이터 추가
        dataSource.apply(snapshot, animatingDifferences: false) // 스냅샷을 적용
    }
    
    // MARK: - Methods
    private func viewModelInput() {
        navBar.leftButton.rx.tapGesture()
            .map { _ in }
            .bind(to: viewModel.routes.backward)
            .disposed(by: disposeBag)
    }
    
    private func viewModelOutput() {
        
    }
    
    // DataSource 설정
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Int, String>(tableView: comentTableView) { (tableView, indexPath, _) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: ComentCell.id, for: indexPath) as? ComentCell
            return cell
        }
    }
}

// MARK: - Layout
extension ComentBottomSheetViewController {
    private func setupViews() {
        backgroundView.image = nil
        view.addSubviews([
            bottomSheetBackground,
            navBar,
            comentTableView,
            commentInputView
        ])
    }
    
    private func initialLayout() {
        bottomSheetBackground.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(view.frame.height * 2) // FIXME: 근본적인 해결방법이 아닙니다.
        }
        
        navBar.snp.makeConstraints {
            $0.top.equalTo(bottomSheetBackground).inset(24)
            $0.left.right.equalTo(bottomSheetBackground)
        }
        
        comentTableView.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(24)
        }
        
        commentInputView.snp.makeConstraints( {
            $0.top.equalTo(comentTableView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(34)
            $0.height.equalTo(72)
        })
    }
}
