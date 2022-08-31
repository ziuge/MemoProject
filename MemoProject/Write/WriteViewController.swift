//
//  WriteViewController.swift
//  MemoProject
//
//  Created by CHOI on 2022/08/31.
//

import Foundation
import UIKit

class WriteViewController: BaseViewController {
    
    var memo: Memo = Memo(title: "", content: "", date: Date())
    
    var titleTextField: UITextField = {
        let view = UITextField()
        view.backgroundColor = .black
        view.text = "title"
        view.textColor = .white
        view.font = .systemFont(ofSize: 24, weight: .bold)
        return view
    }()
    
    var contentTextField: UITextField = {
        let view = UITextField()
        view.text = "content"
        view.textColor = .white
        view.font = .systemFont(ofSize: 14, weight: .medium)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        titleTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func setData(data: Memo) {
        titleTextField.text = data.title
        contentTextField.text = data.content
    }
    
    override func configure() {
        view.addSubview(titleTextField)
        view.addSubview(contentTextField)
        
        let export = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(exportButtonClicked))
        let done = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonClicked))
        navigationItem.rightBarButtonItems = [done, export]
        navigationController?.navigationBar.tintColor = .systemOrange
    }
    
    override func setConstraints() {
        let spacing = 20
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leadingMargin.equalTo(view.safeAreaLayoutGuide).offset(spacing)
            make.trailingMargin.equalTo(view.safeAreaLayoutGuide).offset(-spacing)
        }
        
        contentTextField.snp.makeConstraints { make in
            make.leading.equalTo(titleTextField)
            make.topMargin.equalTo(titleTextField.snp.bottom).offset(spacing)
            make.trailingMargin.equalTo(view.safeAreaLayoutGuide).offset(-spacing)
        }
    }
    
    @objc func exportButtonClicked() {
        showActivityViewController(shareText: self.memo.title)
    }
    
    @objc func doneButtonClicked() {
        dismiss(animated: true)
    }
    
}
