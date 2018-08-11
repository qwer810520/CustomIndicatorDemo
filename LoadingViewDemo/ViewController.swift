//
//  ViewController.swift
//  LoadingViewDemo
//
//  Created by 楷岷 張 on 2018/7/31.
//  Copyright © 2018年 Min. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import NSObject_Rx

class ViewController: UIViewController {
    
    lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("show", for: .normal)
        button.backgroundColor = .orange
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.rx.tap
            .subscribe(onNext: {
                print("ButtonDidPressed")
                IGasLoading.show("載入中...")
//                IGasLoading.show()
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                    IGasLoading.dismiss()
                })
            })
            .disposed(by: rx.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "首頁"
        
        view.addSubview(startButton)
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-100-[startButton]-100-|",
            options: [],
            metrics: nil,
            views: ["startButton": startButton]))
        
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-200-[startButton(40)]",
            options: [],
            metrics: nil,
            views: ["startButton": startButton]))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

