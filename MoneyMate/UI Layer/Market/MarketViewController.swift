//
//  MarketViewController.swift
//  MoneyMate
//
//  Created by Luboslav  Ivanov on 3.10.20.
//  Copyright © 2020 Luboslav  Ivanov. All rights reserved.
//

import UIKit

class MarketViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    private lazy var dataSource: [MarketSection] = {
        return getDataFromJson() ?? []
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
}

private extension MarketViewController {
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: ItemCollectionViewCell.self)
    }
    
    func getDataFromJson() -> [MarketSection]? {
        do {
            let decoder = JSONDecoder()
            let recource = "MarketDataSource"
            return try decoder.decodeJsonResource(recource, model: [MarketSection].self)
        } catch {
         fatalError("Market Json Parser: \(error)")
        }
    }
}

extension MarketViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(of: ItemCollectionViewCell.self, for: indexPath) else {
            fatalError("Market Collection View could not dequeue ItemCollectionViewCell")
        }
     
        
        return cell
    }
}
