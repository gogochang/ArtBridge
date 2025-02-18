//
//  Home.swift
//  ArtBridge
//
//  Created by 김창규 on 2/18/25.
//

struct HomeDataModel: Decodable {
    var bannerUrls: [HomeBannerDataModel]
    var popularPosts: [ContentDataModel]
    var popularTutors: [ContentDataModel]
    var news: [ContentDataModel]
    
    enum CodingKeys: String, CodingKey {
        case bannerUrls = "bannerUrls"
        case popularPosts = "popularPosts"
        case popularTutors = "popularTutors"
        case news = "news"
    }
}
