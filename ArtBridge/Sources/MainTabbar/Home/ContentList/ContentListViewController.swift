//
//  ContentListViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 5/10/24.
//

import UIKit
import RxSwift

fileprivate enum Section: Hashable {
    case double(String)
}

fileprivate enum Item: Hashable {
    case previewItem(String, String, String?)
}

final class ContentListViewController: UIViewController {
    //MARK: - Properties
    private let viewModel: ContentListViewModel
    private let disposeBag: DisposeBag = DisposeBag()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    //MARK: - UI
    private let navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.rightBtnItem.setImage(UIImage(systemName: "bell"), for: .normal)
        $0.title.text = "지금 인기있는 글"
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
        $0.showsVerticalScrollIndicator = false
        
        $0.register(
            PreviewCollectionViewCell.self,
            forCellWithReuseIdentifier: PreviewCollectionViewCell.id
        )
        
        $0.register(
            HeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderView.id
        )
    }
    
    //MARK: - Init
    init(viewModel: ContentListViewModel) {
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
        
        setDatasource()
        createSnapshot()
        
        viewModelInput()
        viewModelOutput()
        
        collectionView.delegate = self
    }
    
    //MARK: - Private Methods
    private func viewModelInput() {
        navBar.leftBtnItem.rx.tap
            .bind (to: viewModel.inputs.backward )
            .disposed(by: disposeBag)
    }
    
    private func viewModelOutput() {
        viewModel.outputs.postListData
            .subscribe(onNext: { [weak self] postData in
                self?.updatePostData(with: postData)
            }).disposed(by: disposeBag)
    }
    
    private func updatePostData(with postData: [ContentDataModel]) {
        guard var currentSnapshot = self.dataSource?.snapshot() else { return }
        
        let doubleSection = Section.double("지금 인기있는 글")
        let popularPostItems = postData.map {
            Item.previewItem(
                $0.title,
                "\($0.id)",
                $0.coverURL
            )
        }
        
        currentSnapshot.deleteItems(currentSnapshot.itemIdentifiers(inSection: doubleSection))
        currentSnapshot.appendItems(popularPostItems, toSection: doubleSection)
        
        // 메인 스레드에서 스냅샷을 적용
        DispatchQueue.main.async {
            self.dataSource?.apply(currentSnapshot)
        }
    }
}

//MARK: - Layout
extension ContentListViewController {
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
            $0.left.bottom.right.equalToSuperview()
        }
    }
}

//MARK: - CompositionalLayout
extension ContentListViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            let section = self?.dataSource?.sectionIdentifier(for: sectionIndex)
            
            switch section {
            case .double:
                return self?.createPopularDoubleSection()
            default:
                return self?.createPopularDoubleSection()
            }
        }, configuration: config)
    }
    
    private func createPopularDoubleSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(200)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 8, trailing: 4)
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(200)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        return section
    }
}

//MARK: - Datasource
extension ContentListViewController {
    private func setDatasource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                
                switch item {
                case .previewItem(let title, let nickname, let coverImgUrl):
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: PreviewCollectionViewCell.id,
                        for: indexPath
                    ) as? PreviewCollectionViewCell
                    
                    cell?.configure(
                        coverImgUrl: coverImgUrl,
                        title: title,
                        subTitle: nickname
                    )
                    
                    return cell
                }
            })
    }
    
    private func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        let doubleSection = Section.double("지금 인기있는 글")
        let popularPostItems = [
            Item.previewItem("제 연주 피드백 부탁드립니다.", "강호동", "https://source.unsplash.com/random/400x400?5")
        ]
        
        snapshot.appendSections([doubleSection])
        snapshot.appendItems(popularPostItems, toSection: doubleSection)
        
        dataSource?.apply(snapshot)
    }
}

//MARK: - UICollectionView Delegate
extension ContentListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("선택된 아이템의 상세페이지로 이동")
        viewModel.inputs.showDetailPost.onNext(())
    }
}
