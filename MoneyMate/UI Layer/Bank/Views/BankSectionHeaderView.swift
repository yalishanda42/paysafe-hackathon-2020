//
//  BankSectionHeaderView.swift
//  MoneyMate
//
//  Created by Luboslav  Ivanov on 3.10.20.
//  Copyright © 2020 Luboslav  Ivanov. All rights reserved.
//

import UIKit

class BankSectionHeaderView: UIView {
    
    private var titleLabel: UILabel!
    private var isFirst: Bool = false
    
    init(text: String, isFirst: Bool = false, height: CGFloat) {
        let frame = CGRect(x: 0, y: 0,
                           width: UIScreen.main.bounds.width, height: height)
        super.init(frame: frame )
        titleLabel = createLabel(text: text)
        self.isFirst = isFirst
        addSubview(titleLabel)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel = createLabel(text: "Label")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isFirst {
            roundCorners(corners: [.topLeft, .topRight], radius: 32)
        }
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let topConst: CGFloat = isFirst ? 32 : 16
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: topConst),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 16),
            trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16),
            bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
        ])
    }
    
    func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }
}

