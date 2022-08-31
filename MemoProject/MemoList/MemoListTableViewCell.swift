//
//  MemoListTableViewCell.swift
//  MemoProject
//
//  Created by CHOI on 2022/08/31.
//

import UIKit

class MemoListTableViewCell: BaseTableViewCell {
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "hello"
        view.textColor = .white
        view.font = .systemFont(ofSize: 16, weight: .heavy)
        return view
    }()
    
    let contentLabel: UILabel = {
        let view = UILabel()
        view.text = "220831   content"
        view.textAlignment = .left
        view.textColor = .white
        view.font = .systemFont(ofSize: 13, weight: .light)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        backgroundColor = .darkGray
        [titleLabel, contentLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leadingMargin.topMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.topMargin.equalTo(titleLabel.snp.bottom).offset(16)
            make.trailingMargin.equalTo(-20)
        }
    }
}
