//
//  RealmModel.swift
//  MemoProject
//
//  Created by CHOI on 2022/09/01.
//

import Foundation
import RealmSwift

class UserMemo: Object {
    @Persisted var title: String
    @Persisted var content: String?
    @Persisted var date: Date
    @Persisted var pin: Bool
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(title: String, content: String, date: Date, pin: Bool) {
        self.init()
        self.title = title
        self.content = content
        self.date = date
        self.pin = false
    }
    
}
