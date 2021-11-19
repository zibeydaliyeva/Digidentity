//
//  Extension+UIColor.swift
//  Digidentity
//
//  Created by Зибейда Алекперли on 16.11.21.
//

import UIKit

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 100) {
        self.init( red: r / 255, green: g / 255, blue:  b / 255,  alpha: a / 100 )
    }
    
    static var mainTextColor: UIColor {
        return UIColor(r: 33, g: 33, b: 33)
    }
    
    static var navigationBarColor: UIColor {
        return UIColor(r: 85, g: 85, b: 84)
    }
    
    static var grayColor: UIColor {
        return UIColor(r: 181, g: 181, b: 181)
    }
    
}

