//
//  Content.swift
//  ArtBridge
//
//  Created by 김창규 on 2/18/25.
//

struct ContentDataModel: Decodable, Equatable, Hashable {
    let id: Int
    let userId: Int
    let nickname: String
    let category: String
    let title: String
    let content: String
    let coverURL: String
    var likeCount: Int
}
