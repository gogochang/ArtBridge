//
//  CGColor+.swift
//  ArtBridge
//
//  Created by 김창규 on 4/26/24.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        UIColor(
            red: CGFloat(drand48()),
            green: CGFloat(drand48()),
            blue: CGFloat(drand48()),
            alpha: 1.0
        )
    }
}
