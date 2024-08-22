//
//  HomeViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 4/25/24.
//

import UIKit
import RxSwift

fileprivate enum Section: Hashable {
    case banner
    case quickHorizontal
    case PopularPost(String)
    case PopularTutor(String)
    case news(String)
}

fileprivate enum Item: Hashable {
    case normal(BannerModel)
    case quickBtn(UIImage?, String)
    case previewItem(ContentDataModel) //TODO: 인기글 데이터 Model로 변경
}

struct BannerModel: Hashable { // TODO: 모델로 이동
    var id = UUID()
    var imageUrl: String
}

final class HomeViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    private var autoScrollTimer: Timer?
    private var currentAutoScrollIndex = 1
    private var isAutoScrollEnabled = false
    private var timeInterval = 2.0
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = UIColor(white: 0.97, alpha: 1.0)
        
        $0.register(
            BannerCollectionViewCell.self,
            forCellWithReuseIdentifier: BannerCollectionViewCell.id
        )
        
        $0.register(
            QuickBtnCollectionViewCell.self,
            forCellWithReuseIdentifier: QuickBtnCollectionViewCell.id
        )
        
        $0.register(
            PreviewCollectionViewCell.self,
            forCellWithReuseIdentifier: PreviewCollectionViewCell.id
        )
        
        $0.register(
            HeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderView.id
        )
    }
    
    private lazy var pageController = UIPageControl().then {
        $0.frame = CGRect(x: 0,
                          y: self.collectionView.frame.height + 160,
                          width: self.collectionView.frame.size.width,
                          height: 40.0)
        $0.numberOfPages = 4
        $0.currentPageIndicatorTintColor = .white
        $0.pageIndicatorTintColor = .darkGray
        $0.addTarget(self, action: #selector(changePage(_:)), for: .valueChanged)
    }
    
    @objc private func changePage(_ sender: UIPageControl) {
        collectionView.scrollToItem(at: IndexPath(item: sender.currentPage, section: 0), at: .left, animated: true)
    }
    
    private var navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setImage(UIImage(systemName: "apple.logo"), for: .normal)
        $0.rightBtnItem.setImage(UIImage(systemName: "bell"), for: .normal)
        $0.searchView.isHidden = false
    }
    
    private let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initialLayout()
        
        setDatasource()
        createSnapshot()
        
        viewModelInputs()
        viewModelOutput()
        
        collectionView.delegate = self
    }
    
    private func viewModelInputs() {
        navBar.rightBtnItem.rx.tap
            .bind(to: viewModel.inputs.showAlarm)
            .disposed(by: disposeBag)
    }
    
    private func viewModelOutput() {
        viewModel.outputs.homeData
            .bind(onNext: { [weak self] homeData in
                self?.updateHomeData(with: homeData)
            }).disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //FIXME: 리팩토링 후 활성화
//        collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .left, animated: false)
    }
    
    //TODO: 여러 섹션을 업데이트 가능하도록 재사용을 고려한 메서드로 수정
    private func updateHomeData(with homeData: HomeDataModel) {
        guard var currentSnapshot = self.dataSource?.snapshot() else { return }
        
        let bannerSection = Section.banner
        let bannerItems = homeData.bannerUrls.map { BannerModel(imageUrl: $0.URL) }
        
        // 현재 스냅샷의 복사본을 만들어서 작업
        currentSnapshot.deleteItems(currentSnapshot.itemIdentifiers(inSection: bannerSection))
        currentSnapshot.appendItems(bannerItems.map { Item.normal($0) }, toSection: bannerSection)
        
        let popularPostSection = Section.PopularPost("지금 인기있는 글")
        let popularPostItems = homeData.popularPosts.compactMap { postData in
            return Item.previewItem(postData)
        }
        
        // 현재 스냅샷의 복사본을 만들어서 작업
        currentSnapshot.deleteItems(currentSnapshot.itemIdentifiers(inSection: popularPostSection))
        currentSnapshot.appendItems(popularPostItems, toSection: popularPostSection)

        let popularTutorSection = Section.PopularTutor("지금 인기있는 강사")
        let popularTutorItems = homeData.popularTutors.compactMap { tutorData in
            return Item.previewItem(tutorData)
        }
        
        // 현재 스냅샷의 복사본을 만들어서 작업
        currentSnapshot.deleteItems(currentSnapshot.itemIdentifiers(inSection: popularTutorSection))
        currentSnapshot.appendItems(popularTutorItems, toSection: popularTutorSection)
        
        let newsSection = Section.news("뉴스")
        let newsItems = homeData.news.compactMap { newsData in
            return Item.previewItem(newsData)
        }
        
        currentSnapshot.deleteItems(currentSnapshot.itemIdentifiers(inSection: newsSection))
        currentSnapshot.appendItems(newsItems, toSection: newsSection)
        
        // 메인 스레드에서 스냅샷을 적용
        DispatchQueue.main.async {
            self.dataSource?.apply(currentSnapshot)
        }
    }
    
    private func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Item>()
        let bannerSection = Section.banner
        let bannerItems = [Item.normal(BannerModel(imageUrl: ""))]
        snapshot.appendSections([bannerSection])
        snapshot.appendItems(bannerItems, toSection: bannerSection)
        
        let horizontalSection = Section.quickHorizontal
        let quickItems = [Item.quickBtn(UIImage(named: "piano.png"), "피아노"),
                          Item.quickBtn(UIImage(named: "violin.png"), "바이올린"),
                          Item.quickBtn(UIImage(named: "flute.png"),"플루트"),
                          Item.quickBtn(UIImage(named: "horn.png"), "호른"),
                          Item.quickBtn(UIImage(named: "harp.png"), "하프"),
                          Item.quickBtn(UIImage(named: "more.png"), "더보기"),
                          Item.quickBtn(UIImage(named: "more.png"), "테스트1"),
                          Item.quickBtn(UIImage(named: "more.png"), "테스트2"),
                          Item.quickBtn(UIImage(named: "more.png"), "테스트3"),
                          Item.quickBtn(UIImage(named: "more.png"), "테스트4"),
                          Item.quickBtn(UIImage(named: "more.png"), "테스트5"),
        ]
        snapshot.appendSections([horizontalSection])
        snapshot.appendItems(quickItems, toSection: horizontalSection)
        
        let popularPostSection = Section.PopularPost("지금 인기있는 글")
        snapshot.appendSections([popularPostSection])
        
        let popularTutorSection = Section.PopularTutor("지금 인기있는 강사")
        snapshot.appendSections([popularTutorSection])
        
        let newsSection = Section.news("뉴스")
        snapshot.appendSections([newsSection])
        
        dataSource?.apply(snapshot)
    }
}

//MARK: - Layout
extension HomeViewController {
    private func setupViews() {
        view.addSubviews([
            navBar,
            collectionView,
        ])
        
        collectionView.addSubviews([pageController])
    }
    
    private func initialLayout() {
        view.backgroundColor = .systemGray6
        
        navBar.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
}
//MARK: - CompositionalLayout
extension HomeViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            let section = self?.dataSource?.sectionIdentifier(for: sectionIndex)
            
            switch section {
            case .banner:
                return self?.createBannerSection()
            case .quickHorizontal:
                return self?.createQuickBtnSection()
            case .PopularPost:
                return self?.createPopularHorizontalSection()
            case .PopularTutor:
                return self?.createPopularHorizontalSection()
            case .news:
                return self?.createNewsHorizontalSection()
            default:
                return self?.createBannerSection()
            }
            
        },configuration: config)
    }
    
    private func createBannerSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)  // 아이템 간 간격 조정
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(200)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        //FIXME: 리팩토링 후 활성화
//        let pageWidth = collectionView.bounds.width
//        section.visibleItemsInvalidationHandler = { [weak self] (visibleItems, offset, env) in
//            guard let self = self else { return }
//            if let page = Int(exactly: (offset.x + pageWidth) / pageWidth) {
//                self.currentAutoScrollIndex = page
//                
//                if page == 6 {
//                    collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .left, animated: false)
//                } else if page == 1 {
//                    collectionView.scrollToItem(at: IndexPath(row: 4, section: 0), at: .left, animated: false)
//                } else {
//                    self.pageController.currentPage = page - 2
//                }
//            }
//            
//            if self.isAutoScrollEnabled {
//                self.configAutoScroll()
//            }
//        }
        
        return section
    }
    
    private func createQuickBtnSection() -> NSCollectionLayoutSection {
        //Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.5)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)  // 아이템 간 간격 조정
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.25),
            heightDimension: .absolute(160)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        return section
    }
    
    private func createPopularHorizontalSection() -> NSCollectionLayoutSection {
        //Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)  // 아이템 간 간격 조정
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(200),
            heightDimension: .absolute(200)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(44)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func createNewsHorizontalSection() -> NSCollectionLayoutSection {
        //Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)  // 아이템 간 간격 조정
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(280),
            heightDimension: .absolute(280)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(44)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
        section.boundarySupplementaryItems = [header]
        return section
    }
}

//MARK: - Datasource
extension HomeViewController {
    private func setDatasource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                
                switch item {
                case .normal(let bannerModel):
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: BannerCollectionViewCell.id,
                        for: indexPath
                    ) as? BannerCollectionViewCell
                    
                    cell?.configure(bannerModel: bannerModel)
                    
                    return cell
                    
                case .quickBtn(let image, let title):
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: QuickBtnCollectionViewCell.id,
                        for: indexPath
                    ) as? QuickBtnCollectionViewCell
                    
                    cell?.configure(
                        icon: image,
                        title: title
                    )
                    return cell
                case .previewItem(let contentData):
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: PreviewCollectionViewCell.id,
                        for: indexPath
                    ) as? PreviewCollectionViewCell
                    
                    cell?.configure(
                        coverImgUrl: contentData.coverURL,
                        title: contentData.title,
                        subTitle: contentData.nickname
                    )
                    
                    return cell
                }
            })
        
        dataSource?.supplementaryViewProvider = {[weak self] collectionView, kind, indexPath -> UICollectionReusableView in
            guard let self = self else { return UICollectionReusableView() }
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.id,
                for: indexPath
            )
            let section = self.dataSource?.sectionIdentifier(for: indexPath.section)
            
            switch section {
            case .PopularPost(let title):
                (header as? HeaderView)?.configure(type: .post, title: title)
            case .PopularTutor(let title):
                (header as? HeaderView)?.configure(type: .tutors, title: title)
            case .news(let title):
                (header as? HeaderView)?.configure(type: .news, title: title)
            default:
                print("Default")
            }
            
            (header as? HeaderView)?.titleView.rx.tapGesture()
                .skip(1)
                .map { _ in (header as? HeaderView)?.type ?? .none }
                .bind(to: self.viewModel.inputs.showPopularPostList)
                .disposed(by: (header as? HeaderView)?.disposeBag ?? DisposeBag())
            
            return header
        }
    }
}

//MARK: - Auto Scroll Methods
extension HomeViewController {
    private func configAutoScroll() {
        resetAutoScrollTime()
        setupAutoScrollTimer()
    }
    
    private func resetAutoScrollTime() {
        if autoScrollTimer != nil {
            autoScrollTimer?.invalidate()
            autoScrollTimer = nil
        }
    }
    
    private func setupAutoScrollTimer() {
        autoScrollTimer = Timer.scheduledTimer(
            timeInterval: self.timeInterval,
            target: self,
            selector: #selector(autoScrollAction(timer:)),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc private func autoScrollAction(timer: Timer) {
        collectionView.scrollToItem(
            at: IndexPath(
                item: self.currentAutoScrollIndex,
                section: 0
            ),
            at: .left,
            animated: true
        )
    }
}

//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let section = dataSource?.sectionIdentifier(for: indexPath.section)
        switch section {
        case .banner:
            print("A")
        case .quickHorizontal:
            self.viewModel.inputs.showDetailInstrument.onNext(())
        case .PopularPost:
            self.viewModel.inputs.showDetailPost.onNext(indexPath.item)
        case .PopularTutor:
            self.viewModel.inputs.showDetailTutor.onNext(indexPath.item)
        case .news:
            self.viewModel.inputs.showDetailNews.onNext(indexPath.item)
        case .none:
            print("none")
        }
    }
}
