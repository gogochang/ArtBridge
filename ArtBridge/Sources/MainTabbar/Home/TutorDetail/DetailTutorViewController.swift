//
//  DetailTutorViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 5/17/24.
//

import UIKit
import RxSwift

fileprivate enum Section: Hashable {
    case banner
    case title
    case profile
    case detailInfo
    case description
}

fileprivate enum Item: Hashable {
    case bannerItem
}

final class DetailTutorViewController: UIViewController {
    //MARK: - Properties
    private let viewModel: DetailTutorViewModel
    private let disposeBag: DisposeBag = DisposeBag()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    //MARK: - UI
    private let navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.rightBtnItem.setImage(UIImage(systemName: "bell"), for: .normal)
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
        $0.backgroundColor = .orange
    }
    
    //MARK: - Init
    init(viewModel: DetailTutorViewModel) {
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
        
        viewModelInput()
    }
    
    private func viewModelInput() {
        navBar.leftBtnItem.rx.tap
            .bind(to: viewModel.inputs.backward)
            .disposed(by: disposeBag)
    }
}

//MARK: - Layout
extension DetailTutorViewController {
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
    }
}

//MARK: - CompositionalLayout
extension DetailTutorViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            let section = self?.dataSource?.sectionIdentifier(for: sectionIndex)
            switch section {
            case .banner:
                return self?.createBannerSection()
            case .title:
                return nil
            case .profile:
                return nil
            case .detailInfo:
                return nil
            case .description:
                return nil
            default:
                return nil
            }
        
        },configuration: config)
    }
    
    private func createBannerSection() -> NSCollectionLayoutSection {
        //Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(400)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}

