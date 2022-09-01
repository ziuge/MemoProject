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
    
    var titleTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .black
        view.text = "title"
        view.isEditable = true
        view.textColor = .white
        view.font = .systemFont(ofSize: 24, weight: .bold)
        view.returnKeyType = .next
        view.isScrollEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = true
        view.sizeToFit()
        return view
    }()
    
    var contentTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .black
        view.text = "content"
        view.isEditable = true
        view.textColor = .white
        view.font = .systemFont(ofSize: 14, weight: .medium)
//        view.isScrollEnabled = false
//        view.translatesAutoresizingMaskIntoConstraints = true
//        view.sizeToFit()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        view.backgroundColor = .black
        titleTextView.becomeFirstResponder()
        
        
        titleTextView.delegate = self
        contentTextView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        setData(data: memo)
    }
    
    func setData(data: Memo) {
        print(#function)
        titleTextView.text = data.title
        contentTextView.text = data.content
    }
    
    override func configure() {
        [titleTextView, contentTextView].forEach {
            view.addSubview($0)
        }
        
        let export = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(exportButtonClicked))
        let done = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonClicked))
        navigationItem.rightBarButtonItems = [done, export]
        navigationController?.navigationBar.tintColor = .systemOrange
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
        showActivityViewController(shareTitle: self.memo.title, shareContent: self.memo.content)
    }
    
    @objc func doneButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension WriteViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            // 32 이하일때는 더 이상 줄어들지 않게하기
            if estimatedSize.height <= 32 {
            } else {
                if constraint.firstAttribute == .height {
                    constraint.constant = estimatedSize.height
                }
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == titleTextView && text == "\n" {
            contentTextView.becomeFirstResponder()
        }
        return true
    }
    
}
