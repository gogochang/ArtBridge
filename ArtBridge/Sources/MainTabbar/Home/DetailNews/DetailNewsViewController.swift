//
//  DetailNewsViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 5/21/24.
//

import UIKit
import RxSwift

fileprivate enum Section: Hashable {
    case newsBanner
    case newsInfo
    case newsContent
    case newsComment
}

fileprivate enum Item: Hashable {
    case bannerItem(DetailNewsDataModel)
    case infoItem(DetailNewsDataModel)
    case contentItem
    case commentItem
}

final class DetailNewsViewController: UIViewController {
    //MARK: - Properties
    private let viewModel: DetailNewsViewModel
    private let disposeBag: DisposeBag = DisposeBag()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    //MARK: - UI
    private let navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.rightBtnItem.setImage(UIImage(systemName: "bell"), for: .normal)
        $0.title.text = "뉴스 상세보기"
    }
    
    private let commentInputView = CommentInputView(placeHolder: "댓글을 입력해주세요.")
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
        $0.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.id)
        $0.register(NewsInfoCollectionViewCell.self, forCellWithReuseIdentifier: NewsInfoCollectionViewCell.id)
        $0.register(NewsContentCollectionViewCell.self, forCellWithReuseIdentifier: NewsContentCollectionViewCell.id)
        $0.register(CommentCollectionViewCell.self, forCellWithReuseIdentifier: CommentCollectionViewCell.id)
    }
    
    //MARK: - Init
    init(viewModel: DetailNewsViewModel) {
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
        viewModelOutput()
        
        dismissKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Private Methods
    private func viewModelInput() {
        navBar.leftBtnItem.rx.tap
            .bind(to: viewModel.inputs.backward)
            .disposed(by: disposeBag)
    }
    
    private func viewModelOutput() {
        viewModel.outputs.newsData
            .bind { [weak self] newsData in
                self?.updateNewsData(with: newsData)
            }.disposed(by: disposeBag)
    }
    
    private func updateNewsData(with newsData: DetailNewsDataModel) {
        guard var currentSnapshot = self.dataSource?.snapshot() else { return }
        let bannerSection = Section.newsBanner
        let bannerItem = Item.bannerItem(newsData)
        currentSnapshot.deleteItems(currentSnapshot.itemIdentifiers(inSection: bannerSection))
        currentSnapshot.appendItems([bannerItem], toSection: bannerSection)
        
        let infoSection = Section.newsInfo
        let infoItem = Item.infoItem(newsData)
        currentSnapshot.deleteItems(currentSnapshot.itemIdentifiers(inSection: infoSection))
        currentSnapshot.appendItems([infoItem], toSection: infoSection)
        DispatchQueue.main.async {
            self.dataSource?.apply(currentSnapshot)
        }
    }
}

//MARK: - Layout
extension DetailNewsViewController {
    private func setupViews() {
        view.addSubviews([
            navBar,
            collectionView,
            commentInputView
        ])
    }
    
    private func initialLayout() {
        self.view.backgroundColor = .white
        
        navBar.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(navBar.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        
        commentInputView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.left.bottom.right.equalToSuperview()
        }
    }
}

//MARK: - CompositionalLayout
extension DetailNewsViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: {
            [weak self] sectionIndex, _ in
            let section = self?.dataSource?.sectionIdentifier(for: sectionIndex)
            
            switch section {
            case .newsBanner:
                return self?.createBannerSection()
            case .newsInfo:
                return self?.createInfoSection()
            case .newsContent:
                return self?.createContentSection()
            case .newsComment:
                return self?.createCommentSection()
            default:
                return nil
            }
        })
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
            heightDimension: .absolute(300)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createInfoSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(180)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        return section
    }
    
    private func createContentSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(200)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(200)
        )
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        return section
    }
    
    private func createCommentSection() -> NSCollectionLayoutSection {
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
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 100, trailing: 0)
        
        return section
    }
}

//MARK: - DataSource
extension DetailNewsViewController {
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                switch item {
                case .bannerItem(let newsData):
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: BannerCollectionViewCell.id,
                        for: indexPath
                    ) as? BannerCollectionViewCell
//                    cell?.configure(
//                        bannerModel: BannerModel(
//                            imageUrl: newsData.news.coverURL
//                        )
//                    )
                    return cell
                    
                case .infoItem(let newsData):
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: NewsInfoCollectionViewCell.id,
                        for: indexPath
                    ) as? NewsInfoCollectionViewCell
                    cell?.configure(with: newsData)
                    return cell
                    
                case .contentItem:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: NewsContentCollectionViewCell.id,
                        for: indexPath
                    ) as? NewsContentCollectionViewCell
                    return cell
                    
                case .commentItem:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: CommentCollectionViewCell.id,
                        for: indexPath
                    ) as? CommentCollectionViewCell
                    return cell
                }
            }
        )
    }
    
    private func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        let bannerSection = Section.newsBanner
//        let bannerItem = Item.bannerItem(nil)
        
        let infoSection = Section.newsInfo
//        let infoItem = Item.infoItem
        
        let contentSection = Section.newsContent
//        let contentItem = Item.contentItem
        
        let commentSection = Section.newsComment
//        let commentItem = Item.commentItem
        
        snapshot.appendSections([bannerSection, infoSection, contentSection, commentSection])
//        snapshot.appendItems([bannerItem], toSection: bannerSection)
//        snapshot.appendItems([infoItem], toSection: infoSection)
//        snapshot.appendItems([contentItem], toSection: contentSection)
//        snapshot.appendItems([commentItem], toSection: commentSection)
        
        dataSource?.apply(snapshot)
    }
}

//MARK: - Extension Gesture
extension DetailNewsViewController {
    func dismissKeyboardWhenTappedAround() {
        let tap =
            UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(false)
    }

    func gestureRecognizer(_: UIGestureRecognizer, shouldBeRequiredToFailBy _: UIGestureRecognizer) -> Bool {
        dismissKeyboard() // 제스처로 뒤로가기할 때 키보드 없애야함
        return true
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            UIView.animate(withDuration: 0.3) {
                self.commentInputView.snp.updateConstraints {
                    $0.bottom.equalToSuperview().inset(keyboardRectangle.height)
                }
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.commentInputView.snp.updateConstraints {
                $0.bottom.equalToSuperview().inset(0)
            }
            self.view.layoutIfNeeded()
        }
    }
}
