//
//  CategoryConfig.swift
//  ArtBridge
//
//  Created by 김창규 on 2/6/25.
//

import Foundation
import RxDataSources

struct CategoryConfig: Equatable, IdentifiableType {
    let title: String
    var identity: String { title }
}
