//
//  IndicatorView.swift
//  LoadingViewDemo
//
//  Created by 楷岷 張 on 2018/7/31.
//  Copyright © 2018年 Min. All rights reserved.
//

import UIKit

enum animationType {
    case strokeStart
    case strokeEnd
    case rotation
    
    var keyPath: String {
        switch self {
        case .strokeStart:
            return "strokeStart"
        case .strokeEnd:
            return "strokeEnd"
        case .rotation:
            return "rotation"
        }
    }
}

class IndicatorView: UIView {
    
    init() {
        super.init(frame: .zero)
        setUserInterface()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("IndicatorView", #function)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drawCircle()
    }
    
    // MARK: - private Method
    
    private func setUserInterface() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        layer.addSublayer(circleLayer)
    }
    
    private func drawCircle() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)    //計算邊界寬度和高度之間的位置
        let radius = min(bounds.width, bounds.height) / 2 - circleLayer.lineWidth / 2
        
        let startAngle = CGFloat(-Double.pi / 2)    //線條開始位置
        let endAngle = startAngle + CGFloat(Double.pi * 2)
        let path = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        circleLayer.position = center
        circleLayer.path = path.cgPath
    }
    
    func startAnimation() {
        circleLayer.add(strokeEndAnimation, forKey: animationType.strokeEnd.keyPath)
        circleLayer.add(strokeStartAnimation, forKey: animationType.strokeStart.keyPath)
        circleLayer.add(rotationAnimation, forKey: animationType.rotation.keyPath)
    }
    
    func stopAnimation() {
        circleLayer.removeAnimation(forKey: animationType.strokeEnd.keyPath)
        circleLayer.removeAnimation(forKey: animationType.strokeStart.keyPath)
        circleLayer.removeAnimation(forKey: animationType.rotation.keyPath)
    }
    
    // MARK: - init Element
    
    lazy private var circleLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.cornerRadius = 3
        layer.lineWidth = 3       //線粗4
        layer.fillColor = nil     //layer填充色
        layer.strokeColor = LoadingStyle.yellow.cgColor   //邊框色
        return layer
    }()
    
    lazy private var strokeStartAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: animationType.strokeStart.keyPath)
        animation.beginTime = 0.8     //更改動畫的開始時間
        animation.fromValue = 0    //線條起始位置
        animation.toValue = 1       //路徑的結尾
        animation.duration = 1.5      //持續時間
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        let group = CAAnimationGroup()
        group.duration = 2.3
        group.repeatCount = MAXFLOAT    //重複次數，設定為最大量
        group.animations = [animation]
        
        return group
    }()
    
    lazy private var strokeEndAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: animationType.strokeEnd.keyPath)
        animation.fromValue = 0     //路徑的開頭
        animation.toValue = 1       //路徑的結尾
        animation.duration = 1.5     //持續時間
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        let group = CAAnimationGroup()
        group.duration = 2.3
        group.repeatCount = MAXFLOAT    //重複次數，設定為最大量
        group.animations = [animation]
        
        return group
    }()
    
    lazy private var rotationAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.duration = 3
        animation.repeatCount = MAXFLOAT
        return animation
    }()
}
