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
    case previewItem(String, String, String?) //TODO: 인기글 데이터 Model로 변경
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
    private var isAutoScrollEnabled = true
    private var timeInterval = 2.0
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
        $0.showsVerticalScrollIndicator = false
        
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
        
        collectionView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .left, animated: false)
    }
    
    private func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Item>()
        let bannerSection = Section.banner
        let bannerImagesUrls: [String] = ["https://source.unsplash.com/random/400x400?1",
                                          "https://source.unsplash.com/random/400x400?2",
                                          "https://source.unsplash.com/random/400x400?3",
                                          "https://source.unsplash.com/random/400x400?4"]
        let bannerItems = [ //TODO: 실제 데이터에서 가공하여 사용할 수 있도록 수정
            Item.normal(BannerModel(imageUrl: bannerImagesUrls[3])),
            Item.normal(BannerModel(imageUrl: bannerImagesUrls[0])),
            Item.normal(BannerModel(imageUrl: bannerImagesUrls[1])),
            Item.normal(BannerModel(imageUrl: bannerImagesUrls[2])),
            Item.normal(BannerModel(imageUrl: bannerImagesUrls[3])),
            Item.normal(BannerModel(imageUrl: bannerImagesUrls[0])),
        ]
        snapshot.appendSections([bannerSection])
        snapshot.appendItems(bannerItems, toSection: bannerSection)
        
        let horizontalSection = Section.quickHorizontal
        let quickItems = [Item.quickBtn(UIImage(named: "piano.png"), "피아노"),
                          Item.quickBtn(UIImage(named: "violin.png"), "바이올린"),
                          Item.quickBtn(UIImage(named: "flute.png"),"플루트"),
                          Item.quickBtn(UIImage(named: "horn.png"), "호른"),
                          Item.quickBtn(UIImage(named: "harp.png"), "하프"),
                          Item.quickBtn(UIImage(named: "more.png"), "더보기"),]
        snapshot.appendSections([horizontalSection])
        snapshot.appendItems(quickItems, toSection: horizontalSection)
        
        let popularPostSection = Section.PopularPost("지금 인기있는 글")
        let popularPostItems = [
            Item.previewItem("제 연주 피드백 부탁드립니다.", "강호동", "https://source.unsplash.com/random/400x400?5"),
            Item.previewItem("바이올린 연습은 이렇게!", "이효리", "https://source.unsplash.com/random/400x400?6"),
            Item.previewItem("어깨가 아파요","유재석","https://source.unsplash.com/random/400x400?7"),
            Item.previewItem("악보 종이 vs 아이패드","홍길동", "https://source.unsplash.com/random/400x400?8"),
            Item.previewItem("하루에 보통 몇시간 연습하시나요?","이수근", "https://source.unsplash.com/random/400x400?9")
        ]
        
        snapshot.appendSections([popularPostSection])
        snapshot.appendItems(popularPostItems, toSection: popularPostSection)
        
        let popularTutorSection = Section.PopularTutor("지금 인기있는 강사")
        let popularTutorItems = [
            Item.previewItem("송지효","바이올린","https://i.pravatar.cc/300?img=1"),
            Item.previewItem("박명수","드럼","https://i.pravatar.cc/300?img=2"),
            Item.previewItem("우원재","첼로","https://i.pravatar.cc/300?img=3​"),
            Item.previewItem("차은우","플루트","https://i.pravatar.cc/300?img=4​")
        ]
        snapshot.appendSections([popularTutorSection])
        snapshot.appendItems(popularTutorItems, toSection: popularTutorSection)
        
        let newsSection = Section.news("뉴스")
        let newsItems = [
            Item.previewItem("오늘 밤은 고고오케스트라로 채워집니다!🎉","","https://source.unsplash.com/random/400x400?10"),
            Item.previewItem("꿈을 키우는 고고오케스트라가 있다고??😃","","https://source.unsplash.com/random/400x400?11"),
            Item.previewItem("고고 오케스트라 나눔 연주회","","https://source.unsplash.com/random/400x400?12")
        ]
        snapshot.appendSections([newsSection])
        snapshot.appendItems(newsItems, toSection: newsSection)
        
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
        view.backgroundColor = .white
        
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
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(200)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        let pageWidth = collectionView.bounds.width
        section.visibleItemsInvalidationHandler = { [weak self] (visibleItems, offset, env) in
            guard let self = self else { return }
            if let page = Int(exactly: (offset.x + pageWidth) / pageWidth) {
                self.currentAutoScrollIndex = page
                
                if page == 6 {
                    collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .left, animated: false)
                } else if page == 1 {
                    collectionView.scrollToItem(at: IndexPath(row: 4, section: 0), at: .left, animated: false)
                } else {
                    self.pageController.currentPage = page - 2
                }
            }
            
            if self.isAutoScrollEnabled {
                self.configAutoScroll()
            }
        }
        
        return section
    }
    
    private func createQuickBtnSection() -> NSCollectionLayoutSection {
        //Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.25),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)  // 아이템 간 간격 조정

        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(80)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        return section
    }
    
    private func createPopularHorizontalSection() -> NSCollectionLayoutSection {
        //Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)  // 아이템 간 간격 조정
        
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
                case .previewItem(let title, let nickname, let coverImgUrl):
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: PreviewCollectionViewCell.id,
                        for: indexPath
                    ) as? PreviewCollectionViewCell
                    
                    cell?.configure(
                        coverImgUrl: coverImgUrl,
                        title: title,
                        subTitle: nickname
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
                (header as? HeaderView)?.configure(title: title)
            case .PopularTutor(let title):
                (header as? HeaderView)?.configure(title: title)
            case .news(let title):
                (header as? HeaderView)?.configure(title: title)
            default:
                print("Default")
            }
            
            (header as? HeaderView)?.moreButton.rx.tap
                .throttle(.seconds(3),latest: true, scheduler: MainScheduler.instance)
                .bind(to: self.viewModel.inputs.showPopularPostList)
                .disposed(by: self.disposeBag)
            
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
            print("클릭된 악기 검색페이지로 이동")
        case .PopularPost:
            self.viewModel.inputs.showDetailPost.onNext(())
        case .PopularTutor:
            self.viewModel.inputs.showDetailTutor.onNext(())
        case .news:
            print("News상세보기 페이지로 이동")
        case .none:
            print("none")
        }
    }
}
