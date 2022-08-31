//
//  BaseViewController.swift
//  MemoProject
//
//  Created by CHOI on 2022/08/31.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setConstraints()
    }
    
    func configure() { }
    
    func setConstraints() { }
    
}
