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
    
    // 버튼 활성화 보더 #DE85B4
    ///#DE85B4
    static var enableBorder: UIColor {
        return UIColor(red: 222/255, green: 133/255, blue: 180/255, alpha: 1.0)
    }
    
    // 버튼 활성화 배경 #F9F5F7
    ///#F9F5F7
    static var enableBg: UIColor {
        return UIColor(red: 249/255, green: 245/255, blue: 247/255, alpha: 1.0)
    }
    
    // 버튼 활성화 폰트 #B5487E
    ///#B5487E
    static var enableText: UIColor {
        return UIColor(red: 181/255, green: 72/255, blue: 126/255, alpha: 1.0)
    }
    
    // 버튼 비활성화 보더 #DCDCDC
    ///#DCDCDC
    static var disableBorder: UIColor {
        return UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
    }
    
    // 버튼 비활성화 폰트, empty, 총 개수 색상 #939597
    ///#939597
    static var disableText: UIColor {
        return UIColor(red: 147/255, green: 149/255, blue: 151/255, alpha: 1.0)
    }
    
    // 텍스트 기본 색상 #404041
    ///#404041
    static var defaultText6: UIColor {
        return UIColor(red: 64/255, green: 64/255, blue: 65/255, alpha: 1.0)
    }
    
    // 회색 (오늘) #828282
    ///#828282
    static var disableText130: UIColor {
        return UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1.0)
    }
    
    ///#EF9ADB
    static var pharmacyTag: UIColor {
        return UIColor(red: 239/255, green: 154/255, blue: 219/255, alpha: 1.0)
    }
    
    ///##F7F7F7
    static var timeTag: UIColor {
        return UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
    }
}
