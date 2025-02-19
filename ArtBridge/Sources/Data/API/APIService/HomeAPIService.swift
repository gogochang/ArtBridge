//
//  HomeAPIService.swift
//  ArtBridge
//
//  Created by 김창규 on 2/19/25.
//

import RxSwift

protocol HomeAPIService {
    func fetchHome(userId: Int) -> Observable<APIResult<HomeData>>
}
