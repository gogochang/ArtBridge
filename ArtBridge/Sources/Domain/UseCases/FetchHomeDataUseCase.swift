//
//  FetchHomeDataUseCase.swift
//  ArtBridge
//
//  Created by 김창규 on 2/19/25.
//

import Foundation
import RxSwift

struct FetchHomeUseCaseRequestValue {
    let userId: Int
}

protocol FetchHomeUseCase {
    func execute(requestValue: FetchHomeUseCaseRequestValue) -> Observable<HomeData>
}

final class DefaultFetchHomeUseCase: FetchHomeUseCase {
    // MARK: - Properties
    private let homeAPIService: HomeAPIService
    
    // MARK: - Init
    init(homeAPIService: HomeAPIService = DefaultHomeAPIService()) {
        self.homeAPIService = homeAPIService
    }
    
    func execute(requestValue: FetchHomeUseCaseRequestValue) -> Observable<HomeData> {
        return homeAPIService.fetchHome(userId: requestValue.userId)
            .compactMap { result in
                switch result {
                case .success(let result):
                    return result
                case .failure(let alrtMessage):
                    return nil
                }
            }
    }
}
