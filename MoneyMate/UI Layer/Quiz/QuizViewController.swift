//
//  QuizViewController.swift
//  MoneyMate
//
//  Created by Alexander Ignatov on 3.10.20.
//  Copyright © 2020 Luboslav  Ivanov. All rights reserved.
//

import UIKit

struct Quiz: Codable {
    let questions: [Question]
}

struct Question: Codable {
    let text: String
    let answers: [Answer]
}

struct Answer: Codable, Equatable {
    let text: String
    let isCorrect: Bool
}

class QuizViewController: UIViewController {
    
    var quiz: Quiz = .init(questions: []) {
        didSet {
            tableView?.reloadData()
        }
    }
    
    private(set) var currentQuestion: (index: Int, object: Question)?
    private(set) var currentAnswer: Answer?
    private(set) var allAnswers: [Answer] = []

    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        nextButton.backgroundColor = .green
        nextButton.layer.cornerRadius = 8
        nextButton.setTitleColor(.white, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let q = currentQuestion {
            navigationItem.title = "\(q.index) / \(quiz.questions.count)"
        } else {
            navigationItem.title = "Quiz"
        }
    }
}

extension QuizViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentQuestion?.object.answers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(of: UITableViewCell.self, for: indexPath)
            ?? .init(style: .default, reuseIdentifier: "answerCell")
        
        guard let ans = currentQuestion?.object.answers[indexPath.row] else {
            return cell
        }
        
        cell.imageView?.image = currentAnswer == ans
            ? UIImage(systemName: "checkmark.circle", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
            : UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))
        
        cell.textLabel?.text = ans.text
        return cell
    }
    
    
}

extension QuizViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let q = currentQuestion?.object else { return }
        currentAnswer = q.answers[indexPath.row]
    }
}
