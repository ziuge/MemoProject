//
//  BaseTableViewHeaderView.swift
//  MemoProject
//
//  Created by CHOI on 2022/08/31.
//

import UIKit

class BaseTableViewHeaderView: UITableViewHeaderFooterView {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {}
    
    func setConstraints() {}
}
