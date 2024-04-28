//
//  CommunityViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 4/28/24.
//

import UIKit
import RxSwift

final class CommunityViewModel {
    //MARK: - properties
    var routeInputs = RouteInput()
    
    struct RouteInput {
        var needUpdate = PublishSubject<Bool>()
    }
}
