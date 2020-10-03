//
//  MarketViewController.swift
//  MoneyMate
//
//  Created by Luboslav  Ivanov on 3.10.20.
//  Copyright © 2020 Luboslav  Ivanov. All rights reserved.
//

import UIKit

class MarketViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private lazy var dataSource: [MarketSection] = {
        return getDataFromJson() ?? []
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
}


extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(of: MarketSectionTableViewCell.self, for: indexPath) else {
            fatalError("TableView could not dequeue MarketSectionTableViewCell")
        }
        
        cell.configure(with: dataSource[indexPath.row])
        return cell
    }
}

private extension MarketViewController {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 300 // TODO: Check which is perfect
        tableView.rowHeight = 400// UITableView.automaticDimension
        tableView.register(cellType: MarketSectionTableViewCell.self)
    }
    
    
    func getDataFromJson() -> [MarketSection]? {
        do {
            let decoder = JSONDecoder()
            let recource = "MarketDataSource"
            return try decoder.decodeJsonResource(recource, model: [MarketSection].self)
        } catch {
            fatalError("Market Json Parser: \(error)")
        }
    }
}
