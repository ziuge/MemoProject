//
//  FirstViewController.swift
//  MemoProject
//
//  Created by CHOI on 2022/09/05.
//

import Foundation
import UIKit

class FirstViewController: BaseViewController {
    
    var blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        return view
    }()
    
    var label: UILabel = {
        let view = UILabel()
        view.text = """
        처음 오셨군요!
        환영합니다 :)
        
        당신만의 메모를 작성하고
        관리해보세요!
        """
        view.textColor = .white
        view.font = .systemFont(ofSize: 18, weight: .bold)
        view.numberOfLines = 0
        return view
    }()
    
    var button: UIButton = {
        let view = UIButton()
        view.setTitle("확인", for: .normal)
//        view.addAction(, for: .touchUpInside)
        view.backgroundColor = .systemOrange
        view.layer.cornerRadius = 10
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        UserDefaults.standard.set(true, forKey: "first")
        
    }

    
    override func configure() {
        
        [blackView, label, button].forEach {
            view.addSubview($0)
        }
        
    }
    
    override func setConstraints() {
        blackView.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.height.width.equalTo(260)
        }
        label.snp.makeConstraints { make in
            make.centerX.equalTo(blackView)
            make.leadingMargin.topMargin.equalTo(blackView).offset(20)
            make.trailingMargin.equalTo(blackView).offset(-20)
            make.height.equalTo(190)
            make.width.equalTo(200)
        }
        button.snp.makeConstraints { make in
            make.centerX.equalTo(blackView)
            make.leadingMargin.equalTo(blackView).offset(20)
//            make.topMargin.equalTo(label.snp.bottom).offset(20)
            make.trailingMargin.equalTo(blackView).offset(-20)
            make.bottomMargin.equalTo(blackView).offset(-20)
            
            make.height.equalTo(50)
            
        }
    }
    
    
    
    
}
