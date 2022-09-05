//
//  MemoListViewController.swift
//  MemoProject
//
//  Created by CHOI on 2022/08/31.
//

import UIKit
import SnapKit
import RealmSwift

class MemoListViewController: BaseViewController {
    
    fileprivate var filtered = [UserMemo]()
    fileprivate var filterring = false
    
    let localRealm = try! Realm()
    var memoList: Results<UserMemo>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    var pinned = try! Realm().objects(UserMemo.self).filter("pin == true").sorted(byKeyPath: "date") {
        didSet {
            tableView.reloadData()
        }
    }
    var unpinned = try! Realm().objects(UserMemo.self).filter("pin == false").sorted(byKeyPath: "date") {
        didSet {
            tableView.reloadData()
        }
    }
    
    let items = try! Realm().objects(UserMemo.self).sorted(by: ["pin", "date"])
    var sectionNames: [String] = ["고정된 메모", "메모"]
    
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
        
        fetchRealm()
    }
    
    func fetchRealm() {
        memoList = localRealm.objects(UserMemo.self).sorted(byKeyPath: "date", ascending: false)
        pinned = localRealm.objects(UserMemo.self).filter("pin == true")
        unpinned = localRealm.objects(UserMemo.self).filter("pin == false")
        let total = decimalNum(num: self.memoList.count)
        self.title = "\(total)개의 메모"
    }
    
    func decimalNum(num: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(for: num)!
        return result
    }
    
    override func configure() {
        view.addSubview(tableView)
        fetchRealm()
        
        let total = decimalNum(num: self.memoList.count)
        title = "\(total)개의 메모"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.hidesNavigationBarDuringPresentation = false
        search.searchResultsUpdater = self
        search.searchBar.placeholder = "검색"
        search.searchBar.tintColor = .white
        
        self.navigationItem.searchController = search
//        navigationController?.navigationBar.topItem?.searchController?.searchBar.placeholder = "검색"
        
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
        vc.memo = UserMemo(title: "", content: "", date: Date(), pin: false)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// TableView
extension MemoListViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return filterring ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MemoListTableViewHeaderView.reuseIdentifier) as? MemoListTableViewHeaderView else { return UIView() }
        
        header.headerLabel.text = sectionNames[section]
        if filterring {
            header.headerLabel.text = "\(self.filtered.count)개 찾음"
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var nums = 0
        
        if filterring {
            nums = self.filtered.count
        } else {
            nums = section == 0 ? pinned.count : unpinned.count
        }
        
        return nums
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoListTableViewCell.reuseIdentifier, for: indexPath) as? MemoListTableViewCell else { return UITableViewCell() }
        
        
        if self.filterring {
            cell.setData(data: self.filtered[indexPath.row])
        } else {
            if indexPath.section == 0 {
                cell.setData(data: pinned[indexPath.row])
                if pinned[indexPath.row].title == "" && pinned[indexPath.row].content == "" {
                    try! localRealm.write({
                        localRealm.delete(pinned[indexPath.row])
                    })
                    
                    fetchRealm()
                }
            } else {
                cell.setData(data: unpinned[indexPath.row])
                if unpinned[indexPath.row].title == "" && unpinned[indexPath.row].content == "" {
                    try! localRealm.write({
                        localRealm.delete(unpinned[indexPath.row])
                    })
                    fetchRealm()
                }
            }
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = WriteViewController()
        
        if indexPath.section == 0{
            vc.memo = pinned[indexPath.row]
        } else {
            vc.memo = unpinned[indexPath.row]
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let pin = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            
            if self.pinned.count >= 5 && indexPath.section == 1 {
                self.showAlert(title: "메모는 5개까지 고정할 수 있습니다.")
                return
            }
            
            try! self.localRealm.write({
                if indexPath.section == 0 {
                    self.pinned[indexPath.row].pin.toggle()
                } else {
                    self.unpinned[indexPath.row].pin.toggle()
                }

            })
            self.fetchRealm()
        }
        
        let items = indexPath.section == 0 ? self.pinned : self.unpinned
        let image = items[indexPath.row].pin == false ? "pin.fill" : "pin.slash.fill"
        
        pin.image = UIImage(systemName: image)
        pin.backgroundColor = .systemOrange
        
        return UISwipeActionsConfiguration(actions: [pin])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            print("\(indexPath.row) delete")
            try! self.localRealm.write {
                if indexPath.section == 0 {
                    self.localRealm.delete(self.pinned[indexPath.row])
                } else {
                    self.localRealm.delete(self.unpinned[indexPath.row])
                }
            }
            self.fetchRealm()
            tableView.reloadData()
        }
        
        delete.image = UIImage(systemName: "trash.fill")
        delete.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

// Search
extension MemoListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text?.lowercased(), !text.isEmpty {
            self.filtered = self.memoList.filter({ (memo) -> Bool in
                return memo.title.lowercased().contains(text)
            })
            self.filterring = true
            print(text, filtered)
        } else {
            self.filterring = false
            self.filtered = [UserMemo]()
        }
        self.tableView.reloadData()
    }
}
