//
//  DetailPostViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 5/12/24.
//

import UIKit
import RxSwift
import BlurUIKit

fileprivate enum Section: Hashable {
    case banner
    case title
    case content
}

fileprivate enum Item: Hashable {
    case bannerItem(String)
    case title
    case content(String)
}

final class DetailPostViewController: BaseViewController {
    //MARK: - Properties
    private let viewModel: DetailPostViewModel
    private let disposeBag: DisposeBag = DisposeBag()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    //MARK: - UI
    private let navBar = ArtBridgeNavBar().then {
        $0.leftButton.setImage(UIImage(named: "iconBack"), for: .normal)
        $0.rightButton.setImage(UIImage(named: "testProfile"), for: .normal)
        $0.title.text = "KBS 스타뉴스"
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.contentInset =  UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        
        $0.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.id)
        $0.register(DetailPostTitleCell.self, forCellWithReuseIdentifier: DetailPostTitleCell.id)
        $0.register(DetailPostContentCell.self, forCellWithReuseIdentifier: DetailPostContentCell.id)
    }
    
    // TODO: 클래스로 새로 하나 만들자 공통사용
    private let bottomView = UIView().then {
        $0.layer.cornerRadius = 40
        $0.clipsToBounds = true
    }
    
    private let bottomBlurView = VariableBlurView().then {
        $0.dimmingTintColor = .black
        $0.dimmingOvershoot = .absolute(position: 0)
    }
    
    private let bottomInnerShadowView = UIView().then {
        $0.backgroundColor = .clear
        $0.layer.shadowColor = UIColor.white.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        $0.layer.shadowRadius = 2
        $0.layer.shadowOpacity = 0.2
        
        $0.layer.borderWidth = 10
        $0.layer.cornerRadius = 50
    }
    
    private let commentButton = SelectionButton().then {
        $0.setCornerRadius(32)
        $0.setTitle("감상평")
        $0.setImage(UIImage(named: "coment"), for: .normal)
        $0.setImage(UIImage(named: "coment_fill"), for: .selected)
    }
    
    private let applicantButton = SelectionButton().then {
        $0.setCornerRadius(32)
        $0.setTitle("관객 참여중")
        $0.setImage(UIImage(named: "my"), for: .normal)
        $0.setImage(UIImage(named: "my_fill"), for: .selected)
    }
    
    private lazy var bottomContentHStack = UIStackView.make(
        with: [commentButton, applicantButton],
        axis: .horizontal,
        alignment: .center,
        distribution: .fillEqually,
        spacing: 16
    )
    
    //MARK: - Init
    init(viewModel: DetailPostViewModel) {
        self.viewModel = viewModel
        super.init()
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
        viewModelOutput()
    }
    
    //MARK: - Private Methods
    private func viewModelInput() {
        navBar.leftBtnItem.rx.tap
            .bind(to: viewModel.inputs.backward)
            .disposed(by: disposeBag)
    }
    
    private func viewModelOutput() {
        viewModel.outputs.postData
            .bind { [weak self] postData in
                self?.updatePostData(with: postData)
            }.disposed(by: disposeBag)
    }
    
    private func updatePostData(with postData: DetailPostDataModel) {
        guard var currentSnapshot = self.dataSource?.snapshot() else { return }
//        
//        let singleSection = Section.single
//        let singleItem = Item.contentItem(postData)
//        
//        currentSnapshot.deleteItems(currentSnapshot.itemIdentifiers(inSection: singleSection))
//        currentSnapshot.appendItems([singleItem])
//        
//        DispatchQueue.main.async {
//            self.dataSource?.apply(currentSnapshot)
//        }
    }
}

//MARK: - Layout
extension DetailPostViewController {
    private func setupViews() {
        view.addSubviews([
            navBar,
            collectionView,
            bottomView,
        ])
        
        bottomView.addSubviews([
            bottomBlurView,
            bottomInnerShadowView,
            bottomContentHStack
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
        
        bottomView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(80)
        }
        
        bottomBlurView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
        
        bottomContentHStack.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview().inset(8)
        }
        
        commentButton.snp.makeConstraints {
            $0.height.equalTo(64)
        }
        
        applicantButton.snp.makeConstraints {
            $0.height.equalTo(64)
        }
    }
}

//MARK: - CompositionalLayout
extension DetailPostViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 16
        
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            let section = self?.dataSource?.sectionIdentifier(for: sectionIndex)
            switch section {
            case .banner:
                return self?.createBannerSection()
            case .title:
                return self?.createTitleSection()
            case .content:
                return self?.createContentSection()
            default:
                return nil
            }
            
        }, configuration: config)
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
            heightDimension: .absolute(260)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
    private func createTitleSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(100)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(100)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 24, bottom: 0, trailing: 24)
        
        return section
    }

    private func createContentSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(100)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(100)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24)
        return section
    }
}

//MARK: - DataSource
extension DetailPostViewController {
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                switch item {
                case .bannerItem:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: BannerCollectionViewCell.id,
                        for: indexPath
                    ) as? BannerCollectionViewCell
                    
//                    cell?.configure(bannerModel: BannerModel(imageUrl: "https://source.unsplash.com/random/400x400?17"))
                    
                    return cell
                case .title:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: DetailPostTitleCell.id,
                        for: indexPath
                    ) as? DetailPostTitleCell
                    
                    return cell
                    
                case .content(let text):
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: DetailPostContentCell.id,
                        for: indexPath
                    ) as? DetailPostContentCell
                    
                    return cell
                }
                
            }
        )
    }
    
    private func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        let bannerItems = [Item.bannerItem("A")]
        let bannerSection = Section.banner
        
        let titleItems = [Item.title]
        let titleSection = Section.title
        
        let contentItems = [Item.content("dd")]
        let contentSection = Section.content
        
        snapshot.appendSections([
            bannerSection,
            titleSection,
            contentSection
        ])
        
        snapshot.appendItems(bannerItems,toSection: bannerSection)
        snapshot.appendItems(titleItems,toSection: titleSection)
        snapshot.appendItems(contentItems,toSection: contentSection)
        
        dataSource?.apply(snapshot)
    }
}
