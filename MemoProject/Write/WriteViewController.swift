//
//  WriteViewController.swift
//  MemoProject
//
//  Created by CHOI on 2022/08/31.
//

import Foundation
import UIKit
import RealmSwift

class WriteViewController: BaseViewController {
    
    let localRealm = try! Realm()
    let repository = MemoRepository()
    
    var memo: UserMemo = UserMemo(title: "", content: "", date: Date(), pin: false)
    
    var titleTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = Constants.BaseColor.background
        view.text = "title"
        view.isEditable = true
        view.textColor = Constants.BaseColor.text
        view.font = .systemFont(ofSize: 24, weight: .bold)
        view.returnKeyType = .next
        view.isScrollEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = true
        view.sizeToFit()
        return view
    }()
    
    var contentTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = Constants.BaseColor.background
        view.text = "content"
        view.isEditable = true
        view.textColor = Constants.BaseColor.text
        view.font = .systemFont(ofSize: 14, weight: .medium)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.BaseColor.background
        titleTextView.becomeFirstResponder()
        
        titleTextView.delegate = self
        contentTextView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setData(data: memo)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        repository.saveMemo(memo: memo)
    }
    
    func setData(data: UserMemo) {
        titleTextView.text = data.title
        contentTextView.text = data.content
    }
    
    override func configure() {
        [titleTextView, contentTextView].forEach {
            view.addSubview($0)
        }
        
        let export = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(exportButtonClicked))
        let done = UIBarButtonItem(title: "??????", style: .plain, target: self, action: #selector(doneButtonClicked))
        navigationItem.rightBarButtonItems = [done, export]
        navigationController?.navigationBar.tintColor = Constants.BaseColor.point
    }
    
    override func setConstraints() {
        
        let spacing = 20
        
        titleTextView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leadingMargin.equalTo(view.safeAreaLayoutGuide).offset(spacing)
            make.trailingMargin.equalTo(view.safeAreaLayoutGuide).offset(-spacing)
            make.bottomMargin.equalTo(contentTextView.snp.top).offset(-spacing)
            make.height.equalTo(45)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.leading.equalTo(titleTextView)
            make.topMargin.equalTo(titleTextView.snp.bottom).offset(spacing)
            make.trailingMargin.equalTo(view.safeAreaLayoutGuide).offset(-spacing)
            make.bottomMargin.equalTo(view.safeAreaLayoutGuide).offset(-spacing)

        }
    }
    
    @objc func exportButtonClicked() {
        showActivityViewController(shareTitle: self.memo.title, shareContent: self.memo.content!)
    }
    
    @objc func doneButtonClicked() {
        repository.saveMemo(memo: memo)
        let vc = MemoListViewController()
        vc.fetchRealm()
        vc.tableView.reloadData()
        self.navigationController?.popViewController(animated: true)
    }
    
//    func saveMemo(memo: UserMemo) {
//        let memo = memo
//
//        do {
//            try localRealm.write({
//                localRealm.add(memo)
//                print("realm success")
//            })
//        } catch {
//            print(error)
//        }
//
//        let vc = MemoListViewController()
//        vc.fetchRealm()
//        vc.tableView.reloadData()
//        self.navigationController?.popViewController(animated: true)
//    }
    
}

extension WriteViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            // 32 ??????????????? ??? ?????? ???????????? ????????????
            if estimatedSize.height <= 32 {
            } else {
                if constraint.firstAttribute == .height {
                    constraint.constant = estimatedSize.height
                }
            }
        }
        
        if textView == self.titleTextView {
            try! localRealm.write({
                memo.title = textView.text
            })
            print("memo", memo.title)
        } else {
            try! localRealm.write({
                memo.content = textView.text
            })
            print("memo", memo.content!)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == titleTextView && text == "\n" {
            contentTextView.becomeFirstResponder()
        }
        return true
    }
    
}
