//
//  BankActionView.swift
//  MoneyMate
//
//  Created by Luboslav  Ivanov on 3.10.20.
//  Copyright © 2020 Luboslav  Ivanov. All rights reserved.
//

import UIKit

@IBDesignable
class BankActionView: UIView, XibLoadable {

    private var actionHander: (() -> Void)?
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var actionButton: UIButton! {
        didSet {
            actionButton.roundCorners(radius: 8)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromNib()
    }
    
    
    @IBAction func actionButtonTapped(_ sender: Any) {
        actionHander?()
    }
    
    func configure(title: String, image: UIImage, action: (() -> Void)? = nil) {
        let resizedImage = image.resize(scaledToWidth: 32)
        actionButton.setImageAllStates(image: resizedImage)
        titleLabel.text = title
        actionHander = action
    }
}
