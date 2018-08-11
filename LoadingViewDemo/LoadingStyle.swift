//
//  LoadingStyle.swift
//  LoadingViewDemo
//
//  Created by 楷岷 張 on 2018/8/1.
//  Copyright © 2018年 Min. All rights reserved.
//

import UIKit

class LoadingStyle {
    
    class var yellow: UIColor {
        return #colorLiteral(red: 1, green: 0.8784313725, blue: 0, alpha: 1)
    }
}

extension UIView {
    open func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
