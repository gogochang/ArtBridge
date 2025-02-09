//
//  PostListViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 2/8/25.
//

import UIKit
import RxSwift

fileprivate enum Section: Hashable {
    case search
    case vertical
}

fileprivate enum Item: Hashable {
    case search
    case post(String)
}

final class PostListViewController: BaseViewController {
    //MARK: - Properties
    private let disposeBag = DisposeBag()
    private let viewModel: PostListViewModel
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    //MARK: - UI
    private let navBar = ArtBridgeNavBar().then {
        $0.leftButton.setImage(UIImage(named: "iconBack"), for: .normal)
        $0.rightButton.isHidden = true
        $0.title.text = "지금 인기있는 클래식 정보"
    }
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: self.createLayout()).then {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
            $0.contentInset =  UIEdgeInsets(top: 56, left: 0, bottom: 0, right: 0)
            
            $0.register(SearchViewCell.self, forCellWithReuseIdentifier: SearchViewCell.id)
            $0.register(PostCell.self, forCellWithReuseIdentifier: PostCell.id)
        }
    
    //MARK: - Init
    init(viewModel: PostListViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        initialLayout()
        
        setDataSource()
        createSnapshot()
        
        viewModelInput()
        viewModelOutput()
    }
    
    //MARK: - Methods
    private func viewModelInput() {
        navBar.leftButton.rx.tapGesture()
            .skip(1)
            .map { _ in }
            .bind(to: viewModel.routes.backward)
            .disposed(by: disposeBag)
    }
    
    private func viewModelOutput() {
        
    }
}
// MARK: - CompositionalLayout
extension PostListViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 32
        
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            let section = self?.dataSource?.sectionIdentifier(for: sectionIndex)
            
            switch section {
            case .search:
                return self?.createSearchSection()
            case .vertical:
                return self?.createVerticalSection()
            default:
                return nil
            }
            
        }, configuration: config)
    }
    
    private func createSearchSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(56)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 24, bottom: 0, trailing: 24)
        return section
    }
    
    private func createVerticalSection() -> NSCollectionLayoutSection {
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
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24)
//        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 16
        
        return section
    }
}

// MARK: - DataSource
extension PostListViewController {
    private func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        let searchItem = [Item.search]
        let searchSection = Section.search
        
        let infoItem = [
            Item.post("1"),
            Item.post("2"),
            Item.post("3"),
            Item.post("4"),
            Item.post("5"),
            Item.post("6"),
            Item.post("7"),
            Item.post("8"),
            Item.post("9"),
            Item.post("0")
        ]
        
        let verticalSection = Section.vertical
        
        snapshot.appendSections([
            searchSection,
            verticalSection
        ])
        
        snapshot.appendItems(searchItem, toSection: searchSection)
        snapshot.appendItems(infoItem, toSection: verticalSection)
        
        dataSource?.apply(snapshot)
    }
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                switch item {
                case .search:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: SearchViewCell.id,
                        for: indexPath
                    ) as? SearchViewCell
                    return cell
                    
                case .post:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: PostCell.id,
                        for: indexPath
                    ) as? PostCell
                    
                    return cell
                }
            }
        )
    }
}
//MARK: - Layout
extension PostListViewController {
    private func setupViews() {
        view.addSubviews([
            collectionView,
            navBar,
        ])
    }
    
    private func initialLayout() {
        navBar.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
    }
}

