//
//  ViewModel.swift
//  MemoProject
//
//  Created by CHOI on 2022/10/27.
//

import Foundation

class MemoViewModel {
    var memoList: CObservable<[Memo]> = CObservable([Memo(title: "", content: "", date: Date())])
    var folderList: CObservable<[MemoFolder]> = CObservable([MemoFolder(name: "", memos: [Memo(title: "", content: "", date: Date())])])
    
    func reloadMemo(memo: [Memo]) {
        memoList.value = memo
    }
    
    func loadFolder(folder: [MemoFolder]) {
        folderList.value = folder
    }
}
