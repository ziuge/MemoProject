//
//  MemoListViewController.swift
//  MemoProject
//
//  Created by CHOI on 2022/08/31.
//

import UIKit
import SnapKit

class MemoListViewController: BaseViewController {
    
    fileprivate var filtered = [Memo]()
    fileprivate var filterring = false
    
    var memoList: [Memo] = [
        Memo(title: "title", content: "content1", date: Date()),
        Memo(title: "22", content: "content2", date: Date()),
        Memo(title: "33", content: "content3", date: Date()),
        Memo(title: "title", content: "content1", date: Date()),
        Memo(title: "22", content: "content2", date: Date()),
        Memo(title: "title", content: "content1", date: Date()),
        Memo(title: "22", content: "content2", date: Date()),
        Memo(title: "title", content: "content1", date: Date()),
        Memo(title: "22", content: "content2", date: Date())
    ]
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.sectionFooterHeight = 0
        view.sectionHeaderHeight = 50
        view.backgroundColor = .black
        view.rowHeight = 68
        view.delegate = self
        view.dataSource = self
        view.register(MemoListTableViewCell.self, forCellReuseIdentifier: MemoListTableViewCell.reuseIdentifier)
        view.register(MemoListTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: MemoListTableViewHeaderView.reuseIdentifier)
        return view
    }()
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    func decimalNum(num: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(for: num)!
        return result
    }
    
    override func configure() {
        view.addSubview(tableView)
        
        let total = decimalNum(num: self.memoList.count)
        title = "\(total)개의 메모"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        
        self.navigationItem.searchController = search
        navigationController?.navigationBar.topItem?.searchController?.searchBar.placeholder = "검색"
        
        let write = UIBarButtonItem.init(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(writeButtonClicked))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        navigationController?.isToolbarHidden = false
        navigationController?.toolbar.barTintColor = .black
        navigationController?.toolbar.tintColor = .systemOrange

        toolbarItems = [space, write]
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
            make.topMargin.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func writeButtonClicked() {
        let vc = WriteViewController()
        vc.memo = Memo(title: "새로운 메모", content: "", date: Date())
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// TableView
extension MemoListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MemoListTableViewHeaderView.reuseIdentifier) as? MemoListTableViewHeaderView else { return UIView() }
        
        let title = section == 0 ? "고정된 메모" : "메모"

        header.headerLabel.text = title
        
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 1 ? memoList.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoListTableViewCell.reuseIdentifier, for: indexPath) as? MemoListTableViewCell else { return UITableViewCell() }
        
        cell.setData(data: memoList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = WriteViewController()
        vc.memo = memoList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let pin = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            print("\(indexPath.row) pinned")
        }
        
        let image = "pin.fill"
        pin.image = UIImage(systemName: image)
        pin.backgroundColor = .systemOrange
        
        return UISwipeActionsConfiguration(actions: [pin])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            print("\(indexPath.row) delete")
        }
        
        delete.image = UIImage(systemName: "trash.fill")
        delete.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

// Search
extension MemoListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            self.filtered = self.memoList.filter({ (memo) -> Bool in
                return memo.title.lowercased().contains(text.lowercased())
            })
            self.filterring = true
        } else {
            self.filterring = false
            self.filtered = [Memo]()
        }
        self.tableView.reloadData()
    }
}
