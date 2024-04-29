//
//  MyPageViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 4/29/24.
//

import UIKit

fileprivate enum Section: Hashable {
    case topProfile
}

fileprivate enum Item: Hashable {
    case profile(Int)
}

final class MyPageViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initialLayout()
        
        setDataSource()
        createSnapshot()
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
        
        $0.register(
            ProfileCollectionViewCell.self,
            forCellWithReuseIdentifier: ProfileCollectionViewCell.id
        )
    }
    
    private let navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setImage(UIImage(systemName: "apple.logo"), for: .normal)
        $0.rightBtnItem.setImage(UIImage(systemName: "gearshape"), for: .normal)
    }
}

//MARK: - Layout
extension MyPageViewController {
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
extension MyPageViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            let section = self?.dataSource?.sectionIdentifier(for: sectionIndex)
            
            switch section {
            case .topProfile:
                return self?.createBannerSection()
            default:
                return self?.createBannerSection()
            }
        })
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
            heightDimension: .absolute(100)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        return section
    }
}

//MARK: - DataSource
extension MyPageViewController {
    private func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        let profileItem = [Item.profile(1)]
        let profileSection = Section.topProfile
        
        snapshot.appendSections([profileSection])
        snapshot.appendItems(profileItem)
        
        dataSource?.apply(snapshot)
    }
    
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                
                switch item {
                case .profile:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: ProfileCollectionViewCell.id,
                        for: indexPath
                    )
                    
                    return cell
                }
            }
        )
    }
}
