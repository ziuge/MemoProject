//
//  Alert.swift
//  MemoProject
//
//  Created by CHOI on 2022/09/05.
//

import UIKit

extension UIViewController {
    
    public func showAlert(title: String, message: String = "", buttonTitle: String = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: buttonTitle, style: .default)

        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    public func showAlertWithCancel(title: String, message: String = "", buttonTitle: String = "OK", completionHandler: @escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: buttonTitle, style: .default, handler: completionHandler)
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alert.addAction(ok)
        alert.addAction(cancel)


        self.present(alert, animated: true)
    }

}

