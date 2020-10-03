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
    private init() {}
    
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
    var courses: [CourseData] = []
    var items: [ItemData] = []
    var completedQuests: [QuestData] = []
}

struct JobData {
    let name: String
}

struct CourseData {
    let name: String
}

struct ItemData {
    let name: String
}

struct QuestData {
    let name: String
}


