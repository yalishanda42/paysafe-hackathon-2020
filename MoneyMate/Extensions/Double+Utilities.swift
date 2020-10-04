//
//  Double+Utilities.swift
//  MoneyMate
//
//  Created by Luboslav  Ivanov on 4.10.20.
//  Copyright © 2020 Luboslav  Ivanov. All rights reserved.
//

import Foundation

extension Double {
    var moneyString: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.decimalSeparator = ","
        formatter.currencySymbol = "$"
        return formatter.string(from: (self as NSNumber))
    }
}
