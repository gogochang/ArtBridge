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
    case category(headerTitle: String)
    case info(headerTitle: String)
    case user(headerTitle: String)
    case news(headerTitle: String)
}

fileprivate enum Item: Hashable {
    case navBar
    case category(String)
}

final class HomeViewController: BaseViewController {
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let viewModel: HomeViewModel
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    // MARK: - UI
    private var navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setImage(UIImage(named: "logo"), for: .normal)
        $0.rightBtnItem.setImage(UIImage(systemName: "bell"), for: .normal)
        $0.searchView.isHidden = false
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
        $0.backgroundColor = .clear
        
        $0.register(HomeNavBarViewCell.self, forCellWithReuseIdentifier: HomeNavBarViewCell.id)
        $0.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.id)

        $0.register(
            HomeHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HomeHeaderView.id
        )
    }
    
    // MARK: - Init
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initialLayout()
        
        setDataSource()
        createSnapshot()
        
        viewModelInputs()
        viewModelOutput()

    }
    
    // MARK: - Methods
    private func viewModelInputs() {
        navBar.rightBtnItem.rx.tap
            .bind(to: viewModel.inputs.showAlarm)
            .disposed(by: disposeBag)
    }
    
    private func viewModelOutput() {
    }
}

//MARK: - CompositionalLayout
extension HomeViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 24
        
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            let section = self?.dataSource?.sectionIdentifier(for: sectionIndex)
            
            switch section {
            case .navBar:
                return self?.createNavBarSection()
            case .category:
                return self?.createCategorySection()
            default:
                return nil
            }
            
        }, configuration: config)
    }
    
    private func createNavBarSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(60)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createCategorySection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(40),
            heightDimension: .absolute(40)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(
            leading: nil,  // 아이템 왼쪽 간격
            top: nil,      // 아이템 상단 간격
            trailing: .fixed(8),  // 아이템 오른쪽 간격
            bottom: .fixed(8)
        )

        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(40)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 24, leading: 20, bottom: 0, trailing: 20)
        section.interGroupSpacing = 8
        section.orthogonalScrollingBehavior = .none
        // Header
        // Section Header 설정 (카테고리 섹션 헤더)
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(24)  // 🔹 카테고리 헤더 높이 설정
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

// MARK: - DataSource
extension HomeViewController {
    private func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        let navBarItem = [Item.navBar]
        let navBarSection = Section.navBar
        
        let categoryItem = [
            Item.category("피아노"),
            Item.category("플루트"),
            Item.category("하프"),
            Item.category("바이올린"),
            Item.category("호른"),
            Item.category("오카리나"),
        ]
        
        let categorySection = Section.category(headerTitle: "당신이 사랑하는 클래식 음악")
        
        snapshot.appendSections([
            navBarSection,
            categorySection,
        ])
        
        snapshot.appendItems(navBarItem, toSection: navBarSection)
        snapshot.appendItems(categoryItem, toSection: categorySection)
        
        dataSource?.apply(snapshot)
    }
    
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                switch item {
                case .navBar:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: HomeNavBarViewCell.id,
                        for: indexPath
                    ) as? HomeNavBarViewCell
                    return cell
                    
                case .category(let title):
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: CategoryCell.id,
                        for: indexPath
                    ) as? CategoryCell
                    cell?.configure(with: title)
                    return cell
                }
                
            }
        )
        
        dataSource?.supplementaryViewProvider = {[weak self] collectionView, kind, indexPath -> UICollectionReusableView in
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HomeHeaderView.id,
                for: indexPath
            )
            
            let section = self?.dataSource?.sectionIdentifier(for: indexPath.section)
            
            switch section {
            case .navBar:
                break
            case .category(let title):
                (header as? HomeHeaderView)?.configure(title: title)
            default:
                print("Default")
            }
            
            return header
        }

    }
}

//MARK: - Layout
extension HomeViewController {
    private func setupViews() {
        view.addSubview(collectionView)
    }
    
    private func initialLayout() {
        collectionView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
    }
}
