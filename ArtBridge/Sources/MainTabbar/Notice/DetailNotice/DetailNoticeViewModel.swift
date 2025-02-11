//
//  DetailNoticeViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 1/26/25.
//

import Foundation
import RxSwift

final class DetailNoticeViewModel: BaseViewModel {
    //MARK: - Properties
    struct Input {
        var backward = PublishSubject<Void>()
    }
    
    struct Output {
        
    }
    
    struct Route {
        var backward = PublishSubject<Void>()
    }
    
    struct RouteInputs {
        
    }
    
    private var disposeBag = DisposeBag()
    var inputs = Input()
    var outputs = Output()
    var routes = Route()
    var routeInputs = RouteInputs()
    
    let detailTitles: [String] = ["기간", "지역", "상금", "링크", "간단설명"]
    let testDetailContent: [String] = ["2025.01.01 ~ 2026.01.01", "서울", "100만원", "https://www.naver.com", "이 공고는 어쩌고 하는 공고이고 테스트 간단 설명 내용입니다."]
    
    //MARK: - Init
    override init() {
        super.init()
        
        inputs.backward
            .bind(to: routes.backward)
            .disposed(by: disposeBag)
    }
    
    //MARK: - Methods
}

