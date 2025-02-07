//
//  HomeViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 4/25/24.
//

import UIKit
import RxSwift
import RxDataSources

final class HomeViewController: BaseViewController {
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let viewModel: HomeViewModel
    
    // MARK: - UI
    private var navBar = ArtBridgeNavBar().then {
        $0.leftBtnItem.setImage(UIImage(named: "logo"), for: .normal)
        $0.rightBtnItem.setImage(UIImage(systemName: "bell"), for: .normal)
        $0.searchView.isHidden = false
    }
    
    private var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    private var stackView = UIStackView().then {
        $0.spacing = 32
        $0.axis = .vertical
        $0.alignment = .fill
    }
    
    private let categoryCollectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 24, left: 24, bottom: 0, right: 0)
    
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.id)
        collectionView.register(
            HomeHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HomeHeaderView.id
        )
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: - Init
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initialLayout()
        

        viewModelInputs()
        viewModelOutput()

    }
    
    // MARK: - Methods
    private func viewModelInputs() {
        navBar.rightBtnItem.rx.tap
            .bind(to: viewModel.inputs.showAlarm)
            .disposed(by: disposeBag)
    }
    
    private func viewModelOutput() {
        categoryCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        typealias CategoryDataSource = RxCollectionViewSectionedAnimatedDataSource<CategorySection>
        
        let categoryDataSource = RxCollectionViewSectionedAnimatedDataSource<CategorySection>(
            configureCell: { [weak self] _, collectionView, indexPath, element in
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CategoryCell.id,
                    for: indexPath
                ) as? CategoryCell else {
                    return UICollectionViewCell()
                }
                cell.configure(with: element)
                return cell
            },
            configureSupplementaryView: { [weak self] _, collectionView, kind, indexPath in
                guard kind == UICollectionView.elementKindSectionHeader else {
                    return UICollectionReusableView()
                }
                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: HomeHeaderView.id,
                    for: indexPath
                ) as? HomeHeaderView
                // 추가 설정이 필요하면 여기에
                header?.configure(with: "당신이 사랑하는 클래식 음악")
                return header ?? UICollectionReusableView()
            }
        )
        
        viewModel.outputs.categories
            .debug()
            .map { [CategorySection(items: $0)] }
            .bind(to: categoryCollectionView.rx.items(dataSource: categoryDataSource))
            .disposed(by: disposeBag)
    }
}

// MARK: - Delegate
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        let label = UILabel()
        label.text = viewModel.categories[indexPath.row]
        label.font = .suitR16
        label.sizeToFit()
        
        let width = label.frame.width + 32  // left & right inset (16 * 2)
        
        return CGSize(width: width, height: 40)  // 세로는 고정 40
    }
    
    // Method to set the size for the header view
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        // You can adjust the height here
        return CGSize(width: collectionView.frame.width, height: 24)
    }
}

//MARK: - Layout
extension HomeViewController {
    private func setupViews() {
        view.addSubviews([
            scrollView
        ])
        
        scrollView.addSubview(stackView)  // stackView를 scrollView에 추가
        stackView.addArrangedSubview(navBar)
        stackView.addArrangedSubview(categoryCollectionView)
    }
    
    private func initialLayout() {
        scrollView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        categoryCollectionView.snp.makeConstraints {
            $0.height.equalTo(342)
        }
    }
}

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) ->  [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)?.map { $0.copy() as! UICollectionViewLayoutAttributes }
        var leftMargin: CGFloat = 0.0
        var maxY: CGFloat = -1.0
    
        attributes?.forEach { layoutAttribute in
            guard layoutAttribute.representedElementCategory == .cell else {
                return
            }
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }
        return attributes
    }
}
