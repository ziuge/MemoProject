//
//  FolderMemoViewController.swift
//  MemoProject
//
//  Created by CHOI on 2022/10/22.
//

import UIKit

class FolderMemoViewController: UICollectionViewController {
    
    var list: [Memo] = []
    
    let viewModel = MemoViewModel()
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, Memo>!
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Memo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureDataSource()
        bindData()
    }
    
    func bindData() {
        viewModel.memoList.bind { title in
            self.list.append(Memo(title: title, content: "", date: Date()))
        }
    }
    
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let item = list[indexPath.item]
//        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
//
//        return cell
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return list.count
//    }

}

extension FolderMemoViewController {
    private func configureHierarchy() {
        collectionView.collectionViewLayout = createLayout()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Memo> { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            
            content.text = itemIdentifier.title
            content.textProperties.color = .blue
            
            content.secondaryText = "\(itemIdentifier.content)"
            content.prefersSideBySideTextAndSecondaryText = true
            content.textToSecondaryTextHorizontalPadding = 20
            
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
}
