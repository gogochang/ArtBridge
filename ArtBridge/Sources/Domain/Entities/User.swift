//
//  User.swift
//  ArtBridge
//
//  Created by 김창규 on 2/18/25.
//

struct User: Decodable, Hashable {
    let id: Int
    let nickname: String
    let profileImgUrl: String
}
