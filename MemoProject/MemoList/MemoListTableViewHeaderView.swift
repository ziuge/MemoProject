//
//  MemoListTableViewHeaderView.swift
//  MemoProject
//
//  Created by CHOI on 2022/08/31.
//

import UIKit

class MemoListTableViewHeaderView: BaseTableViewHeaderView {
    var headerLabel: UILabel = {
        let view = UILabel()
        view.textColor = Constants.BaseColor.text
        view.font = .systemFont(ofSize: 18, weight: .black)
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        contentView.addSubview(headerLabel)
    }
    
    override func setConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(20)
            make.bottomMargin.equalTo(-8)
        }
    }
}
