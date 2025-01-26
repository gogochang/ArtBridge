//
//  NoticeViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 1/25/25.
//

import UIKit
import RxSwift

final class NoticeViewController: BaseViewController {
    //MARK: - Properties
    private let disposeBag = DisposeBag()
    private let viewModel: NoticeViewModel
    private var isAnimating: Bool = false
    private var previousOffsetY: CGFloat = 0
    
    //MARK: - UI
    private var navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setTitle("공고", for: .normal)
        $0.leftBtnItem.setTitleColor(.black, for: .normal)
        $0.leftBtnItem.titleLabel?.font = .jalnan20
        $0.rightBtnItem.setImage(UIImage(named: "iconsProfile"), for: .normal)
        $0.searchView.isHidden = false
    }
    
    private lazy var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.delegate = self
    }

    private let contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    private let bannerView = UIImageView().then {
        $0.kf.setImage(with: URL(string: "https://siqqojzclugpskrqnwyu.supabase.co/storage/v1/object/sign/testImage/banner_temp.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJ0ZXN0SW1hZ2UvYmFubmVyX3RlbXAucG5nIiwiaWF0IjoxNzM3ODE0NDg3LCJleHAiOjE3Mzg0MTkyODd9.G7pDsR14BcE9ZkjvesnTVO6yF75o4UxK0jQYjrLafZg&t=2025-01-25T14%3A14%3A48.225Z")!)
    }
    
    private let kindButton = SelectionButton(title: "전체", icon: UIImage(named: "downArrow"))
    private let regionButton = SelectionButton(title: "지역", icon: UIImage(named: "downArrow"))
    private let careerButton = SelectionButton(title: "경력", icon: UIImage(named: "downArrow"))
    private let horizontalScrollFilterButtonView = ButtonScrollView()
    
    private lazy var noticeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.estimatedItemSize = NoticeCell.size// 예상 크기를 지정
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 52) // 헤더 높이 지정
            
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(NoticeCell.self, forCellWithReuseIdentifier: NoticeCell.id)
        collectionView.register(
            NoticeHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: NoticeHeaderView.id
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    //MARK: - Init
    init(viewModel: NoticeViewModel) {
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
    }
    
    let test = UIView()
    //MARK: - Methods
    private func viewModelInput() {
    }
    
    private func viewModelOutput() {
        
    }
    
}

//MARK: - DelegateCollectionView
extension NoticeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoticeCell.id, for: indexPath) as! NoticeCell
        //        let notice = notices[indexPath.row]
        cell.configure(with: (
            imageURL: "https://picsum.photos/300/200?random=1",
            title: "공고 제목",
            organizationName: "무슨컴퍼니"
        ))  // 데이터 바인딩
        return cell
    }
    
    // 스크롤 이벤트 감지
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == noticeCollectionView {
            let currentContentOffsetY = scrollView.contentOffset.y
            // `bannerView`의 바닥 좌표를 계산
            let noticeCollectionViewTopOffset = noticeCollectionView.frame.minY
            // `noticeCollectionView`의 스크롤과 `self.scrollView`의 offset을 동시에 애니메이션
            if currentContentOffsetY > previousOffsetY + 10 {
                updateScrollViewOffset(to: noticeCollectionViewTopOffset)
            } else if currentContentOffsetY < previousOffsetY - 10 {
                updateScrollViewOffset(to: 0)
            }
            
            previousOffsetY = currentContentOffsetY
        }
    }
    
    // ScrollView의 Offset 애니메이션 처리
    private func updateScrollViewOffset(to yOffset: CGFloat) {
        guard !isAnimating else { return }

        // 동시에 애니메이션을 적용하여 스크롤 동작이 자연스럽게 처리되도록 함
        isAnimating = true

        UIView.animate(withDuration: 0.5, animations: {
            // self.scrollView의 스크롤 애니메이션을 처리
            self.scrollView.setContentOffset(CGPoint(x: 0, y: yOffset), animated: false)
        }, completion: { _ in
            // 애니메이션 완료 후 플래그 해제
            self.isAnimating = false
        })
    }
    
    func collectionView( _ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: NoticeHeaderView.id,
                for: indexPath
            ) as! NoticeHeaderView
            
            // 헤더 구성
            header.configure(with: 10)
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.inputs.showDetailPost.onNext(indexPath.row)
    }

}

//MARK: - Layout
extension NoticeViewController {
    private func setupViews() {
        horizontalScrollFilterButtonView.addArrangedSubviews(buttons: [kindButton, regionButton, careerButton])
        
        // Add subviews to stackView
        contentStackView.addArrangedSubview(bannerView)
        contentStackView.addArrangedSubview(horizontalScrollFilterButtonView)
        contentStackView.addArrangedSubview(noticeCollectionView)
        
        // Add stackView to scrollView
        
        scrollView.addSubview(contentStackView)
        
        // Add scrollView to main view
        view.addSubviews([scrollView, navBar])
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
            $0.height.equalTo(200) // Set banner height
        }
        
        horizontalScrollFilterButtonView.snp.makeConstraints {
            $0.height.equalTo(52) // Set filter buttons' height
        }
        
        noticeCollectionView.snp.makeConstraints {
            $0.height.equalTo(800) // Provide a fixed height or calculate dynamically
        }
    }


}
