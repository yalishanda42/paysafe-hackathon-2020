//
//  DashboardItemViewModel.swift
//  MoneyMate
//
//  Created by Alexander Ignatov on 3.10.20.
//  Copyright © 2020 Luboslav  Ivanov. All rights reserved.
//

import Foundation

struct DashboardItemViewModel {
    let title: String
    let description: String
    let isAsset: Bool
    let systemImageTitle: String
    let progress: Float? // in 0...1
    let descriptions: [String]
    let isQuest: Bool
}
