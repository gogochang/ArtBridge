//
//  CommunityViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 4/28/24.
//

import UIKit
fileprivate enum Section: Hashable {
    case horizontal
}
fileprivate enum Item: Hashable {
    case category(Int)
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
        $0.backgroundColor = .orange
        
        $0.register(
            CategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoryCollectionViewCell.id
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
}

//MARK: - DataSource
extension CommunityViewController {
    private func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        let categoryItems = [Item.category(1),Item.category(2),Item.category(3),Item.category(4),Item.category(5)]
        let horizontalSection = Section.horizontal
        snapshot.appendSections([horizontalSection])
        snapshot.appendItems(categoryItems, toSection: horizontalSection)
        
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
                }
            }
        )
    }
}
