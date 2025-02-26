//
//  DetailUserViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 2/21/25.
//

import UIKit

private enum Section: Hashable {
    case profile
    case category
    case content
    case post(headerTitle: String)
}

private enum Item: Hashable {
    case profile
    case category
    case content
    case post(String)
}

final class DetailUserViewController: BaseViewController {
    // MARK: - Properties
    private let viewModel: DetailUserViewModel
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    // MARK: - UI
    private let navBar = ArtBridgeNavBar().then {
        $0.leftButton.setImage(UIImage(named: "iconBack"), for: .normal)
        $0.rightButton.isHidden = true
        $0.title.text = "연주자 이름"
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.contentInset =  UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        
        $0.register(DetailUserProfileCell.self, forCellWithReuseIdentifier: DetailUserProfileCell.id)
        $0.register(DetailUserCategoryCell.self, forCellWithReuseIdentifier: DetailUserCategoryCell.id)
        $0.register(DetailUserContentCell.self, forCellWithReuseIdentifier: DetailUserContentCell.id)
        $0.register(PostCell.self, forCellWithReuseIdentifier: PostCell.id)
        
        $0.register(
            HomeHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HomeHeaderView.id
        )
    }
    
    // MARK: - Init
    init(viewModel: DetailUserViewModel) {
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
        
        bind()
    }
    
    // MARK: - Binding
    private func bind() {
        let input = DetailUserViewModelInput()
        let output = viewModel.transform(input: input)
    }
    
    // MARK: - Methods
}

// MARK: - Compositional Layout
extension DetailUserViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 16
        
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            let section = self?.dataSource?.sectionIdentifier(for: sectionIndex)
            switch section {
            case .profile:
                return self?.createProfileSection()
            case .category:
                return self?.createCategorySection()
            case .content:
                return self?.createContentSection()
            case .post:
                return self?.createPostSection()
            default:
                return nil
            }
            
        }, configuration: config)
    }
    
    private func createProfileSection() -> NSCollectionLayoutSection {
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
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
    private func createCategorySection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(72)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
    private func createContentSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(232)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
    private func createPostSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(240),
            heightDimension: .absolute(200)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 24, bottom: 0, trailing: 24)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 16
        // Header
        // Section Header 설정 (카테고리 섹션 헤더)
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(40)  // 🔹 카테고리 헤더 높이 설정
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
extension DetailUserViewController {
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                switch item {
                case .profile:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: DetailUserProfileCell.id,
                        for: indexPath
                    ) as? DetailUserProfileCell
                    return cell
                case .category:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: DetailUserCategoryCell.id,
                        for: indexPath
                    ) as? DetailUserCategoryCell
                    
                    return cell
                case .content:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: DetailUserContentCell.id,
                        for: indexPath
                    ) as? DetailUserContentCell
                    
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
        
        dataSource?.supplementaryViewProvider = {[weak self] collectionView, kind, indexPath -> UICollectionReusableView in
            guard let self = self,
                  let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HomeHeaderView.id,
                for: indexPath
            ) as? HomeHeaderView else {
                return UICollectionReusableView()
            }
            
            let section = self.dataSource?.sectionIdentifier(for: indexPath.section)
            
            switch section {
            case .post(let title):
                header.configure(title: title)
                
            default:
                print("Default")
            }
            
            return header
        }
    }
    
    private func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        let profileItem = [Item.profile]
        let profileSection = Section.profile
        
        let categoryItem = [Item.category]
        let categorySection = Section.category
        
        let contentItem = [Item.content]
        let contentSection = Section.content
        
        let postItem = [
            Item.post("AA"),
            Item.post("BB"),
            Item.post("CC"),
            Item.post("DD")
        ]
        let postSection = Section.post(headerTitle: "(닉네임)님이 작성한 클래식 정보")
        
        snapshot.appendSections([
            profileSection,
            categorySection,
            contentSection,
            postSection
        ])
        
        snapshot.appendItems(profileItem, toSection: profileSection)
        snapshot.appendItems(categoryItem, toSection: categorySection)
        snapshot.appendItems(contentItem, toSection: contentSection)
        snapshot.appendItems(postItem, toSection: postSection)
        
        dataSource?.apply(snapshot)
    }
}

// MARK: - Layout
extension DetailUserViewController {
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
