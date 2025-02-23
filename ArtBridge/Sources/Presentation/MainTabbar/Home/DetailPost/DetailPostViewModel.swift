//
//  DetailPostViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 5/12/24.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailPostViewModel {
    private var disposeBag = DisposeBag()
    var inputs = Input()
    var routeInputs = RouteInput()
    var outputs = Output()
    var routes = Route()
    
    init(
        postID: Int,
        postAPIService: PostAPIService = PostAPIService()
    ) {
        postAPIService.fetchDetailPost(postId: postID)
            .subscribe(onNext: { [weak self] postData in
                self?.outputs.postData.onNext(postData)
            }, onError: { error in
                print("Error: \(error.localizedDescription)")
            }).disposed(by: disposeBag)
        
        inputs.backward
            .bind(to: routes.backward)
            .disposed(by: disposeBag)
        
        inputs.showComentBottomSheet
            .bind(to: routes.comentBottomSheet)
            .disposed(by: disposeBag)
    }
    
    struct Input {
        var backward = PublishSubject<Void>()
        var showComentBottomSheet = PublishSubject<Int>()
    }
    
    struct RouteInput {
        var needUpdate = PublishSubject<Bool>()
    }
    
    struct Output {
        var postData = ReplaySubject<DetailPostDataModel>.create(bufferSize: 1)
    }
    
    struct Route {
        var backward = PublishSubject<Void>()
        var comentBottomSheet = PublishSubject<Int>()
    }
}
