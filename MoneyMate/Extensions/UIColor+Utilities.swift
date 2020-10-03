//
//  UIColor+Utilities.swift
//  MoneyMate
//
//  Created by Luboslav  Ivanov on 3.10.20.
//  Copyright © 2020 Luboslav  Ivanov. All rights reserved.
//

import UIKit
import Foundation

extension UIColor {
    enum Asset: String {
        case ashGray
        case blueGreen
        case brownSugar
        case darkSeaGreen
        case khaki
        case pineGreen
        case shamrockGreen
    }
    
    static func fromAsset(_ asset: Asset) -> UIColor {
        UIColor(named: asset.rawValue)!
    }
}
