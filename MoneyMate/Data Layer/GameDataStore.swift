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
    
    var marketSections: [MarketSection] {
        return [
            .init(with: courses),
            .init(with: jobs),
            .init(with: items),
        ]
    }
    
    // MARK: - DATA STORE
    
    var date = Date()
    var account = AccountData()
    var ranking: [AccountData] = []
    var quests: [QuestData] = getDataFromJson()
    // -- marketplace --
    var courses: [CourseData] = getDataFromJson()
    var jobs: [JobData] = getDataFromJson()
    var items: [ItemData] = getDataFromJson()
    // -----------------
    
    
    // MARK: - ACTIONS
    
    enum Action {
        case acceptQuest(QuestData)
        case accomplishQuest(QuestData)
        
        case enrollForCourse(CourseData)
        case takeExam(CourseData)
        case passCourse(CourseData)
        
        case startJob(JobData)
        case leaveJob(JobData)
        
        case buyItem(ItemData)
        case loanItem(ItemData)
        case lendItem(ItemData)
        case stopLendingItem(ItemData)
        case sendItem(ItemData)
        
        // DEBUG
        case forwardTimeWith1Day
        // =====
        
        var sheetActionText: String {
            switch self {
                case .enrollForCourse: return "Sign Up"
                case .takeExam: return "Take Exam"
                case .startJob: return "Star Job"
                case .leaveJob: return "Leave Job"
                case .buyItem: return "Buy"
                case .loanItem: return "Bank Loan"
                case .lendItem: return "Lend"
                case .stopLendingItem: return "Stop Lending"
                case .sendItem: return "Send"
                default: return ""
            }
        }
    }
    
    func sheetActionsForModel(withName name: String) -> [Action] {
        var result: [Action] = []
        
        if let course = courses.first(where: { $0.name == name }) {
            if !(account.ongoingCourses + account.completedCourses).contains(course) {
                result.append(.enrollForCourse(course))
            } else if account.ongoingCourses.contains(course) {
                // TODO: ?? How to understand when it is exam time?
                result.append(.takeExam(course))
            }
        } else if let job = jobs.first(where: { $0.name == name }) {
            if account.jobs.contains(job) {
                result.append(.leaveJob(job))
            } else {
                result.append(.startJob(job))
            }
        } else if let item = items.first(where: { $0.name == name }) {
            if !account.items.contains(item) {
                result.append(.buyItem(item))
                if item.loan != nil {
                    result.append(.loanItem(item))
                }
            } else {
                // TODO: Understand when the user lends an item
                result.append(.sendItem(item))
            }
        }
        
        return result
    }
    
    mutating func send(_ event: Action) {
        switch event {
        case .acceptQuest(let quest):
            account.ongoingQuests.append(quest)
        case .accomplishQuest(let quest):
            account.ongoingQuests.removeAll { $0 == quest }
            account.completedQuests.append(quest)
            account.money -= quest.completionRequirementsCost
        case .enrollForCourse(let course):
            if account.money > course.cost {
                account.ongoingCourses.append(course)
                account.money -= course.cost
            }
            // TODO: save time
        case .takeExam(_):
            break
        case .passCourse(let course):
            account.ongoingCourses.removeAll { $0 == course }
            account.completedCourses.append(course)
        case .startJob(let job):
            account.jobs.append(job)
            // TODO: save time
        case .leaveJob(let job):
            account.jobs.removeAll { $0 == job }
        case .buyItem(let item):
            if account.money > item.cost{
                account.items.append(item)
                account.money -= item.cost
                // TODO: save time
            }
        case .loanItem(let item):
            break // TODO: loan
        case .lendItem(let item):
            break // TODO: lend
        case .stopLendingItem(let item):
            break // TODO: stop lending
        case .sendItem(let item):
            break // TODO: send to another player
        case .forwardTimeWith1Day:
            date = date.addingTimeInterval(60*60*24)
            dateTriggers()
        }
    }
    
    mutating private func dateTriggers() {
        // TODO: pay loans, earn salaries
    }
    
    // MARK: - HELPERS
    
    private static func getDataFromJson<T: Codable>() -> [T] {
        do {
            let decoder = JSONDecoder()
            let resource = String(describing: T.self)
            let result = try decoder.decodeJsonResource(resource, model: [T].self) ?? []
            return result
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

protocol Nameable {
    var name: String { get }
}

struct JobData: Hashable, Codable, Equatable, Nameable {
    let name: String
    let description: String
    let income: Income
    let requiredCourses: [String]
}

struct CourseData: Codable, Hashable, Equatable, Nameable {
    let name: String
    let description: String
    let cost: Int
    let quiz: QuizData
    let durationInDays: Int
    // let enrollmentDate: Date
    // let examDate: Date
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

struct ItemData: Codable, Hashable, Equatable, Nameable {
    let name: String
    let description: String
    let cost: Int
    let income: Income?
    let loan: Loan?
    
    var isAsset: Bool {
        income != nil
    }
}

struct QuestData: Codable, Hashable, Equatable, Nameable {
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
