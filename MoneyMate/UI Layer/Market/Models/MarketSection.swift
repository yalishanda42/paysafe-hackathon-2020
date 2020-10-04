//
//  MarketSection.swift
//  MoneyMate
//
//  Created by Luboslav  Ivanov on 3.10.20.
//  Copyright © 2020 Luboslav  Ivanov. All rights reserved.
//

import Foundation

struct MarketSection: Codable {
    var title: MarketSectionTitle
    var items: [MarketItemModel]
}

enum MarketSectionTitle: String, Codable {
    case education = "Education"
    case jobs = "Jobs"
    case realEstate = "Real Estate"
}

extension MarketSection {
    init(with data: [CourseData]) {
        self.title = .education
        self.items = data
            .map(MarketItemModel.init(with:))
    }
    
    init(with data: [JobData]) {
        self.title = .jobs
        self.items = data
            .map(MarketItemModel.init(with:))
    }
    
    init(with data: [ItemData]) {
        self.title = .realEstate
        self.items = data
            .map(MarketItemModel.init(with:))
    }
}
