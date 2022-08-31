//
//  MemoListViewController.swift
//  MemoProject
//
//  Created by CHOI on 2022/08/31.
//

import UIKit
import SnapKit

class MemoListViewController: BaseViewController {
    
    fileprivate var filtered = [String]()
    fileprivate var filterring = false
    
    var memoList: [String] = ["11", "22", "33"]
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .black
        view.rowHeight = 100
        view.delegate = self
        view.dataSource = self
        view.register(MemoListTableViewCell.self, forCellReuseIdentifier: MemoListTableViewCell.reuseIdentifier)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function, self)
        view.backgroundColor = .systemGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    var total: Int = 0
    
    override func configure() {
        print(#function, self)
        view.addSubview(tableView)
        
        title = "\(total)개의 메모"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: nil)
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
        self.navigationController?.navigationBar.topItem?.searchController?.searchBar.placeholder = "검색"
        
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
            make.topMargin.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension MemoListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "section"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemoListTableViewCell.reuseIdentifier, for: indexPath)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
}

extension MemoListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            self.filtered = self.memoList.filter({ (memo) -> Bool in
                return memo.lowercased().contains(text.lowercased())
            })
            self.filterring = true
        } else {
            self.filterring = false
            self.filtered = [String]()
        }
        self.tableView.reloadData()
    }
}
