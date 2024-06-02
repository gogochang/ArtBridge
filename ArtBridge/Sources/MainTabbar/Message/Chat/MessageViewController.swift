//
//  MessageViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 5/31/24.
//

import UIKit
import RxSwift

//TODO: Model로 이동
struct MessageModel: Hashable {
    let id: Int
    let userId: Int
    let message: String
}

fileprivate enum Section: Hashable {
    case vertical
}

fileprivate enum Item: Hashable {
    case message(MessageModel)
}

final class MessageViewController: UIViewController {
    //MARK: - Properties
    private let disposeBag = DisposeBag()
    private let viewModel: MessageViewModel
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    //MARK: - UI
    private var navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.rightBtnItem.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        $0.title.text = "밤양갱"
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
        $0.backgroundColor = .clear
        $0.register(MessageCollectionViewCell.self, forCellWithReuseIdentifier: MessageCollectionViewCell.id)
    }
    
    private let commentInputView = CommentInputView(placeHolder: "내용을 입력해주세요.")
    
    //MARK: - Init
    init(viewModel: MessageViewModel) {
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

extension MessageViewController {
    private func setupViews() {
        view.addSubviews([
            navBar,
            collectionView,
            commentInputView
        ])
    }
    
    private func initialLayout() {
        self.view.backgroundColor = .systemBrown
        
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
extension MessageViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            let section = self?.dataSource?.sectionIdentifier(for: sectionIndex)
            switch section {
            case .vertical:
                return self?.createVerticalSection()
            default:
                return nil
            }
        },configuration: config)
    }
    
    private func createVerticalSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(48)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(48)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}

extension MessageViewController {
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                switch item {
                case .message(let messageModel):
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: MessageCollectionViewCell.id,
                        for: indexPath
                    ) as? MessageCollectionViewCell
                    
                    cell?.configure(messageModel: messageModel)
                    
                    return cell
                }
            }
        )
    }
    
    private func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        let verticalSection = Section.vertical
        let messageItems = [
            Item.message(MessageModel(id: 0, userId: 0, message: "이 메시지는 상대방이 보낸 메시지가 잘 보여지는지 확인하는 메시지.")),
            Item.message(MessageModel(id: 1, userId: 0, message: "이 메시지는 내용이 길어졌을 때 어떻게 보이는가 확인하고 싶은 메시지이다. 이 메시지는 내용이 길어졌을 때 어떻게 보이는가 확인하고 싶은 메시지이다. 이 메시지는 내용이 길어졌을 때 어떻게 보이는가 확인하고 싶은 메시지이다. 이 메시지는 내용이 길어졌을 때 어떻게 보이는가 확인하고 싶은 메시지이다.")),
            Item.message(MessageModel(id: 2, userId: 1, message: "이 메시지는 내가 보낸 메시지가 잘 보이는지 확인하는 메시지")),
            Item.message(MessageModel(id: 3, userId: 0, message: "그냥 짧은 메시지")),
            ]
        snapshot.appendSections([verticalSection])
        snapshot.appendItems(messageItems, toSection: verticalSection)
        
        dataSource?.apply(snapshot)
    }
}

//MARK: - Extension Gesture
extension MessageViewController {
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
