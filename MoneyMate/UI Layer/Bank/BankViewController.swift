//
//  BankViewController.swift
//  MoneyMate
//
//  Created by Luboslav  Ivanov on 3.10.20.
//  Copyright © 2020 Luboslav  Ivanov. All rights reserved.
//

import UIKit

struct LoanModel {
    var amount: Double
    var startDate: Date
    var endDate: Date
    var rate: Double
    var isBankLoan: Bool
}

struct MortageLoanModel {
    var amount: Double
    var startDate: Date
    var endDate: Date
    var propertyTitle: String
    var rate: Double
}

struct BankDataSource {
    var balance: Double
    var personalLoans: [LoanModel] = []
    var mortageLoans: [MortageLoanModel] = []
    var deposits: [LoanModel] = []
}

class BankViewController: UIViewController {
    
    enum BankSection: Int, CaseIterable {
        case deposits = 0
        case mortageLoads
        case personalLoans
        
        var sectionTitle: String {
            switch self {
            case .deposits: return "Deposits"
            case .mortageLoads: return "Mortage Loans"
            case .personalLoans: return "Personal Loans"
            }
        }
    }
    
    @IBOutlet private weak var availableBalanceLabel: UILabel!
    @IBOutlet private weak var bankActionsStackView: UIStackView!
    @IBOutlet private weak var tableView: UITableView!
    
    private var dataSource: BankDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let deposit = LoanModel(amount: 300,
                                startDate: Date(),
                                endDate: Date().dateByAdding(5, to: .year)!, rate: 0.02, isBankLoan: true)
        
        let mortage = MortageLoanModel(amount: 100000,
                                       startDate: Date(),
                                       endDate: Date().dateByAdding(10, to: .year)!,
                                       propertyTitle: "House" , rate: 0.07)
        
        let personal = LoanModel(amount: 3000,
                                startDate: Date(),
                                endDate: Date().dateByAdding(5, to: .year)!, rate: 0.10, isBankLoan: false)
        
        
        dataSource = BankDataSource(balance: Double(GameDataStore.shared.account.money),
                                    personalLoans: [personal,personal,personal],
                                    mortageLoans: [mortage,mortage,mortage,mortage],
                                    deposits: [deposit, deposit
                                        
        ])
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateBalance), name: .dataStoreWasUpdated, object: nil)
        
        setupUI()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func updateBalance() {
        availableBalanceLabel.text = Double(GameDataStore.shared.account.money).moneyString
    }
}

private extension BankViewController {
    func setupUI() {
        setupNavigationBar()
        setupBankActions()
        setupTableView()
        
        availableBalanceLabel.text = dataSource.balance.moneyString
    }
    
    func setupNavigationBar() {
        navigationController?.backgroundColor()
    }
    
    func setupTableView() {
        tableView.register(cellType: BankTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    func setupBankActions() {
        let sendAction = BankActionView()
        let sendImage = UIImage(named: "money")!
        sendAction.configure(title: "Send", image: sendImage)
        
        let requestAction = BankActionView()
        let requestImage = UIImage(named: "money.envelop")!
        requestAction.configure(title: "Request", image: requestImage)
        
        let historyAction = BankActionView()
        let historyImage = UIImage(named: "money.time")!
        historyAction.configure(title: "History", image: historyImage)
        
        let getLoanAction = BankActionView()
        let loanImage = UIImage(named: "money.give")!
        getLoanAction.configure(title: "Loan", image: loanImage)
        
        bankActionsStackView.addArrangedSubview(sendAction)
        bankActionsStackView.addArrangedSubview(requestAction)
        bankActionsStackView.addArrangedSubview(historyAction)
        bankActionsStackView.addArrangedSubview(getLoanAction)
    }
}

extension BankViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionsType = BankSection(rawValue: section) else  {
            return 0
        }
        
        switch sectionsType {
        case .deposits: return dataSource.deposits.count
        case .personalLoans: return dataSource.personalLoans.count
        case .mortageLoads: return dataSource.mortageLoans.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(of: BankTableViewCell.self, for: indexPath) else {
            fatalError("BankTableView could not dequeue BankTableViewCell")
        }
        
        guard let sectionsType = BankSection(rawValue: indexPath.section) else {
            fatalError("BankTableView could not get SectionType")
        }
        
        let row = indexPath.row
        switch sectionsType {
        case .deposits:
            let deposits = dataSource.deposits
            cell.configure(with: deposits[row])
            cell.roundTopAndBottomCells(indexPath, cellCount: deposits.count)
        case .mortageLoads:
            let mortageLoans = dataSource.mortageLoans
            cell.configure(with: mortageLoans[row])
            cell.roundTopAndBottomCells(indexPath, cellCount: mortageLoans.count)
        case .personalLoans:
            let personalLoans = dataSource.personalLoans
            cell.configure(with: dataSource.personalLoans[row])
            cell.roundTopAndBottomCells(indexPath, cellCount: personalLoans.count)
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionType = BankSection(rawValue: section) else {
            return nil
        }
        
        let sectionView = BankSectionHeaderView(text: sectionType.sectionTitle,
                                                isFirst: section == 0, height: 50)
        sectionView.backgroundColor = .secondarySystemBackground
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 82 : 66
    }
}
