//
//  Memo.swift
//  MemoProject
//
//  Created by CHOI on 2022/08/31.
//

import Foundation

struct Memo: Hashable {
    let uuid = UUID()
    var title, content: String
    var date: Date
}
