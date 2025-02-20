//
//  HomeAPIService.swift
//  ArtBridge
//
//  Created by 김창규 on 6/19/24.
//

import Foundation
import RxSwift

final class DefaultHomeAPIService: HomeAPIService {
    
    // MARK: - Init
    init() {}
    
    // MARK: - Observable
    func fetchHome(userId: Int) -> Observable<APIResult<HomeData>> {
        return URLSession.shared
            .request(HomeAPI.fetchHome)
            .handleAPIResponse(responseType: HomeData.self)
            .map { response in
                switch response {
                case .success(let data):
                    // API호출과 데이터를 성공적으로 받았을 때 처리합니다.
                    return .success(result: data)
                    
                case .failure(let error):
                    // API호출은 성공이지만 내부적으로 실패했을 때 처리합니다.
                    return .failure(error)
                }
            }
        
    }
}
