//
//  MessageListViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 4/29/24.
//

import UIKit
import RxSwift

fileprivate enum Section: Hashable {
    case horizontal
    case vertical
}

fileprivate enum Item: Hashable {
    case category(Int)
    case preview(Int)
}

final class MessageListViewController: UIViewController {
    //MARK: - Properties
    private let viewModel: MessageListViewModel
    private let disposeBag = DisposeBag()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    //MARK: - UI
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
        
        $0.register(
            CategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoryCollectionViewCell.id
        )
        
        $0.register(
            MessageListCollectionViewCell.self,
            forCellWithReuseIdentifier: MessageListCollectionViewCell.id
        )
    }
    
    private let navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setTitle("ArtBridge", for: .normal)
        $0.leftBtnItem.setTitleColor(.orange, for: .normal)
        $0.leftBtnItem.titleLabel?.font = .jalnan11
        $0.rightBtnItem.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.searchView.isHidden = false
    }
    
    //MARK: - Init
    init(viewModel: MessageListViewModel) {
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
        
        collectionView.delegate = self
    }
}

//MARK: - Layout
extension MessageListViewController {
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
extension MessageListViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            let section = self?.dataSource?.sectionIdentifier(for: sectionIndex)
            
            switch section {
            case .horizontal:
                return self?.createHorizontalSection()
            case .vertical:
                return self?.createVerticalSection()
            default:
                return self?.createHorizontalSection()
            }
            
        },configuration: config)
    }
    
    private func createHorizontalSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(160),
            heightDimension: .absolute(40)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
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
            heightDimension: .absolute(80)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}

//MARK: - DataSource
extension MessageListViewController {
    private func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        let buttonItems = [Item.category(1), Item.category(2), Item.category(3)]
        let buttonSection = Section.horizontal
        
        let previewItems = [Item.preview(1), Item.preview(2), Item.preview(3), Item.preview(4), Item.preview(5),
                            Item.preview(6), Item.preview(7), Item.preview(8), Item.preview(9), Item.preview(10)]
        let previewSection = Section.vertical
        
        snapshot.appendSections([buttonSection, previewSection])
        snapshot.appendItems(buttonItems, toSection: buttonSection)
        snapshot.appendItems(previewItems, toSection: previewSection)
        
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
                    
                case .preview:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: MessageListCollectionViewCell.id,
                        for: indexPath
                    ) as? MessageListCollectionViewCell
                    
                    return cell
                }
                
            }
        )
        
    }
}

//MARK: - UICollectionViewDelegate
extension MessageListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = dataSource?.sectionIdentifier(for: indexPath.section)
        switch section {
        case .horizontal:
            print("카테고리 버튼 클릭")
        case .vertical:
            print("채팅 목록 아이템 클릭")
            self.viewModel.input.message.onNext(())
        case .none:
            print("none")
        }
    }
}
