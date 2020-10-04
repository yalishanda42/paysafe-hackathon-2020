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
    func collectReward(_ quest: QuestData)
}

class QuestDetailsViewController: UIViewController {
    
    weak var delegate: QuestDetailsViewControllerDelegate?
    
    var quest: QuestData? = nil {
        didSet {
            updateInfo()
        }
    }
    
    enum ButtonsConfiguration {
        case acceptAndDismiss
        case noButtons
        case collectReward
    }
    
    var buttonsConfig: ButtonsConfiguration = .noButtons  {
        didSet {
            updateButtons()
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
        updateButtons()
        
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
            switch self.buttonsConfig {
            case .acceptAndDismiss:
                self.delegate?.acceptQuest(quest)
            case .collectReward:
                self.delegate?.collectReward(quest)
            default:
                break
            }
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
        
        if !quest.completionRequirements.isEmpty {
            reqStack.addArrangedSubview(reqStackTitle)
        }
        
        if !quest.rewards.isEmpty {
            rewardsStack.addArrangedSubview(rewardsStackTitle)
        }
        
        quest.completionRequirements
            .map { UILabel.create(from: $0, font: .systemFont(ofSize: 17)) }
            .forEach(reqStack.addArrangedSubview(_:))
        
        quest.rewards
            .map { UILabel.create(from: $0, font: .systemFont(ofSize: 17)) }
            .forEach(rewardsStack.addArrangedSubview(_:))
        
        infoView.isHidden = quest.completionRequirements.isEmpty && quest.rewards.isEmpty
    }
    
    private func updateButtons() {
        guard let left = leftButton, let right = rightButton else { return }
        switch buttonsConfig {
        case .noButtons:
            left.isHidden = true
            right.isHidden = true
        case .acceptAndDismiss:
            left.isHidden = false
            left.setTitle("Ignore", for: .normal)
            left.setTitleColor(.systemRed, for: .normal)
            right.isHidden = false
            right.setTitle("Accept", for: .normal)
            right.setTitleColor(.systemGreen, for: .normal)
        case .collectReward:
            left.isHidden = true
            right.isHidden = false
            right.setTitle("Collect reward!", for: .normal)
            right.setTitleColor(.systemGreen, for: .normal)
        }
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
