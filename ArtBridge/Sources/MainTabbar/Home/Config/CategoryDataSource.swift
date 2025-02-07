//
//  CategorySource.swift
//  ArtBridge
//
//  Created by 김창규 on 2/6/25.
//

import Foundation
import RxDataSources

struct CategorySection {
    var items: [CategoryConfig]
    var identity: String
    
    init(items: [CategoryConfig]) {
        self.items = items
        self.identity = items.map { $0.identity }.joined(separator: ",")
    }
}

extension CategorySection: AnimatableSectionModelType {
    typealias Item = CategoryConfig
    
    init(original: CategorySection, items: [Item]) {
        self = original
        self.items = items
    }
}
