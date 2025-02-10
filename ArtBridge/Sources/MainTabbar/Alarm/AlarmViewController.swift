//
//  AlarmViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 6/16/24.
//

import UIKit
import RxSwift

final class AlarmViewController: BaseViewController {
    //MARK: - Properties
    private let viewModel: AlarmViewModel
    private var disposeBag = DisposeBag()
    private var dataSource: UITableViewDiffableDataSource<Int, String>!
    // 더미 데이터
    private var alarms: [String] = [
        "첫 번째 알람입니다.",
        "두 번째 알람입니다.",
        "세 번째 알람입니다.",
        "네 번째 알람입니다.",
        "다섯 번째 알람입니다."
    ]
    
    //MARK: - UI
    private let navBar = ArtBridgeNavBar().then {
        $0.leftButton.setImage(UIImage(named: "iconBack"), for: .normal)
        $0.rightButton.setImage(UIImage(named: "iconDelete"), for: .normal)
        $0.title.text = "알람"
    }
    
    private lazy var alarmTableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(AlarmCell.self, forCellReuseIdentifier: AlarmCell.id)
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 144 //기본 높이 설정 추가
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        return tableView
    }()
    
    //MARK: - Init
    init(viewModel: AlarmViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initialLayout()
        
        viewModelInput()
        
        configureDataSource()
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0]) // 섹션 추가
        snapshot.appendItems(alarms) // 데이터 추가
        dataSource.apply(snapshot, animatingDifferences: false) // 스냅샷을 적용
    }
    
    //MARK: - Methods
    private func viewModelInput() {
        navBar.leftButton.rx.tapGesture()
            .skip(1)
            .map { _ in }
            .bind(to: viewModel.inputs.backward)
            .disposed(by: disposeBag)
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Int, String>(tableView: alarmTableView) { (tableView, indexPath, comment) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: AlarmCell.id, for: indexPath) as! AlarmCell
            return cell
        }
    }
}
extension AlarmViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160 // 셀 전체 높이 조정
    }
}

//MARK: - Layout
extension AlarmViewController {
    private func setupViews() {
        view.addSubviews([
            navBar,
            alarmTableView
        ])
    }
    
    private func initialLayout() {

        navBar.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        alarmTableView.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom)
            $0.left.right.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview()
        }
    }
}
