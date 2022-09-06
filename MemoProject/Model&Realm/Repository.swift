//
//  Repository.swift
//  MemoProject
//
//  Created by CHOI on 2022/09/06.
//

import Foundation
import RealmSwift

class MemoRepository {
    let localRealm = try! Realm()
    
    func saveMemo(memo: UserMemo) {
        let memo = memo
        
        do {
            try localRealm.write({
                localRealm.add(memo)
                print("realm success")
            })
        } catch {
            print(error)
        }
    }
    
    var pinned = try! Realm().objects(UserMemo.self).filter("pin == true").sorted(byKeyPath: "date")

}
