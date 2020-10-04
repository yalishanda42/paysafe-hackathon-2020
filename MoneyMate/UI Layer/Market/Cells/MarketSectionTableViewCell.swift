//
//  MarketSectionTableViewCell.swift
//  MoneyMate
//
//  Created by Luboslav  Ivanov on 3.10.20.
//  Copyright © 2020 Luboslav  Ivanov. All rights reserved.
//

import UIKit

class MarketSectionTableViewCell: UITableViewCell {
    
    var onTapItem: ((String) -> Void)?
    
    @IBOutlet private weak var titleTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var dataSource: [MarketItemModel]  = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        dataSource = []
        collectionView.reloadData()
    }
    
    func configure(with model: MarketSection) {
        titleLabel.text = model.title.rawValue
        dataSource = model.items
        titleTopConstraint.constant = model.isFirstSection ? 32 : 8
        layoutIfNeeded()
    }
    
    func reload() {
        collectionView.reloadData()
    }
}

private extension MarketSectionTableViewCell {
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: ItemCollectionViewCell.self)
    }
}

extension MarketSectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(of: ItemCollectionViewCell.self, for: indexPath) else {
            fatalError("Market Collection View could not dequeue ItemCollectionViewCell")
        }
        
        cell.configure(with: dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 200, height: 260)
//        return UICollectionViewFlowLayout.automaticSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onTapItem?(dataSource[indexPath.row].title)
    }
}
