//
//  BaseViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 1/25/25.
//

class BaseViewModel {
    
    // MARK: - Init
    init() {
#if DEBUG
        print("[init: ViewModel] \(Self.self)")
#endif
    }
    
    deinit {
#if DEBUG
        print("[deinit: ViewModel] \(Self.self)")
#endif
    }
}
