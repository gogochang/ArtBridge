//
//  DetailNoticeViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 1/26/25.
//

import UIKit
import RxSwift

final class DetailNoticeViewController: BaseViewController {
    //MARK: - Properties
    private let viewModel: DetailNoticeViewModel
    private let disposeBag: DisposeBag = DisposeBag()
    
    //MARK: - UI
    private let navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.rightBtnItem.setImage(UIImage(systemName: "ellipsis"), for: .normal)
    }
    
    private lazy var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    private let contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    private let bannerView = UIImageView().then {
        $0.backgroundColor = .systemGray
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.kf.setImage(with: URL(string: "https://siqqojzclugpskrqnwyu.supabase.co/storage/v1/object/sign/testImage/testbanner.jpg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJ0ZXN0SW1hZ2UvdGVzdGJhbm5lci5qcGciLCJpYXQiOjE3Mzc4NzE2MjksImV4cCI6MTc2OTQwNzYyOX0.MV9a75K92SY1gBuGR8qXieOH3Wj5N2qec4prRcvqZpQ&t=2025-01-26T06%3A07%3A09.853Z"))
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .nanumB17
        $0.textColor = .darkText
        $0.lineBreakMode = .byCharWrapping
        $0.numberOfLines = 3
        $0.text = "2025 제1회 AIdol Genesis Challenge: 글로벌 K-pop 아이돌 AI 콘텐츠 기획 아이디어-프로듀싱 공모전"
    }
    
    private let dividerView = UIView().then {
        $0.backgroundColor = .systemGray4
    }
    
    private lazy var detailListTableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(DetailListCell.self, forCellReuseIdentifier: DetailListCell.id)
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 400
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private let testView = UIView().then {
        $0.backgroundColor = .orange
    }
    
    private let testContentView = UIView().then {
        $0.backgroundColor = .blue
    }
    
    private let bottomButtonView = ButtonBottomView()
    
    //MARK: - Init
    init(viewModel: DetailNoticeViewModel) {
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
        
        detailListTableView.delegate = self
        detailListTableView.dataSource = self
        detailListTableView.reloadData()
    }
    
    //MARK: - Methods
    private func viewModelInput() {
        navBar.leftBtnItem.rx.tap
            .bind(to: viewModel.inputs.backward)
            .disposed(by: disposeBag)
        
        bottomButtonView.bookmarkButton.rx.tap
            .bind {
                print("북마크 버튼 클릭됨")
            }.disposed(by: disposeBag)
        
        bottomButtonView.goButton.rx.tap
            .bind {
                print("바로가기 버튼 클릭됨")
            }.disposed(by: disposeBag)
    }
    
    private func viewModelOutput() {
        
    }
}
extension DetailNoticeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.detailTitles.count // 실제 데이터 개수
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailListCell.id, for: indexPath) as! DetailListCell
        cell.configure(
            title: viewModel.detailTitles[indexPath.row],
            content: viewModel.testDetailContent[indexPath.row]
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DetailListCell.height
    }
}

//MARK: - Layout
extension DetailNoticeViewController {
    private func setupViews() {
        view.addSubviews([scrollView, navBar, bottomButtonView])
        scrollView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(bannerView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(dividerView)
        contentStackView.addArrangedSubview(detailListTableView)
        contentStackView.addArrangedSubview(testView)
        contentStackView.addArrangedSubview(testContentView)
    }
    
    private func initialLayout() {
        navBar.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom) // Place scrollView below the navbar
            $0.left.right.bottom.equalToSuperview() // Fill the rest of the screen
        }
        
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview() // Match scrollView's edges
            $0.width.equalToSuperview() // Match the width for vertical scrolling
        }
        
        bannerView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(250) // Set banner height
        }
        
        titleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20)
        }
        
        dividerView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
        
        // Add constraints to the table view
        detailListTableView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20)
            $0.height.greaterThanOrEqualTo(100)
        }
        
        testView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        testContentView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(1000)
        }
        
        bottomButtonView.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
        }
    }
}

