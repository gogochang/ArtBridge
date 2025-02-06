//
//  BaseViewController.swift
//  ArtBridge
//
//  Created by 김창규 on 2/6/25.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    // MARK: - Properties
    
    // MARK: - UI
    private let backgroundView = UIImageView()
    
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        initialLayout()
    }
}

// MARK: - Base Functions
extension BaseViewController {
    
}

// MARK: - Layout
extension BaseViewController {
    private func setupViews() {
        view.addSubview(backgroundView)
        
        backgroundView.image = UIImage(named: "bg")
    }
    
    private func initialLayout() {
        backgroundView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
    }
}
