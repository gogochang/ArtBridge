//
//  CommunityViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 4/28/24.
//

import UIKit
fileprivate enum Section: Hashable {
    case horizontal
    case vertical
}
fileprivate enum Item: Hashable {
    case category(Int)
    case post(Int)
}

final class CommunityViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initialLayout()
        
        setDataSource()
        createSnapshot()
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
        $0.showsVerticalScrollIndicator = false
        
        $0.register(
            CategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoryCollectionViewCell.id
        )
        
        $0.register(
            PostCollectionViewCell.self,
            forCellWithReuseIdentifier: PostCollectionViewCell.id
        )
    }
    
    private let navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setImage(UIImage(systemName: "apple.logo"), for: .normal)
        $0.rightBtnItem.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
    }
}

//MARK: - Layout
extension CommunityViewController {
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
extension CommunityViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            let section = self?.dataSource?.sectionIdentifier(for: sectionIndex)
            
            switch section {
            case .horizontal:
                return self?.createCategorySection()
            case .vertical:
                return self?.createVerticalSection()
            default:
                return self?.createCategorySection()
            }
            
        },configuration: config)
    }
    
    private func createCategorySection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)  // 아이템 간 간격 조정
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(160),
            heightDimension: .absolute(40)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20)
        
        return section
    }
    
    private func createVerticalSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 8, trailing: 4)
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(120)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}

//MARK: - DataSource
extension CommunityViewController {
    private func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        let categoryItems = [Item.category(1),Item.category(2),Item.category(3),Item.category(4),Item.category(5)]
        let horizontalSection = Section.horizontal
        
        let postITems = [Item.post(1),Item.post(2),Item.post(3),Item.post(4),Item.post(5),
                         Item.post(6),Item.post(7),Item.post(8),Item.post(9),Item.post(10)]
        let verticalSection = Section.vertical
        
        snapshot.appendSections([horizontalSection, verticalSection])
        snapshot.appendItems(categoryItems, toSection: horizontalSection)
        snapshot.appendItems(postITems, toSection: verticalSection)
        
        dataSource?.apply(snapshot)
    }
    
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                switch item {
                case .category:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: CategoryCollectionViewCell.id,
                        for: indexPath
                    ) as? CategoryCollectionViewCell
                    
                    return cell
                    
                case .post:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: PostCollectionViewCell.id,
                        for: indexPath
                    ) as? PostCollectionViewCell
                    
                    return cell
                }
            }
        )
    }
}
