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
        setupTableView()
        NotificationCenter.default.addObserver(tableView as Any, selector: #selector(tableView.reloadData), name: .dataStoreWasUpdated, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        var size = tableView.contentSize
//        size.height += 350
//        let bounds = CGRect(origin: .zero, size: size)
//        tableView.roundCorners(corners: [.topLeft, .topRight], radius: 32, bounds: bounds)
//    }
    
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
        let row = indexPath.row
        var model = dataSource[row]
        model.isFirstSection = row == 0
        cell.configure(with: model)
        cell.onTapItem = { [unowned self] name in
            self.presentItemActionsSheetIfNeeded(forItemWithName: name)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 374 : 350
    }
}

private extension MarketViewController {
    func setupNavigationBar() {
        title = "Market"
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationItem.prompt = "Market"
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 300
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
