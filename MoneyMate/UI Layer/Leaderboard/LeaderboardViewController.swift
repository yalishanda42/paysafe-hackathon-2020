//
//  LeaderboardViewController.swift
//  MoneyMate
//
//  Created by Alexander Ignatov on 4.10.20.
//  Copyright © 2020 Luboslav  Ivanov. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource: [AccountData] {
        GameDataStore.shared.account.dummyNetWorth = GameDataStore.shared.account.netWorth
        return (GameDataStore.shared.ranking + [GameDataStore.shared.account])
            .sorted { $0.dummyNetWorth > $1.dummyNetWorth }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
    }
}

extension LeaderboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "answerCell")
        
        let acc = dataSource[indexPath.row]
        
        cell.textLabel?.text = "\(indexPath.row + 1). \(acc.names)"
        cell.textLabel?.textColor = acc.names == GameDataStore.shared.account.names ? .systemGreen : .black
        cell.detailTextLabel?.textColor = acc.names == GameDataStore.shared.account.names ? .systemGreen : .black
        
        let worthLabel = UILabel()
        worthLabel.text = "$\(acc.dummyNetWorth)"
        worthLabel.sizeToFit()
        worthLabel.textColor = acc.names == GameDataStore.shared.account.names ? .systemGreen : .lightGray
        cell.accessoryView = worthLabel

        return cell
    }
}
