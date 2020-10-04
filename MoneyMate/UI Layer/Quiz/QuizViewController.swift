//
//  QuizViewController.swift
//  MoneyMate
//
//  Created by Alexander Ignatov on 3.10.20.
//  Copyright © 2020 Luboslav  Ivanov. All rights reserved.
//

import UIKit

protocol QuizViewControllerDelegate: class {
    func submitResult(success: Bool, course: CourseData)
}

class QuizViewController: UIViewController {
    
    weak var delegate: QuizViewControllerDelegate?
    
    var course: CourseData? {
        didSet {
            if let newQuiz = course?.quiz {
                quiz = newQuiz
            }
        }
    }
    
    private var quiz: QuizData = .init(questions: []) {
        didSet {
            currentQuestion = (index: 0, object: quiz.questions[0])
            tableView?.reloadData()
        }
    }
    
    private var currentQuestion: (index: Int, object: QuestionData)?
    private var currentAnswer: AnswerData?
    private var allAnswers: [AnswerData] = []

    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = false
        tableView.allowsSelection = true
        tableView.tableFooterView = .init()
        
        nextButton.backgroundColor = .systemGreen
        nextButton.layer.cornerRadius = 8
        nextButton.setTitleColor(.white, for: .normal)
        
        if let q = currentQuestion {
            screenTitle.text = "(\(q.index + 1) / \(quiz.questions.count)) \(q.object.text)"
        } else {
            screenTitle.text = "Quiz"
        }
    }
    
    @IBAction func onTapNextButton(_ sender: Any) {
        guard nextButton.title(for: .normal) != "Done" else {
            dismiss(animated: true) { [unowned self] in
                self.delegate?.submitResult(success: self.isSuccess(), course: self.course!)
            }
            return
        }
        
        guard let q = currentQuestion, let ans = currentAnswer else { return }
        
        allAnswers.append(ans)
        currentAnswer = nil
        
        let nextIndex = q.index + 1
        if nextIndex < quiz.questions.count {
            let nextQ = quiz.questions[nextIndex]
            screenTitle.text = "(\(nextIndex + 1) / \(quiz.questions.count)) \(nextQ.text)"
            currentQuestion = (index: nextIndex, object: nextQ)
        } else {
            nextButton.setTitle("Done", for: .normal)
            let correctCount = allAnswers.filter { $0.isCorrect }.count
            let allCount = allAnswers.count
            screenTitle.text = "You \(isSuccess() ? "passed" : "failed") the exam! (you have \(correctCount)/\(allCount) correct answers)"
            currentQuestion = nil
            screenTitle.textColor = isSuccess() ? .systemGreen : .systemRed
        }
        
        tableView.reloadData()
    }
    
    func isSuccess() -> Bool {
        let correctCount = allAnswers.filter { $0.isCorrect }.count
        let allCount = allAnswers.count
        return Double(correctCount) / Double(allCount) >= 0.61
    }
}

extension QuizViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentQuestion?.object.answers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "answerCell")
        
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
        tableView.reloadData()
    }
}
