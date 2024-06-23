//
//  MyPageViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 4/29/24.
//

import UIKit
import RxSwift

fileprivate enum Section: Hashable {
    case topProfile
    case menu(String)
    case menu2(String)
    case menu3(String)
    case menu4(String)
}

fileprivate enum Item: Hashable {
    case profile(Int)
    case menuItem(Int)
}

final class MyPageViewController: UIViewController {
    //MARK: - Properties
    private let viewModel: MyPageViewModel
    private var disposeBag = DisposeBag()
    
    //MARK: - Init
    init(viewModel: MyPageViewModel) {
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
        
        setDataSource()
        createSnapshot()
        
        viewModelInputs()
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
        
        $0.register(
            ProfileCollectionViewCell.self,
            forCellWithReuseIdentifier: ProfileCollectionViewCell.id
        )
        
        $0.register(
            MenuItemCollectionViewCell.self,
            forCellWithReuseIdentifier: MenuItemCollectionViewCell.id
        )
        
        $0.register(
            HeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderView.id
        )
    }
    
    private let navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setImage(UIImage(systemName: "apple.logo"), for: .normal)
        $0.rightBtnItem.setImage(UIImage(systemName: "gearshape"), for: .normal)
    }
    
    private func viewModelInputs() {
        navBar.rightBtnItem.rx.tap
            .bind(to: viewModel.inputs.showSetting)
            .disposed(by: disposeBag)
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
            case .menu:
                return self?.createMyMenuSection()
            default:
                return self?.createMyMenuSection()
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
            heightDimension: .absolute(100)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        return section
    }
    
    private func createMyMenuSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)  //
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(44)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
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

//MARK: - DataSource
extension MyPageViewController {
    private func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        let profileItem = [Item.profile(1)]
        let profileSection = Section.topProfile
        
        let menuItems = [Item.menuItem(1), Item.menuItem(2), Item.menuItem(3)]
        let menuSection = Section.menu("Menu")
        
        let menu2Items = [Item.menuItem(4), Item.menuItem(5), Item.menuItem(6)]
        let menu2Section = Section.menu2("Menu2")
        
        let menu3Items = [Item.menuItem(7), Item.menuItem(8), Item.menuItem(9)]
        let menu3Section = Section.menu3("Menu3")
        
        let menu4Items = [Item.menuItem(10), Item.menuItem(11), Item.menuItem(12)]
        let menu4Section = Section.menu4("Menu4")
        
        snapshot.appendSections([profileSection, menuSection, menu2Section, menu3Section ,menu4Section])
        snapshot.appendItems(profileItem,toSection: profileSection)
        snapshot.appendItems(menuItems, toSection: menuSection)
        snapshot.appendItems(menu2Items, toSection: menu2Section)
        snapshot.appendItems(menu3Items, toSection: menu3Section)
        snapshot.appendItems(menu4Items, toSection: menu4Section)
        
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
                    ) as? ProfileCollectionViewCell
                    
                    return cell
                case .menuItem:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: MenuItemCollectionViewCell.id,
                        for: indexPath
                    ) as? MenuItemCollectionViewCell
                    
                    return cell
                }
            }
        )
        
        dataSource?.supplementaryViewProvider = {[weak self] collectionView, kind, indexPath -> UICollectionReusableView in
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.id,
                for: indexPath
            )
            
            let section = self?.dataSource?.sectionIdentifier(for: indexPath.section)
            
            switch section {
            case .menu(let title):
                (header as? HeaderView)?.configure(type: .none, title: title)
            case .menu2(let title):
                (header as? HeaderView)?.configure(type: .none, title: title)
            case .menu3(let title):
                (header as? HeaderView)?.configure(type: .none, title: title)
            case .menu4(let title):
                (header as? HeaderView)?.configure(type: .none, title: title)
            default:
                print("Default")
            }
            
            return header
        }
    }
}
