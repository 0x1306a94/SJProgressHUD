//
//  ViewController.swift
//  SJProgressHUDDemo
//
//  Created by king on 16/4/10.
//  Copyright © 2016年 king. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    @IBAction func loadImage(sender: AnyObject) {
        
        var images = Array<UIImage>()
        
        for i in 1...31 {
            
            let patch =  NSBundle.mainBundle().pathForResource("load_\(i)@2x.png", ofType: nil, inDirectory: nil)
            let image = UIImage(contentsOfFile: patch!)
            images.append(image!)
        }
        SJProgressHUD.showWaitingWithImages(images)
    }
    @IBAction func Waiting(sender: AnyObject) {
        SJProgressHUD.showWaiting("正在加载中......")
    }
    @IBAction func Success(sender: AnyObject) {
        SJProgressHUD.showSuccess()
    }
    @IBAction func Error(sender: AnyObject) {
        SJProgressHUD.showError()
    }
    @IBAction func Info(sender: AnyObject) {
        SJProgressHUD.showInfo()
    }
    @IBAction func OnlyText(sender: AnyObject) {
        SJProgressHUD.showOnlyText("这是打酱油的!!这是打酱油的!!这是打酱油的!!这是打酱油的!!这是打酱油的!!这是打酱油的!!")
    }
    @IBAction func statusBar(sender: AnyObject) {
        SJProgressHUD.showStatusBarWithText()
    }
    @IBAction func dismiss(sender: AnyObject) {
        SJProgressHUD.dismiss()
    }


}

