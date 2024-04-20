//
//  UIView+.swift
//  ArtBridge
//
//  Created by 김창규 on 4/20/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
