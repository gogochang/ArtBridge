//
//  MessageViewModel.swift
//  ArtBridge
//
//  Created by 김창규 on 4/29/24.
//

import UIKit
import RxSwift

final class MessageViewModel {
    var routeInputs = RouteInput()
    
    struct RouteInput {
        var needUpdate = PublishSubject<Bool>()
    }
}
