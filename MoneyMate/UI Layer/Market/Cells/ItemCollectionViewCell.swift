//
//  ItemCollectionViewCell.swift
//  MoneyMate
//
//  Created by Luboslav  Ivanov on 3.10.20.
//  Copyright © 2020 Luboslav  Ivanov. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    @IBOutlet private weak var detailsStackView: UIStackView!
    @IBOutlet private weak var requirementsStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.roundCorners(radius: 8)
    }
    
    func configure(with model: MarketItemModel) {
        
        let imageConfig = UIImage.SymbolConfiguration(weight: .regular)
        let image = UIImage(systemName: model.imageTitle, withConfiguration: imageConfig)
        
        imageView.image = image
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        
        for detail in model.details {
            
            let titleLabel = createLabel(with: detail.title,
                                         font: .systemFont(ofSize: 15, weight: .bold),
                                         alignment: .left)
            let valueLabel = createLabel(with: detail.value,
                                         font: .systemFont(ofSize: 15, weight: .regular),
                                         alignment: .right)
            
            let detailStack = createDetailStackView(left: titleLabel,
                                                    right: valueLabel)
            detailsStackView.addArrangedSubview(detailStack)
        }

        
        guard !model.requirements.isEmpty else {
            return
        }
        
        let titleLabel = createLabel(with: "Requirements",
                                     font: .systemFont(ofSize: 17, weight: .bold),
                                     alignment: .center)
        requirementsStackView.addArrangedSubview(titleLabel)
        
        for requirement in model.requirements {
            let valueLable = createLabel(with: requirement,
                                         font: .systemFont(ofSize: 15),
                                         alignment: .center)
            requirementsStackView.addArrangedSubview(valueLable)
        }
    }
}

private extension ItemCollectionViewCell {
    
    func createLabel(with text: String, font: UIFont, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.numberOfLines = 0
        label.textAlignment = alignment
        return label
    }
    
    func createDetailStackView(left: UIView, right: UIView ) -> UIStackView {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 3
        
        stackView.addArrangedSubview(left)
        stackView.addArrangedSubview(right)
        return stackView
    }
}
