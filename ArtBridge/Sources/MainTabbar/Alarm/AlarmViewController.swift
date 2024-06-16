//
//  AlarmViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 6/16/24.
//

import UIKit
import RxSwift

fileprivate enum Section: Hashable {
    case vertical
}

fileprivate enum Item: Hashable {
    case alarmItem(String)
}

final class AlarmViewController: UIViewController {
    //MARK: - Properties
    private let viewModel: AlarmViewModel
    private var disposeBag = DisposeBag()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    //MARK: - UI
    private let navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.title.text = "알람"
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
        $0.register(AlarmCollectionViewCell.self, forCellWithReuseIdentifier: AlarmCollectionViewCell.id)
    }
    
    //MARK: - Init
    init(viewModel: AlarmViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        setupViews()
        initialLayout()
        
        setDataSource()
        createSnapshot()
        
        viewModelInput()
    }
    
    //MARK: - Methods
    private func viewModelInput() {
        navBar.leftBtnItem.rx.tap
            .bind(to: viewModel.inputs.backward)
            .disposed(by: disposeBag)
    }
}

//MARK: - Layout
extension AlarmViewController {
    private func setupViews() {
        view.addSubviews([
            navBar,
            collectionView
        ])
    }
    
    private func initialLayout() {
        self.view.backgroundColor = .white
        
        navBar.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom)
            $0.left.bottom.right.equalToSuperview()
        }
    }
}

//MARK: - CompositionalLayout
extension AlarmViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            let section = self?.dataSource?.sectionIdentifier(for: sectionIndex)
            
            switch section {
            case .vertical:
                return self?.createVerticalSection()
            default:
                return nil
            }
        })
    }
    
    private func createVerticalSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 8, trailing: 4)
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}

//MARK: - DataSource
extension AlarmViewController {
    private func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        let alarmItems = [Item.alarmItem("1"),Item.alarmItem("2"),Item.alarmItem("3")]
        let alarmSection = Section.vertical
        
        snapshot.appendSections([alarmSection])
        snapshot.appendItems(alarmItems)
        
        dataSource?.apply(snapshot)
    }
    
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                switch item {
                case .alarmItem(let text):
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: AlarmCollectionViewCell.id,
                        for: indexPath
                    ) as? AlarmCollectionViewCell
                    return cell
                }
            }
        )
    }
}
