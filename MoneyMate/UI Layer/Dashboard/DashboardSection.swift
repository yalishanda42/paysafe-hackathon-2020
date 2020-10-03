//
//  DashboardSection.swift
//  MoneyMate
//
//  Created by Alexander Ignatov on 3.10.20.
//  Copyright © 2020 Luboslav  Ivanov. All rights reserved.
//

import Foundation

enum DashboardSection: Int, CaseIterable {
    case activeIncome
    case ongoingQuests
    case ongoingCourses
    case availableQuests
    case liabilities
    case completedCourses
    case completedQuests
    
    var title: String {
        switch self {
            case .activeIncome: return "Income"
            case .ongoingQuests: return "Ongoing Quests"
            case .availableQuests: return "Available Quests"
            case .liabilities: return "Liabilities"
            case .ongoingCourses: return "Ongoing Courses"
            case .completedCourses: return "Completed Courses"
            case .completedQuests: return "Completed Quests"
        }
    }
    
    var itemViewModels: [DashboardItemViewModel] {
        switch self {
            case .activeIncome:
                return []
            case .ongoingQuests:
                return []
            case .availableQuests:
                return []
            case .liabilities:
                return []
            case .ongoingCourses:
                return []
            case .completedCourses:
                return []
            case .completedQuests:
                return []
        }
    }
}
