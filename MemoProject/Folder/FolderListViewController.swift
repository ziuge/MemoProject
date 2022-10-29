//
//  FolderListViewController.swift
//  MemoProject
//
//  Created by CHOI on 2022/10/22.
//

import UIKit

struct MemoFolder: Hashable {
    static func == (lhs: MemoFolder, rhs: MemoFolder) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id = UUID().uuidString
    
    let name: String
    let memos: [Memo]
}

@available(iOS 14.0, *)
class FolderListViewController: UICollectionViewController {
    
    var list = [
        MemoFolder(name: "hihi", memos: [
            Memo(title: "jjj", content: "jjj", date: Date(timeInterval: -86400, since: Date())),
            Memo(title: "kkk", content: "kkk", date: Date(timeInterval: -86444, since: Date())),
            Memo(title: "lll", content: "lll", date: Date())
        ]),
        MemoFolder(name: "iii", memos: [
            Memo(title: "today", content: "toda~~~~y", date: Date())
        ])
    ]
    
    var viewModel = MemoViewModel()
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, MemoFolder>!
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, MemoFolder>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureDataSource()
        
        viewModel.loadFolder(folder: list)
        
        viewModel.folderList.bind { folder in
            var snapshot = NSDiffableDataSourceSnapshot<Int, MemoFolder>()
            snapshot.appendSections([0])
            snapshot.appendItems(self.list)
            self.dataSource.apply(snapshot)
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "FolderMemoViewController") else { return }
        let code = FolderMemoViewController()
//        code.list = self.list[indexPath.item].memos
        print("=====", self.list[indexPath.item].memos)
        
        code.viewModel.reloadMemo(memo: self.list[indexPath.item].memos)
        
        present(vc, animated: true)

    }

}

extension FolderListViewController {
    private func configureHierarchy() {
        collectionView.collectionViewLayout = createLayout()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, MemoFolder> (handler: { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            
            content.text = itemIdentifier.name
            content.textProperties.color = .red
//            content.textProperties.alignment = .center
            
            content.secondaryText = "\(itemIdentifier.memos.count)개"
            content.prefersSideBySideTextAndSecondaryText = true
            content.textToSecondaryTextVerticalPadding = 20
            
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            
            backgroundConfig.backgroundColor = .white
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeWidth = 1
            backgroundConfig.strokeColor = .black
            
            cell.backgroundConfiguration = backgroundConfig
        })
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
}
