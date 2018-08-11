//
//  IGasIndicator.swift
//  LoadingViewDemo
//
//  Created by 楷岷 張 on 2018/7/31.
//  Copyright © 2018年 Min. All rights reserved.
//

import UIKit

class IGasIndicatorView: UIView {
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("IGasIndicatorView", #function)
    }
    
    // MARK: - private Method
    
    private func setUserInterface() {
        
        setAutLayout()
        updateConstraints()
        
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        
        UIApplication.shared.keyWindow?.addSubview(self)
        print("IGasIndicatorView addSubView")
    }
    
    private func setAutLayout() {
        self.addSubview(backgroundView)
        backgroundView.addSubviews([indicator, titleLabel])
        
        let views: [String: Any] = ["backgroundView": backgroundView, "indicator": indicator, "titleLabel": titleLabel]
        
        NSLayoutConstraint(item: backgroundView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: backgroundView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-(>=70)-[backgroundView]-(>=70)-|",
            options: [],
            metrics: nil,
            views: views))
        
        backgroundView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-12-[indicator(50)]-15-[titleLabel]-15-|",
            options: [],
            metrics: nil,
            views: views))
        
        backgroundView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-12-[indicator(50)]-12-|",
            options: [],
            metrics: nil,
            views: views))
        
        NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: backgroundView, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
    }
    
    // MARK: - init Element
    
     lazy private var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.borderWidth = 1.5
        view.layer.borderColor = LoadingStyle.yellow.cgColor
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    lazy private var indicator: IndicatorView = {
        return IndicatorView()
    }()
    
    // MARK: - show indicator method
    
    func show(_ title: String?) {
        print("IGasIndicatorView", #function)
        titleLabel.text = title == nil ? "載入中..." : title
        setUserInterface()
        indicator.startAnimation()
    }
    
    func dismiss() {
        print("IGasIndicatorView", #function)
        self.removeFromSuperview()
        indicator.stopAnimation()
    }
}
