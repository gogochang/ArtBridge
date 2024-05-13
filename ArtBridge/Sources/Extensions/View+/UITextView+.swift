//
//  UITextView+.swift
//  ArtBridge
//
//  Created by 김창규 on 5/14/24.
//

import UIKit

extension UITextView {
    func numberOfLine() -> Int {   
        let size = CGSize(width: frame.width, height: .infinity)
        let estimatedSize = sizeThatFits(size)
        
        return Int(estimatedSize.height / (self.font!.lineHeight))
    }
}
