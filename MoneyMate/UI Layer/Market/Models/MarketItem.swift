//
//  MarketItem.swift
//  MoneyMate
//
//  Created by Luboslav  Ivanov on 3.10.20.
//  Copyright © 2020 Luboslav  Ivanov. All rights reserved.
//

import Foundation


struct MarketItemModel: Codable {
    var title: String
    var imageTitle: String
    var description: String
    var requirements: [RequirementModel]
}

struct RequirementModel: Codable {
    var title: String
    var value: String
}
