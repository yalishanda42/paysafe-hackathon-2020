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
        setupTableView()
    }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DashboardSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(of: MarketSectionTableViewCell.self, for: indexPath),
              let dashboardSection = DashboardSection(rawValue: indexPath.row)
        else {
            fatalError("TableView could not dequeue MarketSectionTableViewCell or dashbord section is invalid for index path \(indexPath)")
        }
        
        cell.configure(with: dashboardSection)
        return cell
    }
}


private extension DashboardViewController {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200 // TODO: Check which is perfect
        tableView.rowHeight = 300// UITableView.automaticDimension
        tableView.register(cellType: MarketSectionTableViewCell.self)
    }
}
