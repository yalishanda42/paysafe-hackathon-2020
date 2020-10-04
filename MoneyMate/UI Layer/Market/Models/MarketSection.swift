//
//  MarketSection.swift
//  MoneyMate
//
//  Created by Luboslav  Ivanov on 3.10.20.
//  Copyright © 2020 Luboslav  Ivanov. All rights reserved.
//

import Foundation

struct MarketSection: Codable {
    var title: String
    var items: [MarketItemModel]
}

extension MarketSection {
    init(with data: [CourseData]) {
        self.title = "Education"
        self.items = data
            .map(MarketItemModel.init(with:))
    }
    
    init(with data: [JobData]) {
        self.title = "Jobs"
        self.items = data
            .map(MarketItemModel.init(with:))
    }
    
    init(with data: [ItemData]) {
        self.title = "Real Estate"
        self.items = data
            .map(MarketItemModel.init(with:))
    }
}
