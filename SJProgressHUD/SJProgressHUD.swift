//
//  SJProgressHUD.swift
//  SJProgressHUD
//
//  Created by king on 16/4/10.
//  Copyright © 2016年 king. All rights reserved.
//

import UIKit

public enum ShowType {
    case success
    case error
    case info
}

public extension SJProgressHUD {
    
    /**
     加载动画图片
     
     - parameter images:       图片数组
     - parameter timeInterval: 动画每次执行时间
     */
    public static func showWaitingWithImages(images : Array<UIImage>, timeInterval : NSTimeInterval = 0) {
        SJProgressHUD.showWaitWithImages(images, timeInterval: timeInterval)
    }
    /**
     显示菊花
     
     - parameter text:       需要显示的文字,如果不设置文字,则只显示菊花
     - parameter autoRemove: 是否自动移除,默认3秒后自动移除
     */
    public static func showWaiting(text: String = "", autoRemove: Bool = true) {
        SJProgressHUD.showWaitingWithText(text, autoRemove: autoRemove)
    }
    /**
     状态栏显示
     
     - parameter text:       需要显示的文字
     - parameter color:      背景颜色
     - parameter autoRemove: 是否自动移除,默认3秒后自动移除
     */
    public static func showStatusBarWithText(text: String = "OK", color: UIColor = UIColor(red: 131 / 255.0, green: 178 / 255.0, blue: 158 / 255.0, alpha: 1), autoRemove: Bool = true) {
        SJProgressHUD.showStatusBar(text, color: color, autoRemove: autoRemove)
    }
    /**
     只显示文字
     
     - parameter text:       需要显示的文字
     - parameter autoRemove: 是否自动移除,默认3秒后自动移除
     */
    public static func showOnlyText(text: String, autoRemove: Bool = true) {
        SJProgressHUD.onlyText(text, autoRemove: autoRemove)
    }
    /**
     Success样式
     
     - parameter successText: 需要显示的文字,默认为 Success!
     - parameter autoRemove:  是否自动移除,默认3秒后自动移除
     */
    public static func showSuccess(successText: String = "Success!", autoRemove: Bool = true) {
        SJProgressHUD.showText(.success, text: successText, autoRemove: autoRemove)
    }
    /**
     Error样式
     
     - parameter errorText:  需要显示的文字,默认为 Error!
     - parameter autoRemove: 是否自动移除,默认3秒后自动移除
     */
    public static func showError(errorText: String = "Error!", autoRemove: Bool = true) {
        SJProgressHUD.showText(.error, text: errorText, autoRemove: autoRemove)
    }
    /**
     Info样式
     
     - parameter infoText:   需要显示的文字,默认为 Info!
     - parameter autoRemove: 是否自动移除,默认3秒后自动移除
     */
    public static func showInfo(infoText: String = "info!", autoRemove: Bool = true) {
        SJProgressHUD.showText(.info, text: infoText, autoRemove: autoRemove)
    }
    /**
     移除HUD,会移除所有
     */
    public static func dismiss() {
        SJProgressHUD.clear()
    }
}


private let circleSize = CGSize(width: 40, height: 40)
private let windowBgColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.002)
private func bgColor(alpha: CGFloat) -> UIColor {
    return UIColor(red: 0, green: 0, blue: 0, alpha: alpha)
}

public class SJProgressHUD : NSObject {
    
    static var windows = Array<UIWindow!>()
    static var angle: Double {
            return [0, 0, 180, 270, 90][UIApplication.sharedApplication().statusBarOrientation.hashValue] as Double
    }
    static private func showWaitWithImages(images : Array<UIImage>, timeInterval : NSTimeInterval) {
        
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let imageView = UIImageView()
        imageView.frame = frame
        imageView.contentMode = .ScaleAspectFit
        imageView.backgroundColor = bgColor(0.7)
        imageView.layer.cornerRadius = 10
        imageView.animationImages = images
        imageView.animationDuration = timeInterval == 0 ? NSTimeInterval(images.count) * 0.07 : timeInterval
        imageView.animationRepeatCount = 0
        imageView.startAnimating()
        
        _ = SJProgressHUD.createWindow(frame, view: imageView)

    }
    static private func showWaitingWithText(text: String, autoRemove: Bool) {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = bgColor(0.7)
        view.layer.cornerRadius = 10
        
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .White)
        if !text.isEmpty {
            activity.frame = CGRect(x: 35, y: 25, width: 30, height: 30)
            
            let lable = SJProgressHUD.createLable()
            lable.frame = CGRect(x: 0, y: 55, width: 100, height: 45)
            lable.text = text
            view.addSubview(lable)
        }
        activity.frame = CGRect(x: 30, y: 30, width: 40, height: 40)
        activity.startAnimating()
        view.addSubview(activity)
        
        
        let window = SJProgressHUD.createWindow(view.frame, view: view)

        
        if autoRemove {
            performSelector(#selector(SJProgressHUD.removeHUD(_:)), withObject: window, afterDelay: 3)
        }
    
    }
    static private func showStatusBar(text: String, color: UIColor, autoRemove: Bool) {
        
        let frame = UIApplication.sharedApplication().statusBarFrame
        
        let lable = SJProgressHUD.createLable()
        lable.text = text
        
        let window = SJProgressHUD.createWindow(frame, view: lable)
        window.backgroundColor = color
        window.windowLevel = UIWindowLevelStatusBar
        lable.frame = frame
        window.center = CGPoint(x: frame.width * 0.5, y: frame.height * 0.5)
        lable.center = window.center
        
        if autoRemove {
            performSelector(#selector(SJProgressHUD.removeHUD(_:)), withObject: window, afterDelay: 3)
        }
    }
    static private func onlyText(text: String, autoRemove: Bool) {
        
        let view = UIView()
        view.backgroundColor = bgColor(0.7)
        view.layer.cornerRadius = 10
        
        
        let label = SJProgressHUD.createLable()
        label.text = text
        label.font = UIFont.systemFontOfSize(12)
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        view.addSubview(label)
        
        let frame = CGRectMake(0, 0, 210 , 110)
        view.frame = frame
        label.center = view.center
 
        let window = SJProgressHUD.createWindow(frame, view: view)
        
        if autoRemove {
            performSelector(#selector(SJProgressHUD.removeHUD(_:)), withObject: window, afterDelay: 3)
        }
    }
    static private func showText(type: ShowType, text: String, autoRemove: Bool) {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
       
        let view = UIView(frame: frame)
        view.layer.cornerRadius = 10
        view.backgroundColor = bgColor(0.7)
        
        var image = UIImage()
        switch type {
        case .success:
            image = drawImage.imageOfSuccess
        case .error:
            image = drawImage.imageOfError
        case .info:
            image = drawImage.imageOfInfo
        }
        
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(origin: CGPoint(x: 30, y: 25), size: circleSize)
        imageView.contentMode = .ScaleAspectFit
        view.addSubview(imageView)
        
        let lable = SJProgressHUD.createLable()
        lable.frame = CGRect(x: 0, y: 70, width: 100, height: 30)
        lable.text = text
        view.addSubview(lable)
        
        let window = SJProgressHUD.createWindow(frame, view: view)
        
        if autoRemove {
            performSelector(#selector(SJProgressHUD.removeHUD(_:)), withObject: window, afterDelay: 3)
        }
        
    }
    
    static private func createLable() -> UILabel {
        let lable = UILabel()
        lable.font = UIFont.systemFontOfSize(10)
        lable.backgroundColor = UIColor.clearColor()
        lable.textColor = UIColor.whiteColor()
        lable.numberOfLines = 0
        lable.textAlignment = .Center
        return lable
    }
    static private func createWindow(frame: CGRect, view: UIView) -> UIWindow {
        
        let window = UIWindow(frame: frame)
        window.backgroundColor = windowBgColor
        window.windowLevel = UIWindowLevelAlert
        window.transform = CGAffineTransformMakeRotation(CGFloat(angle * M_PI / 180))
        window.hidden = false
        window.center = getCenter()
        window.addSubview(view)
        windows.append(window)
        return window
    }
    @objc static private func removeHUD(object: AnyObject) {
        if let window = object as? UIWindow {
            if let index = windows.indexOf({ (item) -> Bool in
                return item == window
            }) {
                windows.removeAtIndex(index)
            }
        }
    }
    static private func clear() {
        if windows.isEmpty { return }
        self.cancelPreviousPerformRequestsWithTarget(self)
         windows.removeAll(keepCapacity: false)
    }
    static func getCenter() -> CGPoint {
        let view = UIApplication.sharedApplication().keyWindow?.subviews.first as UIView!
        if UIApplication.sharedApplication().statusBarOrientation.hashValue >= 3 {
            return CGPoint(x: view.center.y, y: view.center.x)
        } else {
            return view.center
        }
    }
}


class drawImage  {
    
    struct imageCache {
        static var imageOfSuccess: UIImage?
        static var imageOfError: UIImage?
        static var imageOfInfo: UIImage?
    }
    
    class func draw(type : ShowType) {
        
        let path = UIBezierPath()
        
        path.moveToPoint(CGPoint(x: 40, y: 20))
        path.addArcWithCenter(CGPoint(x: 20, y: 20), radius: 19, startAngle: 0, endAngle: CGFloat(M_PI*2), clockwise: true)
        path.closePath()
        
        switch type {
        case .success:
            path.moveToPoint(CGPoint(x: 15, y: 20))
            path.addLineToPoint(CGPoint(x: 20, y: 25))
            path.addLineToPoint(CGPoint(x: 30, y: 15))
            path.moveToPoint(CGPoint(x: 15, y: 20))
            path.closePath()
        case .error:
            path.moveToPoint(CGPoint(x: 10, y: 10))
            path.addLineToPoint(CGPoint(x: 30, y: 30))
            path.moveToPoint(CGPoint(x: 10, y: 30))
            path.addLineToPoint(CGPoint(x: 30, y: 10))
            path.moveToPoint(CGPoint(x: 10, y: 10))
            path.closePath()
        case .info:
            path.moveToPoint(CGPoint(x: 20, y: 8))
            path.addLineToPoint(CGPoint(x: 20, y: 28))
            path.moveToPoint(CGPoint(x: 20, y: 8))
            path.closePath()
            
            let tmpPath = UIBezierPath()
            tmpPath.moveToPoint(CGPoint(x: 20, y: 30))
            tmpPath.addArcWithCenter(CGPoint(x: 20, y: 30), radius: 1, startAngle: 0, endAngle: CGFloat(M_PI*2), clockwise: true)
            tmpPath.closePath()
            UIColor.whiteColor().setFill()
            tmpPath.fill()
        }
        UIColor.whiteColor().setStroke()
        path.stroke()
    }
    
    class var imageOfSuccess: UIImage {
        if imageCache.imageOfSuccess != nil {
            return imageCache.imageOfSuccess!
        }
        UIGraphicsBeginImageContextWithOptions(circleSize, false, 0)
        drawImage.draw(.success)
        imageCache.imageOfSuccess = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageCache.imageOfSuccess!
    }
    class var imageOfError: UIImage {
        if imageCache.imageOfError != nil {
            return imageCache.imageOfError!
        }
        UIGraphicsBeginImageContextWithOptions(circleSize, false, 0)
        drawImage.draw(.error)
        imageCache.imageOfError = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageCache.imageOfError!
    }
    class var imageOfInfo: UIImage {
        if imageCache.imageOfInfo != nil {
            return imageCache.imageOfInfo!
        }
        UIGraphicsBeginImageContextWithOptions(circleSize, false, 0)
        drawImage.draw(.info)
        imageCache.imageOfInfo = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageCache.imageOfInfo!
    }
}
