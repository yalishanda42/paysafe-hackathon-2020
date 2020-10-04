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
            .init(title: "Price", value: "\(data.cost)"),
            .init(title: "Duration", value: "\(data.durationInDays) days")
        ]
        self.requirements = []
    }
    
    init(with data: JobData) {
        self.title = data.name
        self.imageTitle = "briefcase"
        self.description = data.description
        self.details = [
            .init(title: "Salary", value: "\(data.income.value) / \(data.income.regularity.rawValue)"),
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
            .init(title: "Buy Now:", value: "\(data.cost)"),
        ]
        if let loan = data.loan {
            self.details.append(.init(title: "Bank Loan", value: "\(loan.value) / \(loan.regularity.rawValue)"))
        }
        self.requirements = []
    }
}
