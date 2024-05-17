//
//  DetailTutorViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 5/17/24.
//

import UIKit
import RxSwift

final class DetailTutorViewController: UIViewController {
    //MARK: - Properties
    private let viewModel: DetailTutorViewModel
    private let disposeBag: DisposeBag = DisposeBag()
    
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
        self.view.backgroundColor = .white
    }
}
