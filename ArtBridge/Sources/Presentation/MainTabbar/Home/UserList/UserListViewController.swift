//
//  UserListViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 2/12/25.
//

import UIKit
import RxSwift

fileprivate enum Section: Hashable {
    case search
    case vertical
}

fileprivate enum Item: Hashable {
    case search
    case user(String)
}

final class UserListViewController: BaseViewController {
    //MARK: - Properties
    private let disposeBag = DisposeBag()
    private let viewModel: UserListViewModel
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    //MARK: - UI
    private let navBar = ArtBridgeNavBar().then {
        $0.leftButton.setImage(UIImage(named: "iconBack"), for: .normal)
        $0.rightButton.isHidden = true
        $0.title.text = "지금 인기있는 연주자"
    }
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: self.createLayout()).then {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
            $0.contentInset =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
            $0.register(SearchViewCell.self, forCellWithReuseIdentifier: SearchViewCell.id)
            $0.register(UserCell.self, forCellWithReuseIdentifier: UserCell.id)
        }
    
    //MARK: - Init
    init(viewModel: UserListViewModel) {
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
            .when(.recognized) .map { _ in }
            .bind(to: viewModel.routes.backward)
            .disposed(by: disposeBag)
    }
    
    private func viewModelOutput() {
        
    }
}

// MARK: - CompositionalLayout
extension UserListViewController {
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
            widthDimension: .absolute(96),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(168)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .flexible(0) // 아이템 간격 자동 조절

        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24)
        
        return section
    }
}

// MARK: - DataSource
extension UserListViewController {
    private func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        let searchItem = [Item.search]
        let searchSection = Section.search
        
        let infoItem = [
            Item.user("1"),
            Item.user("2"),
            Item.user("3"),
            Item.user("4"),
            Item.user("5"),
            Item.user("6"),
            Item.user("7"),
            Item.user("8"),
            Item.user("9"),
            Item.user("0")
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

                case .user:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: UserCell.id,
                        for: indexPath
                    ) as? UserCell else { return nil }
                    
                    return cell
                }
            }
        )
    }
}


//MARK: - Layout
extension UserListViewController {
    private func setupViews() {
        view.addSubviews([
            navBar,
            collectionView
        ])
    }
    
    private func initialLayout() {
        navBar.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom)
            $0.left.bottom.right.equalToSuperview()
        }
    }
}

