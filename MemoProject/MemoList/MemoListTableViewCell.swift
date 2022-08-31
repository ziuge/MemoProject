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
        view.font = .systemFont(ofSize: 16, weight: .bold)
        return view
    }()
    
    let contentLabel: UILabel = {
        let view = UILabel()
        view.text = "220831   content"
        view.textAlignment = .left
        view.textColor = .white
        view.font = .systemFont(ofSize: 12, weight: .light)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd. a hh:mm"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
    
    func setData(data: Memo) {
        let date = formatter.string(from: data.date)
        
        titleLabel.text = data.title
        contentLabel.text = "\(date)   \(data.content)"
    }
    
    override func configure() {
        backgroundColor = .darkGray
        [titleLabel, contentLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        let spacing = 12
        
        titleLabel.snp.makeConstraints { make in
            make.leadingMargin.topMargin.equalTo(spacing)
            make.trailingMargin.equalTo(-spacing)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.topMargin.equalTo(titleLabel.snp.bottom).offset(spacing)
            make.trailingMargin.equalTo(titleLabel.snp.trailing)
        }
    }
}