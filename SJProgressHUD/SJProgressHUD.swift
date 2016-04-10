//
//  SJProgressHUD.swift
//  SJProgressHUDDemo
//
//  Created by king on 16/4/10.
//  Copyright © 2016年 king. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showLoadingWithImages(images : Array<UIImage>, timeInterval : NSTimeInterval = 0) {
        SJProgressHUD.showLoadingWithImages(images, timeInterval: timeInterval)
    }
    func dismissLoading() {
        SJProgressHUD.dismissLoading()
    }
}


enum ShowType : String {
    case success
    case error
    case info
}

class SJProgressHUD : NSObject {
    
    static var windows = Array<UIWindow!>()
    static let rv = UIApplication.sharedApplication().keyWindow?.subviews.first as UIView!
    static var degree: Double {
        get {
            return [0, 0, 180, 270, 90][UIApplication.sharedApplication().statusBarOrientation.hashValue] as Double
        }
    }
    
    static func showLoadingWithImages(images : Array<UIImage>, timeInterval : NSTimeInterval) {
        
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let imageView = UIImageView()
        window.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.02)
        window.windowLevel = UIWindowLevelAlert
        imageView.frame = frame
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        imageView.layer.cornerRadius = 10
        imageView.animationImages = images
        imageView.animationDuration = timeInterval == 0 ? NSTimeInterval(images.count) * 0.07 : timeInterval
        imageView.animationRepeatCount = 0
        imageView.startAnimating()
        imageView.center = window.center
        window.hidden = false
        window.transform = CGAffineTransformMakeRotation(CGFloat(degree * M_PI / 180))
        window.addSubview(imageView)
        windows.append(window)
    }
    
    static func dismissLoading() {
         windows.removeAll(keepCapacity: false)
    }
    static func getRootViewCenter() -> CGPoint {
        if UIApplication.sharedApplication().statusBarOrientation.hashValue >= 3 {
            return CGPoint(x: rv.center.y, y: rv.center.x)
        } else {
            return rv.center
        }
    }
}

