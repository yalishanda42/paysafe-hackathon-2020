//
//  DashboardViewController.swift
//  MoneyMate
//
//  Created by Luboslav  Ivanov on 3.10.20.
//  Copyright © 2020 Luboslav  Ivanov. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var dateLabel: UIButton!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.layer.cornerRadius = 32
        setupTableView()
        moneyLabel.text = "\(GameDataStore.shared.account.money)"
        dateLabel.setTitle(GameDataStore.shared.date.shortDateFormattedString, for: .normal) 
        NotificationCenter.default.addObserver(self, selector: #selector(dataDidChange), name: .dataStoreWasUpdated, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func onTapDebugDate(_ sender: Any) {
        GameDataStore.shared.send(.forwardTimeWith1Day)
    }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DashboardSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(of: DashboardSectionTableViewCell.self, for: indexPath),
              let dashboardSection = DashboardSection(rawValue: indexPath.row)
        else {
            fatalError("TableView could not dequeue MarketSectionTableViewCell or dashbord section is invalid for index path \(indexPath)")
        }
        
        cell.configure(with: dashboardSection)
        cell.onTapItem = { [unowned self] name, isQuest in
            if isQuest {
                let questVC = QuestDetailsViewController.instantiateFromStoryboard()
                questVC.quest = GameDataStore.shared.quests.first { $0.name == name }
                questVC.delegate = self
                self.present(questVC, animated: true)
            } else {
                self.presentItemActionsSheetIfNeeded(forItemWithName: name)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let items = DashboardSection(rawValue: indexPath.row)?.itemViewModels, items.isEmpty {
            return 0.1
        }
        
        return 280
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}


private extension DashboardViewController {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200 // TODO: Check which is perfect
//        tableView.rowHeight = 200// UITableView.automaticDimension
        tableView.register(cellType: DashboardSectionTableViewCell.self)
    }
    
    @objc func dataDidChange() {
        moneyLabel.text = "\(GameDataStore.shared.account.money)"
        dateLabel.setTitle(GameDataStore.shared.date.shortDateFormattedString, for: .normal) 
        tableView.reloadData()
    }
}

extension DashboardViewController: QuestDetailsViewControllerDelegate {
    func acceptQuest(_ quest: QuestData) {
        GameDataStore.shared.send(.acceptQuest(quest))
    }
}
