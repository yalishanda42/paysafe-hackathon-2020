//
//  BankTableViewCell.swift
//  MoneyMate
//
//  Created by Luboslav  Ivanov on 3.10.20.
//  Copyright © 2020 Luboslav  Ivanov. All rights reserved.
//

import UIKit

class BankTableViewCell: UITableViewCell {

    enum RounedCorners {
        case all,top, bottom, none
    }
    
    private var roundedCorners: RounedCorners = .none
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var primaryLeftLabel: UILabel!
    @IBOutlet weak var primatyRightLabel: UILabel!
    
    @IBOutlet weak var secondaryLeftLabel: UILabel!
    @IBOutlet weak var secondaryRightLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        primaryLeftLabel.text = nil
        primatyRightLabel.text = nil
        secondaryLeftLabel.text = nil
        secondaryRightLabel.text = nil
        
        innerView.mask = nil
        roundedCorners = .none
        innerView.layer.cornerRadius = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.setSideInsets()
        selectedBackgroundView?.setSideInsets()
        switch roundedCorners {
        case .all: roundAllCorners()
        case .top: roundTopCorners()
        case .bottom: roundBottomCorners()
        case .none:
            innerView.mask = nil
            innerView.layer.cornerRadius = 0
        }
    }
    
    func configure(with model: LoanModel) {
        
        iconImageView?.roundCorners(radius: 8)
        
        if model.isBankLoan {
            iconImageView?.image = UIImage(named: "bank")?.resize(scaledToWidth: 32)
        } else {
            iconImageView?.image = UIImage(named: "money.give")?.resize(scaledToWidth: 32)
        }
        
        let diffs = Calendar.current.dateComponents([.year, .month, .day],
                                                    from: model.startDate, to: model.endDate)
        var title = ""
        if let years = diffs.year, years != 0 {
            title = "\(years) year"
            title = years > 1 ? title + "s" : title
        } else  if let months = diffs.month, months != 0 {
            title = "\(months) month"
            title = months > 1 ? title + "s" : title
        }
 
        primaryLeftLabel.text = "For \(title)"
        primatyRightLabel.text = model.amount.moneyString
        secondaryLeftLabel.text = model.endDate.shortDateFormattedString
        secondaryRightLabel.text = "Rate \(model.rate * 100)%"
    }
    
    func configure(with model: MortageLoanModel) {
        
        iconImageView?.roundCorners(radius: 8)
        let image = UIImage(systemName: "house")
        iconImageView?.image = image?.resize(scaledToWidth: 32)
        
        primaryLeftLabel.text = "For \(model.propertyTitle)"
        primatyRightLabel.text = model.amount.moneyString
        secondaryLeftLabel.text = model.endDate.shortDateFormattedString
        secondaryRightLabel.text = "Rate \(round(model.rate * 100))%"
    }
    
    func roundTopAndBottomCells(_ indexPath: IndexPath, cellCount: Int) {
        let row = indexPath.row
        
        if cellCount == 1 {
            roundedCorners = .all
        } else if row == 0 {
            roundedCorners = .top
        } else if row == (cellCount - 1) {
            roundedCorners = .bottom
        } else {
            roundedCorners = .none
        }
    }
}


#warning("Export in Protecol")
private extension BankTableViewCell {
    func roundAllCorners() {
         innerView.roundCorners(radius: 8)
     }
     
    func roundTopCorners() {
         innerView.roundCorners(corners: [.topLeft, .topRight], radius: 8)
     }
     
    func roundBottomCorners() {
         innerView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 8)
     }
}
