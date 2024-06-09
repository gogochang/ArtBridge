//
//  SettingViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 6/7/24.
//

import UIKit
import RxSwift

fileprivate enum Section: Hashable {
    case menu(String)
}

fileprivate enum Item: Hashable {
    case menuItem(Int)
}

final class SettingViewController: UIViewController {
    //MARK: - Properties
    private let disposeBag = DisposeBag()
    private let viewModel: SettingViewModel
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    //MARK: - UI
    private var navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.title.text = "설정하기"
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
        
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
    
    //MARK: - Init
    init(viewModel: SettingViewModel) {
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
        
        viewModelInput()
    }
    
    private func viewModelInput() {
        navBar.leftBtnItem.rx.tap
            .bind(to: viewModel.inputs.backward)
            .disposed(by: disposeBag)
    }
}

//MARK: - Layout
extension SettingViewController {
    private func setupViews() {
        self.view.addSubviews([
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
extension SettingViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            let section = self?.dataSource?.sectionIdentifier(for: sectionIndex)
            
            switch section {
            case .menu:
                return self?.createMyMenuSection()
            default:
                return self?.createMyMenuSection()
            }
        },configuration: config)
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
extension SettingViewController {
    private func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        let menuItems = [Item.menuItem(1), Item.menuItem(2), Item.menuItem(3)]
        let menuSection = Section.menu("Menu")
        
        snapshot.appendSections([menuSection])
        snapshot.appendItems(menuItems, toSection: menuSection)
        
        dataSource?.apply(snapshot)
    }
    
    private func setDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                
                switch item {
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
                (header as? HeaderView)?.configure(title: title)
            default:
                print("Default")
            }
            
            return header
        }
    }
}
