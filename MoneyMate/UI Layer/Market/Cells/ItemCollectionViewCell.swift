//
//  ItemCollectionViewCell.swift
//  MoneyMate
//
//  Created by Luboslav  Ivanov on 3.10.20.
//  Copyright © 2020 Luboslav  Ivanov. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    @IBOutlet private weak var firstRequirementTitleLabel: UILabel!
    @IBOutlet private weak var firstRequirementValueLabel: UILabel!
    
    @IBOutlet private weak var secondRequirementTitleLabel: UILabel!
    @IBOutlet private weak var secondRequirementValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with model: MarketItemModel) {
        imageView.image = UIImage(named: model.imageTitle)
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        
        firstRequirementTitleLabel.text = model.requirements[0].title
        firstRequirementValueLabel.text = model.requirements[0].value
        
        secondRequirementTitleLabel.text = model.requirements[1].title
        secondRequirementValueLabel.text = model.requirements[1].value
    }
}
