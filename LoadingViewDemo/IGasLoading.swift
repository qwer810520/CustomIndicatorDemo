//
//  IGasLoading.swift
//  LoadingViewDemo
//
//  Created by 楷岷 張 on 2018/8/1.
//  Copyright © 2018年 Min. All rights reserved.
//

import UIKit

class IGasLoading {
    
    fileprivate static var indicatorView: IGasIndicatorView?
    
    class func show(_ title: String? = nil) {
        print("IGasLoading", #function)
        indicatorView = IGasIndicatorView()
        guard let view = indicatorView else { return }
        DispatchQueue.main.async {
            print("IGasLoading CheckHaveView")
            view.show(title == nil ? "載入中..." : title)
        }
    }
    
    class func dismiss() {
        print("IGasLoading", #function)
        indicatorView?.dismiss()
        indicatorView = nil
    }
}
