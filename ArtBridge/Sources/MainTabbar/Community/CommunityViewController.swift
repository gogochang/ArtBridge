//
//  CommunityViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 4/28/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

fileprivate enum Section: Hashable {
    case topButtons
    case horizontal
    case vertical
}
fileprivate enum Item: Hashable {
    case buttons(Int)
    case category(Int)
    case post(Int)
}

final class CommunityViewController: UIViewController {
    //MARK: - Properties
    private let viewModel: CommunityViewModel
    private let disposeBag = DisposeBag()
    
    private var createButtonWidthConstraint: Constraint?
    private var createButtonHeightConstraint: Constraint?
    
    //MARK: - Init
    init(viewModel: CommunityViewModel) {
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
        
        inputView()
        viewModelInput()
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    //MARK: - UI
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = UIColor(white: 0.97, alpha: 1.0)
        
        $0.register(
            ButtonCollectionViewCell.self,
            forCellWithReuseIdentifier: ButtonCollectionViewCell.id
        )
        
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
    private let createPostButton = FloatingButton().then {
        $0.backgroundColor = .brown
        $0.layer.cornerRadius = 25
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.3
        $0.layer.shadowOffset = CGSize(width: 2, height: 2)
        $0.layer.shadowRadius = 5
    }
    
    private func inputView() {
        collectionView.rx.contentOffset
            .map { $0.y > 100 }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] isScrolledDown in
                guard let self = self else { return }
                self.createButtonWidthConstraint?.update(offset: isScrolledDown ? 50 : 110)
                UIView.animate(withDuration: 0.2) {
                    self.view.layoutIfNeeded()
                }
            }).disposed(by: disposeBag)
    }
    
    private func viewModelInput() {
        createPostButton.rx.tapGesture()
            .skip(1)
            .map { _ in }
            .bind(to: viewModel.inputs.tappedCreatePost)
            .disposed(by: disposeBag)
    }
}

//MARK: - Layout
extension CommunityViewController {
    private func setupViews() {
        view.addSubviews([
            navBar,
            collectionView,
            createPostButton
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
        
        createPostButton.snp.makeConstraints {
            $0.bottom.right.equalTo(collectionView).inset(16)
            createButtonWidthConstraint = $0.width.equalTo(110).constraint
            createButtonHeightConstraint = $0.height.equalTo(50).constraint
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
            case .topButtons:
                return self?.createTopButtonsSection()
            case .horizontal:
                return self?.createCategorySection()
            case .vertical:
                return self?.createVerticalSection()
            default:
                return self?.createCategorySection()
            }
            
        },configuration: config)
    }
    
    private func createTopButtonsSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(44)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        
        return section
    }
    
    private func createCategorySection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 0, trailing: 4)  // 아이템 간 간격 조정
        
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
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 20, bottom: 4, trailing: 20)
        
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
        
        let buttonItems = [Item.buttons(1)]
        let buttonSection = Section.topButtons
        
        let categoryItems = [Item.category(1),Item.category(2),Item.category(3),Item.category(4),Item.category(5)]
        let horizontalSection = Section.horizontal
        
        let postITems = [Item.post(1),Item.post(2),Item.post(3),Item.post(4),Item.post(5),
                         Item.post(6),Item.post(7),Item.post(8),Item.post(9),Item.post(10)]
        let verticalSection = Section.vertical
        
        snapshot.appendSections([buttonSection, horizontalSection, verticalSection])
        snapshot.appendItems(buttonItems, toSection: buttonSection)
        snapshot.appendItems(categoryItems, toSection: horizontalSection)
        snapshot.appendItems(postITems, toSection: verticalSection)
        
        dataSource?.apply(snapshot)
    }
    
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                switch item {
                case .buttons:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: ButtonCollectionViewCell.id,
                        for: indexPath
                    ) as? ButtonCollectionViewCell
                    
                    return cell
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

//MARK: - UICollectionViewDelegate
extension CommunityViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = dataSource?.sectionIdentifier(for: indexPath.section)
        switch section {
        case .vertical:
            self.viewModel.inputs.showDetailPost.onNext(())
        case .horizontal:
            print("카테고리 버튼 클릭")
        default:
            break
        }
    }
}
