//
//  GameDataStore.swift
//  MoneyMate
//
//  Created by Alexander Ignatov on 3.10.20.
//  Copyright © 2020 Luboslav  Ivanov. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let dataStoreWasUpdated = Notification.Name("dataStoreWasUpdated")
}

extension Notification {
    static let dataStoreWasUpdated = Notification(name: .dataStoreWasUpdated)
}

struct GameDataStore {
    private init() {}
    static var shared = GameDataStore() {
        didSet {
            NotificationCenter.default.post(.dataStoreWasUpdated)
        }
    }
    
    
    var date = Date()
    var account = AccountData()
    var ranking: [AccountData] = []
    var quests: [QuestData] = getDataFromJson()
    var marketSections: [MarketSection] = getDataFromJson()
    
    private static func getDataFromJson<T: Codable>() -> [T] {
        do {
            let decoder = JSONDecoder()
            let resource = String(describing: T.self)
            return try decoder.decodeJsonResource(resource, model: [T].self) ?? []
        } catch {
            fatalError("Json Parser: \(error)")
        }
    }
}

struct AccountData {
    var money = 1000
    var jobs: [JobData] = []
    var ongoingCourses: [CourseData] = []
    var completedCourses: [CourseData] = []
    var items: [ItemData] = []
    var ongoingQuests: [QuestData] = []
    var completedQuests: [QuestData] = []
}

struct JobData: Hashable, Codable, Equatable {
    let name: String
    let description: String
    let income: Income
}

struct CourseData: Codable, Hashable, Equatable {
    let name: String
    let description: String
    let quiz: QuizData
    let enrollmentDate: Date
    let examDate: Date
}

struct QuizData: Codable, Hashable, Equatable {
    let questions: [QuestionData]
}

struct QuestionData: Codable, Hashable, Equatable {
    let text: String
    let answers: [AnswerData]
}

struct AnswerData: Codable, Hashable, Equatable {
    let text: String
    let isCorrect: Bool
}

struct ItemData: Codable, Hashable, Equatable {
    let name: String
    let description: String
    let income: Income?
    let loan: Loan?
    
    var isAsset: Bool {
        income != nil
    }
}

struct QuestData: Codable, Hashable, Equatable {
    let name: String
    let description: String
    let unlockingRequirementsQuests: [String]
    let unlockingRequirementsCourses: [String]
    let completionRequirementsCourses: [String]
    let completionRequirementsJobs: [String]
    let completionRequirementsItems: [String]
    let completionRequirementsCoursesMin: Int
    let completionRequirementsJobsMin: Int
    let completionRequirementsItemsMin: Int
    let completionRequirementsCost: Int
    let rewardMoney: Int
    let rewardItem: [ItemData]
        
    var completionRequirements: [String] {
        completionRequirementsCourses
            + completionRequirementsJobs
            + completionRequirementsItems
    }
    
    var rewards: [String] {
        var result: [String] = []
        
        if rewardMoney > 0 {
            result.append("$\(rewardMoney)")
        }
        
        result += rewardItem.map { $0.name }
        return result
    }
    
    var isCompleted: Bool {
        return Set(completionRequirementsCourses).isSubset(of: GameDataStore.shared.account.completedCourses.map { $0.name })
            && Set(completionRequirementsJobs).isSubset(of: GameDataStore.shared.account.jobs.map { $0.name })
            && Set(completionRequirementsItems).isSubset(of: GameDataStore.shared.account.items.map { $0.name })
            && GameDataStore.shared.account.completedCourses.count >= completionRequirementsCoursesMin
            && GameDataStore.shared.account.jobs.count >= completionRequirementsJobsMin
            && GameDataStore.shared.account.money >= completionRequirementsCost
    }
}

struct Income: Codable, Hashable, Equatable {
    let value: Int
    let regularity: Regularity
}

struct Loan: Codable, Hashable, Equatable {
    let value: Int
    let regularity: Regularity
    let paymentsCount: Int
}

enum Regularity: String, Codable, Hashable, Equatable {
    case daily
    case weekly
    case monthly
    case yearly
    
    var timeInterval: TimeInterval {
        switch self {
        case .daily:
            return 60 * 60 * 24
        case .weekly:
            return Regularity.daily.timeInterval * 7
        case .monthly:
            return Regularity.daily.timeInterval * 31
        case .yearly:
            return Regularity.daily.timeInterval * 365
        }
    }
}
