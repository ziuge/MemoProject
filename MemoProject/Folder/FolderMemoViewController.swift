//
//  FolderMemoViewController.swift
//  MemoProject
//
//  Created by CHOI on 2022/10/22.
//

import UIKit

class FolderMemoViewController: UICollectionViewController {
    
    var list: [Memo] = []
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, Memo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView.collectionViewLayout = layout
        
        cellRegistration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            
            content.text = itemIdentifier.title
            content.textProperties.color = .blue
            
            content.secondaryText = "\(itemIdentifier.content)"
            content.prefersSideBySideTextAndSecondaryText = true
            content.textToSecondaryTextHorizontalPadding = 20
            
            cell.contentConfiguration = content
            
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = list[indexPath.item]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    

}
