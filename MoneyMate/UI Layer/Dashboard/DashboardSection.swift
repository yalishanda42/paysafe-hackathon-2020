//
//  DashboardSection.swift
//  MoneyMate
//
//  Created by Alexander Ignatov on 3.10.20.
//  Copyright © 2020 Luboslav  Ivanov. All rights reserved.
//

import Foundation

enum DashboardSection: Int, CaseIterable {
    case jobAndAssets
    case ongoingQuests
    case availableQuests
    case liabilities
    case courses
    
    var title: String {
        switch self {
            case .jobAndAssets: return "Jobs and Assets"
            case .ongoingQuests: return "Ongoing Quests"
            case .availableQuests: return "Available Quests"
            case .liabilities: return "Liabilities"
            case .courses: return "Courses"
        }
    }
}
