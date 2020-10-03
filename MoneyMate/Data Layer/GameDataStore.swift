//
//  GameDataStore.swift
//  MoneyMate
//
//  Created by Alexander Ignatov on 3.10.20.
//  Copyright © 2020 Luboslav  Ivanov. All rights reserved.
//

import Foundation

struct GameDataStore {
    static var shared = GameDataStore() {
        didSet {
            // TODO: post notification in notification center
        }
    }
    private init() {
    }
    
    var date = Date()
    var account = AccountData()
    var ranking: [AccountData] = []
    var quests: [QuestData] = []
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

struct JobData: Codable {
    let name: String
    let description: String
    let income: Income
}

struct CourseData: Codable, Equatable {
    let name: String
    let description: String
    let quiz: QuizData
    let enrollmentDate: Date
    let examDate: Date
}

struct QuizData: Codable, Equatable {
    let questions: [QuestionData]
}

struct QuestionData: Codable, Equatable {
    let text: String
    let answers: [AnswerData]
}

struct AnswerData: Codable, Equatable {
    let text: String
    let isCorrect: Bool
}

struct ItemData: Codable {
    let name: String
    let description: String
    let isAsset: Bool
    let income: Income?
    let loan: Loan?
}

struct QuestData: Codable {
    let name: String
    let description: String
    let requirements: [String]
    let rewards: [String]
    // TODO
}

struct Income: Codable {
    let startDate: Date
    let value: Int
    let regularity: Regularity
}

struct Loan: Codable {
    let startDate: Date
    let value: Int
    let regularity: Regularity
    let paymentsCount: Int
}

enum Regularity: String, Codable {
    case daily
    case weekly
    case monthly
    case yearly
}
