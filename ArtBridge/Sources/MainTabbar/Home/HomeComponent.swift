//
//  HomeComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 4/25/24.
//

import UIKit

final class HomeComponent {
    lazy var scene: (VC: HomeViewController, VM: HomeViewModel) = (VC: HomeViewController(viewModel: viewModel), VM: viewModel)
    
    lazy var viewModel: HomeViewModel = .init()
    
    var alarmComponent: AlarmComponent {
        return AlarmComponent()
    }
    
    var detailInstrumentComponent: DetailInstrumentComponent {
        return DetailInstrumentComponent()
    }
    
    func popularPostListComponent(listType: HeaderType) -> ContentListComponent {
        return ContentListComponent(listType: listType)
    }
    
    func detailPostComponent(postID: Int) -> DetailPostComponent {
        return DetailPostComponent(postID: postID)
    }
    
    func detailTutorComponent(tutorId: Int) -> DetailTutorComponent {
        return DetailTutorComponent(tutorId: tutorId)
    }
    
    func detailNewsComponent(newsID: Int) -> DetailNewsComponent {
        return DetailNewsComponent(newsID: newsID)
    }
}
