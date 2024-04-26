//
//  HomeViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 4/25/24.
//

import UIKit
import RxSwift

fileprivate enum Section: Hashable {
    case navBar
    case banner
}

fileprivate enum Item: Hashable {
    case normal(Int)
}

class HomeViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        collectionView.alwaysBounceVertical = false
        collectionView.register(
            BannerCollectionViewCell.self,
            forCellWithReuseIdentifier: BannerCollectionViewCell.id
        )
        return collectionView
    }()
    
    private var navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setImage(UIImage(systemName: "apple.logo"), for: .normal)
        $0.rightBtnItem.setImage(UIImage(systemName: "bell"), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initialLayout()
        setDatasource()
        
        var snapshot = NSDiffableDataSourceSnapshot<Section,Item>()

        let items = [Item.normal(1),Item.normal(2),Item.normal(3),Item.normal(4)]
        let section = Section.banner
        snapshot.appendSections([section])
        snapshot.appendItems(items, toSection: section)
        dataSource?.apply(snapshot)
    }
}

//MARK: - Layout
extension HomeViewController {
    private func setupViews() {
        view.addSubviews([
            navBar,
            collectionView
        ])
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
        config.interSectionSpacing = 14
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            let section = self?.dataSource?.sectionIdentifier(for: sectionIndex)
            
            switch section {
            case .banner:
                return self?.createBannerSection()
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
            heightDimension: .absolute(160)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }
}

//MARK: - Datasource
extension HomeViewController {
    private func setDatasource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                print("test: \(indexPath)")
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: BannerCollectionViewCell.id,
                    for: indexPath
                ) as? BannerCollectionViewCell
                return cell
            }
        )
    }
}
