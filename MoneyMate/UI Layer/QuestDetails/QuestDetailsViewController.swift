//
//  QuestDetailsViewController.swift
//  MoneyMate
//
//  Created by Alexander Ignatov on 3.10.20.
//  Copyright © 2020 Luboslav  Ivanov. All rights reserved.
//

import UIKit

protocol QuestDetailsViewControllerDelegate: class {
    func acceptQuest(_ quest: QuestData)
}

class QuestDetailsViewController: UIViewController {
    
    weak var delegate: QuestDetailsViewControllerDelegate?
    
    var quest: QuestData? = nil {
        didSet {
            updateInfo()
        }
    }
    
    @IBOutlet weak var questTitle: UILabel!
    @IBOutlet weak var questDescription: UILabel!
    @IBOutlet weak var leftStack: UIStackView! // reqs
    @IBOutlet weak var rightStack: UIStackView! // rewards
    @IBOutlet weak var leftButton: UIButton! // ignore
    @IBOutlet weak var rightButton: UIButton! // accept
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var descriptionContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateInfo()
        
        infoView.layer.cornerRadius = 8
        descriptionContainer.layer.cornerRadius = 8
        
        leftButton.layer.cornerRadius = 8
        leftButton.backgroundColor = .systemRed
        leftButton.setTitleColor(.white, for: .normal)
        
        rightButton.layer.cornerRadius = 8
        rightButton.backgroundColor = UIColor(named: "shamrockGreen")!
        rightButton.setTitleColor(.white, for: .normal)
    }
    
    @IBAction func onTapLeftButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func onTapRightButton(_ sender: Any) {
        dismiss(animated: true) {
            guard let quest = self.quest else { return }
            self.delegate?.acceptQuest(quest)
        }
    }
    
    private func updateInfo() {
        guard let quest = quest else { return }
        
        questTitle?.text = quest.name
        questDescription?.text = quest.description
        
        guard let reqStack = leftStack, let rewardsStack = rightStack else { return }
        
        reqStack.removeAllArrangedSubviews()
        rewardsStack.removeAllArrangedSubviews()
        
        let reqStackTitle = UILabel.create(from: "Requirements", font: .systemFont(ofSize: 17, weight: .bold))
        let rewardsStackTitle = UILabel.create(from: "Rewards", font: .systemFont(ofSize: 17, weight: .bold))
        
        reqStack.addArrangedSubview(reqStackTitle)
        rewardsStack.addArrangedSubview(rewardsStackTitle)
        
        quest.completionRequirements
            .map { UILabel.create(from: $0, font: .systemFont(ofSize: 17)) }
            .forEach(reqStack.addArrangedSubview(_:))
        
        quest.rewards
            .map { UILabel.create(from: $0, font: .systemFont(ofSize: 17)) }
            .forEach(rewardsStack.addArrangedSubview(_:))
    }
}

extension UILabel {
    static func create(from text: String, font: UIFont) -> Self {
        let result = Self()
        result.text = text
        result.font = font
        return result
    }
}

extension UIStackView {
    
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
