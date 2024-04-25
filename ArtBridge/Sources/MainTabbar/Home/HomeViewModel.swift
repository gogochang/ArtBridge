//
//  HomeViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 4/25/24.
//

import UIKit
import RxSwift

final class HomeViewModel {
    //MARK: - properties
    var routeInputs = RouteInput()
    
    struct RouteInput {
        var needUpdate = PublishSubject<Bool>()
    }
}
