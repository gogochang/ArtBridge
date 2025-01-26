//
//  NoticeComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 1/25/25.
//

import UIKit

final class NoticeComponent {
    var scene: (VC: NoticeViewController, VM: NoticeViewModel) {
        let viewModel = self.viewModel
        return (VC: NoticeViewController(viewModel: viewModel), VM: viewModel)
    }
    
    var viewModel: NoticeViewModel = .init()
    
    func detailNoticeComponent(postID: Int) -> DetailNoticeComponent {
        return DetailNoticeComponent()
    }
}
