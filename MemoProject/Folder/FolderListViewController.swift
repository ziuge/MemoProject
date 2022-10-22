//
//  FolderListViewController.swift
//  MemoProject
//
//  Created by CHOI on 2022/10/22.
//

import UIKit

struct MemoFolder {
    let name: String
    let memos: [Memo]
}

@available(iOS 14.0, *)
class FolderListViewController: UICollectionViewController {
    
    var list = [
        MemoFolder(name: "hihi", memos: [Memo(title: "jjj", content: "jjj", date: Date(timeInterval: -86400, since: Date())), Memo(title: "kkk", content: "kkk", date: Date(timeInterval: -86444, since: Date()))]),
        MemoFolder(name: "iii", memos: [])
    ]
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, MemoFolder>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemIndigo

        cellRegistration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            
            content.text = itemIdentifier.name
            content.textProperties.color = .red
            
            content.secondaryText = "\(itemIdentifier.memos.count)개"
//            content.prefersSideBySideTextAndSecondaryText = false
            
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            
            backgroundConfig.backgroundColor = .lightGray
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeWidth = 1
            backgroundConfig.strokeColor = .cyan
            
            cell.backgroundConfiguration = backgroundConfig
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        <#code#>
    }

    
}
