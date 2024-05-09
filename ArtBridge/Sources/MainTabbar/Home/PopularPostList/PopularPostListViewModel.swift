//
//  PopularPostListViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 5/10/24.
//

import Foundation
import RxSwift

final class PopularPostListViewModel {
    var routes = Route()
    
    struct Route {
        var backward = PublishSubject<Void>()
    }
}
