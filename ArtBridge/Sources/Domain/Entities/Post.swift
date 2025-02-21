//
//  Post.swift
//  ArtBridge
//
//  Created by 김창규 on 2/18/25.
//

import Foundation

struct DetailPostDataModel: Hashable {
    let post: ContentDataModel
    let author: User
}

struct CreatePostForm {
    var title: String?
    var content: String?
    var category: String?
    var tag: String?
    var image: Data?
}
