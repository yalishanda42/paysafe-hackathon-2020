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
    var details: [DetailsModel]
    var requirements: [RequirementModel]
}

struct DetailsModel: Codable {
    var title: String
    var value: String
}

struct RequirementModel: Codable {
    var title: String
    var isFullfilled: Bool
}

extension MarketItemModel {
    init(with data: CourseData) {
        self.title = data.name
        self.imageTitle = "book"
        self.description = data.description
        self.details = [
            .init(title: "Price", value: Double(data.cost).moneyString ?? ""),
            .init(title: "Duration", value: "\(data.durationInDays) days")
        ]
        self.requirements = []
    }
    
    init(with data: JobData) {
        self.title = data.name
        self.imageTitle = "briefcase"
        self.description = data.description
        let moneyString = Double(data.income.value).moneyString ?? ""
        self.details = [
            .init(title: "Salary", value: moneyString + "/\(data.income.regularity.rawValue)"),
        ]
        self.requirements = data.requiredCourses.map { courseName in
            .init(
                title: courseName,
                isFullfilled: GameDataStore.shared.account
                    .completedCourses
                    .map { course in
                        course.name
                    }.contains(courseName)
            )
        }
     }
    
    init(with data: ItemData) {
        self.title = data.name
        self.imageTitle = "house"
        self.description = data.description
        self.details = [
            .init(title: "Buy Now", value: Double(data.cost).moneyString ?? ""),
        ]
        if let loan = data.loan {
            let price = Double(loan.value).moneyString ?? ""
            self.details.append(.init(title: "Bank Loan", value: price + "/\(loan.regularity.rawValue)"))
        }
        
        if let rent = data.rent {
            let price = Double(rent.value).moneyString ?? ""
            self.details.append(.init(title: "Rent", value: price + "/\(rent.regularity.rawValue)"))
        }
        self.requirements = []
    }
}
