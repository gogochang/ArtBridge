//
//  DetailPostViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 5/12/24.
//

import UIKit
import RxSwift

fileprivate enum Section: Hashable {
    case banner
    case single
    case vertical
}

fileprivate enum Item: Hashable {
    case contentItem(String)
    case bannerItem(String)
    case commentItem(String)
}

final class DetailPostViewController: UIViewController {
    //MARK: - Properties
    private let viewModel: DetailPostViewModel
    private let disposeBag: DisposeBag = DisposeBag()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    //MARK: - UI
    private let navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.rightBtnItem.setImage(UIImage(systemName: "bell"), for: .normal)
        $0.title.text = "게시글 상세보기"
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
        $0.backgroundColor = .systemGray6
        
        $0.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.id)
        $0.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.id)
        $0.register(CommentCollectionViewCell.self, forCellWithReuseIdentifier: CommentCollectionViewCell.id)
    }
    
    private let commentInputView = CommentInputView()
    
    //MARK: - Init
    init(viewModel: DetailPostViewModel) {
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
        
        dismissKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func viewModelInput() {
        navBar.leftBtnItem.rx.tap
            .bind(to: viewModel.inputs.backward)
            .disposed(by: disposeBag)
    }
}

//MARK: - Layout
extension DetailPostViewController {
    private func setupViews() {
        view.addSubviews([
            navBar,
            collectionView,
            commentInputView
        ])
    }
    
    private func initialLayout() {
        view.backgroundColor = .white
        
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
extension DetailPostViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            let section = self?.dataSource?.sectionIdentifier(for: sectionIndex)
            
            switch section {
            case .single:
                return self?.createSingleSection()
            case .banner:
                return self?.createBannerSection()
            case .vertical:
                return self?.createVerticalSection()
            default:
                return nil
            }
        })
    }
    
    private func createSingleSection() -> NSCollectionLayoutSection {
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
        
        return section
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
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
        
        return section
    }
    
    private func createVerticalSection() -> NSCollectionLayoutSection {
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
extension DetailPostViewController {
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                switch item {
                case .contentItem:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: ContentCollectionViewCell.id,
                        for: indexPath
                    ) as? ContentCollectionViewCell
                    
                    return cell
                case .bannerItem:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: BannerCollectionViewCell.id,
                        for: indexPath
                    ) as? BannerCollectionViewCell
                    
                    cell?.configure(bannerModel: BannerModel(imageUrl: "https://source.unsplash.com/random/400x400?17"))
                    
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
        
        let singleSection = Section.single
        let contentItem = Item.contentItem("test")
        snapshot.appendSections([singleSection])
        snapshot.appendItems([contentItem],toSection: singleSection)
        
        let bannerSection = Section.banner
        let bannerItem = Item.bannerItem("testest")
        snapshot.appendSections([bannerSection])
        snapshot.appendItems([bannerItem],toSection: bannerSection)
        
        let verticalSection = Section.vertical
        let commentItems = [Item.commentItem("1"), Item.commentItem("2"), Item.commentItem("3")]
        snapshot.appendSections([verticalSection])
        snapshot.appendItems(commentItems,toSection: verticalSection)
        
        dataSource?.apply(snapshot)
    }
}

//MARK: - Extension Gesture
extension DetailPostViewController {
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

    @objc
    func keyboardWillShow(_ notification: Notification) {
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

    @objc
    func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.commentInputView.snp.updateConstraints {
                $0.bottom.equalToSuperview().inset(0)
            }
            self.view.layoutIfNeeded()
        }
    }
}
