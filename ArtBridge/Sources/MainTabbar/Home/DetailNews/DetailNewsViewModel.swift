//
//  DetailNewsViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 5/21/24.
//

import Foundation
import RxSwift

final class DetailNewsViewModel {
    private var disposeBag = DisposeBag()
    var inputs = Input()
    var outputs = Output()
    var routes = Route()
    
    init(newsID: Int,
         newsAPIServie: NewsAPIService = NewsAPIService()
    ) {
        newsAPIServie.fetchDetailNews(newsID: newsID)
            .subscribe(onNext: { [weak self] newsData in
                self?.outputs.newsData.onNext(newsData)
            }, onError: { error in
                print("Error: \(error.localizedDescription)")
            }).disposed(by: disposeBag)
        
        inputs.backward
            .bind(to: routes.bacward)
            .disposed(by: disposeBag)
    }
    
    struct Input {
        var backward = PublishSubject<Void>()
    }
    
    struct Output {
        var newsData = ReplaySubject<DetailNewsDataModel>.create(bufferSize: 1)
    }
    
    struct Route {
        var bacward = PublishSubject<Void>()
    }
}
