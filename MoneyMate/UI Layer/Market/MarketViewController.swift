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
    
    private var dataSource: [MarketSection] {
        GameDataStore.shared.marketSections
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.layer.cornerRadius = 32
        setupTableView()
        NotificationCenter.default.addObserver(tableView as Any, selector: #selector(tableView.reloadData), name: .dataStoreWasUpdated, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
        cell.onTapItem = { [unowned self] name in
            self.presentItemActionsSheetIfNeeded(forItemWithName: name)
        }
        return cell
    }
}

private extension MarketViewController {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 300 // TODO: Check which is perfect
        tableView.rowHeight = 350// UITableView.automaticDimension
        tableView.register(cellType: MarketSectionTableViewCell.self)
    }
}

extension UIViewController {
    func presentItemActionsSheetIfNeeded(forItemWithName name: String) {
        let actions = GameDataStore.shared.sheetActionsForModel(withName: name)
        guard !actions.isEmpty else { return }
        
        let alertController = UIAlertController(title: "Available actions", message: nil, preferredStyle: .actionSheet)
        for action in actions {
            alertController.addAction(.init(title: action.sheetActionText, style: .default, handler: { _ in
                GameDataStore.shared.send(action)
                if case .takeExam(let course) = action {
                    let quizVC = QuizViewController.instantiateFromStoryboard()
                    quizVC.course = course
                    quizVC.delegate = self
                    quizVC.modalPresentationStyle = .fullScreen
                    self.present(quizVC, animated: true)
                }
            }))
        }
        alertController.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

extension UIViewController: QuizViewControllerDelegate {
    func submitResult(success: Bool, course: CourseData) {
        if success {
            GameDataStore.shared.send(.passCourse(course))
        }
    }
}
