//
//  ViewModel.swift
//  MemoProject
//
//  Created by CHOI on 2022/10/27.
//

import Foundation

class MemoViewModel {
    var memoList: CObservable<String> = CObservable("100")
    var folderList: CObservable<[MemoFolder]> = CObservable([MemoFolder(name: "", memos: [Memo(title: "", content: "", date: Date())])])
    
    func reloadMemo(title: String) {
        memoList.value = title
    }
    
    func loadFolder(folder: [MemoFolder]) {
        folderList.value = folder
    }
}
