//
//  BaseView.swift
//  MemoProject
//
//  Created by CHOI on 2022/08/31.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureUI() {
        self.backgroundColor = .black
    }
    
    func setConstraints() { }
}
