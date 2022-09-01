//
//  ActivityViewController.swift
//  MemoProject
//
//  Created by CHOI on 2022/08/31.
//

import UIKit

extension UIViewController {
    public func showActivityViewController(shareTitle: String, shareContent: String) {
        let viewController = UIActivityViewController(activityItems: [shareTitle, shareContent], applicationActivities: nil)
        viewController.excludedActivityTypes = [.assignToContact]
        self.present(viewController, animated: true)
    }
}
