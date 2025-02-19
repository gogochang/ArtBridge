//
//  HomeAPI.swift
//  ArtBridge
//
//  Created by 김창규 on 2/19/25.
//

import Foundation

enum HomeAPI: BaseAPI {
    case fetchHome
}

extension HomeAPI {
    var path: String {
        switch self {
        case .fetchHome:
            return "https:// ... "
        }
    }
    
    var method: String {
        switch self {
        case .fetchHome:
            return "GET"
        }
    }
    
    // 추가적인 헤더나 파라미터가 필요하면 확장 가능
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
