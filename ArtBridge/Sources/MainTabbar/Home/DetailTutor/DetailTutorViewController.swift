//
//  DetailTutorViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 5/17/24.
//

import UIKit
import RxSwift

fileprivate enum Section: Hashable {
    case banner
    case title
    case profile
    case detailInfo
    case description
}

fileprivate enum Item: Hashable {
    case bannerItem(String) // ImageURL
    case profile(DetailTutorDataModel)
    case detailInfo
    case descItem
}

final class DetailTutorViewController: UIViewController {
    //MARK: - Properties
    private let viewModel: DetailTutorViewModel
    private let disposeBag: DisposeBag = DisposeBag()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    //MARK: - UI
    private let navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.rightBtnItem.setImage(UIImage(systemName: "bell"), for: .normal)
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
        $0.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.id)
        $0.register(TutorProfileCollectionViewCell.self, forCellWithReuseIdentifier: TutorProfileCollectionViewCell.id)
        $0.register(TutorInfoCollectionViewCell.self, forCellWithReuseIdentifier: TutorInfoCollectionViewCell.id)
        $0.register(TutorDescCollectionViewCell.self, forCellWithReuseIdentifier: TutorDescCollectionViewCell.id)
    }
    
    private lazy var bannerCounter = ScrollCounter(maxPage: 5)
    
    private let bottomButtonView = BottomButton()
    
    //MARK: - Init
    init(viewModel: DetailTutorViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initialLayout()
        
        setDataSource()
        createSnapshot()
        
        viewModelInputs()
        viewModelOutput()
        
        viewInputs()
    }
    
    //MARK: - Private Methods
    private func viewModelInputs() {
        navBar.leftBtnItem.rx.tap
            .bind(to: viewModel.inputs.backward)
            .disposed(by: disposeBag)
    }
    private func viewModelOutput() {
        viewModel.outputs.tutorData
            .bind { [weak self] postData in
                self?.updateTutorData(with: postData)
            }.disposed(by: disposeBag)
    }
    
    private func viewInputs() {
        bottomButtonView.button.rx.tap
            .bind(to: viewModel.inputs.message)
            .disposed(by: disposeBag)
    }
    
    private func updateTutorData(with tutorData: DetailTutorDataModel) {
        guard var currentSnapshot = self.dataSource?.snapshot() else { return }
        
        let profileSection = Section.profile
        let profileItem = Item.profile(tutorData)
        currentSnapshot.deleteItems(currentSnapshot.itemIdentifiers(inSection: profileSection))
        currentSnapshot.appendItems([profileItem])
        
        DispatchQueue.main.async {
            self.dataSource?.apply(currentSnapshot)
        }
    }
}

//MARK: - Layout
extension DetailTutorViewController {
    private func setupViews() {
        view.addSubviews([
            navBar,
            collectionView,
            bottomButtonView
        ])
        
        collectionView.addSubviews([bannerCounter])
    }
    
    private func initialLayout() {
        self.view.backgroundColor = .white
        navBar.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        
        bannerCounter.snp.makeConstraints {
            $0.top.equalToSuperview().inset(270)
            $0.left.equalToSuperview().inset(12)
        }
        
        bottomButtonView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.left.bottom.right.equalToSuperview()
        }
    }
}

//MARK: - CompositionalLayout
extension DetailTutorViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            let section = self?.dataSource?.sectionIdentifier(for: sectionIndex)
            switch section {
            case .banner:
                return self?.createBannerSection()
            case .title:
                return nil
            case .profile:
                return self?.createProfileSection()
            case .detailInfo:
                return self?.createInfoSection()
            case .description:
                return self?.createDescSection()
            default:
                return nil
            }
        },configuration: config)
    }
    
    private func createBannerSection() -> NSCollectionLayoutSection {
        //Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(300)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        let pageWidth = collectionView.bounds.width
        section.visibleItemsInvalidationHandler = { [weak self] (visibleItem, offset, env) in
            guard let self = self else { return }
            if let page = Int(exactly: (offset.x + pageWidth) / pageWidth) {
                print("DetailTutorViewController Banner Page : \(page)")
                self.bannerCounter.currentPage = page
            }
        }
        return section
    }
    
    private func createProfileSection() -> NSCollectionLayoutSection {
        //Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(80)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    private func createInfoSection() -> NSCollectionLayoutSection {
        //Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(200)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        return section
    }
    
    
    private func createDescSection() -> NSCollectionLayoutSection {
        //Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.0)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        return section
    }
}

//MARK: - DataSource
extension DetailTutorViewController {
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                switch item {
                case .bannerItem:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: BannerCollectionViewCell.id,
                        for: indexPath
                    ) as? BannerCollectionViewCell
                    
//                    cell?.configure(bannerModel: BannerModel(imageUrl: "https://source.unsplash.com/random/400x400?17"))
                    
                    return cell
                    
                case .profile(let tutorData):
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: TutorProfileCollectionViewCell.id,
                        for: indexPath
                    ) as? TutorProfileCollectionViewCell
                    
                    cell?.configure(with: tutorData)
                    return cell
                    
                case .detailInfo:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: TutorInfoCollectionViewCell.id,
                        for: indexPath
                    ) as? TutorInfoCollectionViewCell
                    
                    return cell
                    
                case .descItem:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: TutorDescCollectionViewCell.id,
                        for: indexPath
                    ) as? TutorDescCollectionViewCell
                    
                    return cell
                }
            }
        )
    }
    
    private func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        let bannerSection = Section.banner
        let bannerItems = [
            Item.bannerItem("https://source.unsplash.com/random/400x400?21"),
            Item.bannerItem("https://source.unsplash.com/random/400x400?22"),
            Item.bannerItem("https://source.unsplash.com/random/400x400?23"),
            Item.bannerItem("https://source.unsplash.com/random/400x400?24"),
            Item.bannerItem("https://source.unsplash.com/random/400x400?25")
        ]
        snapshot.appendSections([bannerSection])
        snapshot.appendItems(bannerItems,toSection: bannerSection)
        
        let profileSection = Section.profile
//        let profileItem = Item.profile
        snapshot.appendSections([profileSection])
//        snapshot.appendItems([profileItem], toSection: profileSection)
        
        let infoSection = Section.detailInfo
//        let infoItem = Item.detailInfo
        snapshot.appendSections([infoSection])
//        snapshot.appendItems([infoItem], toSection: infoSection)
        
        let descSection = Section.description
//        let descItem = Item.descItem
        snapshot.appendSections([descSection])
//        snapshot.appendItems([descItem], toSection: descSection)
        
        dataSource?.apply(snapshot)
    }
}
