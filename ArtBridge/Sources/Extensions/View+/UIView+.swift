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
    
    func addInnerShadow() {
        // 기존 inner shadow 제거
        layer.sublayers?
            .filter { $0.name == "innerShadowLayer" }
            .forEach { $0.removeFromSuperlayer() }

        let innerShadowLayer = CALayer()
        innerShadowLayer.name = "innerShadowLayer" // 레이어 식별을 위한 이름 설정
        innerShadowLayer.frame = bounds
        
        // 기본적인 배경 색상 (투명)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: self.layer.cornerRadius)
        
        let cutoutPath = UIBezierPath(rect: CGRect(x: bounds.minX-5, y: bounds.minY-5, width: bounds.width+10, height: bounds.height+10))
        
        shadowPath.append(cutoutPath)
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = shadowPath.cgPath
        shadowLayer.fillRule = .evenOdd
        
        // 그림자 속성 설정
        shadowLayer.shadowColor = UIColor.white.cgColor
        shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
        shadowLayer.shadowOpacity = 0.3
        shadowLayer.shadowRadius = 1
        
        innerShadowLayer.addSublayer(shadowLayer)
        layer.addSublayer(innerShadowLayer)
    }

}
