//
//  ContentListViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 5/10/24.
//

import Foundation
import RxSwift

final class ContentListViewModel {
    private var disposeBag = DisposeBag()
    var routeInputs = RouteInput()
    var routes = Route()
    var inputs = Input()
    var outputs = Output()
    
    init(
        listType: HeaderType,
        postAPIService: PostAPIService = PostAPIService()
    ) {
        postAPIService.fetchPopularPostList(listType: listType)
            .subscribe(onNext: { [weak self] postData in
                self?.outputs.postListData.onNext(postData)
            }, onError: { error in
                print("Error: \(error.localizedDescription)")
            }).disposed(by: disposeBag)
        
        routeInputs.needUpdate
            .bind { _ in
                print("PopulartPostListViewModel: needUdpate is Called")
            }.disposed(by: disposeBag)
        
        inputs.backward
            .bind(to: routes.backward)
            .disposed(by: disposeBag)
        
        inputs.showDetailPost
            .bind(to: routes.detailPost)
            .disposed(by: disposeBag)
    }
    
    struct RouteInput {
        var needUpdate = PublishSubject<Bool>()
    }
    
    struct Input {
        var backward = PublishSubject<Void>()
        var showDetailPost = PublishSubject<Void>()
    }
    
    struct Output {
        var postListData = PublishSubject<[ContentDataModel]>()
    }
    
    struct Route {
        var backward = PublishSubject<Void>()
        var detailPost = PublishSubject<Void>()
    }
}
