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
    @IBAction func loadImage(_ sender: AnyObject) {
        
        var images = Array<UIImage>()
        
        for i in 1...31 {
            
            let patch =  Bundle.main.path(forResource: "load_\(i)@2x.png", ofType: nil, inDirectory: nil)
            let image = UIImage(contentsOfFile: patch!)
            images.append(image!)
        }
        SJProgressHUD.showWaitingWithImages(images)
    }
    @IBAction func Waiting(_ sender: AnyObject) {
        SJProgressHUD.showWaiting("正在加载中......")
    }
    @IBAction func Success(_ sender: AnyObject) {
        SJProgressHUD.showSuccess()
    }
    @IBAction func Error(_ sender: AnyObject) {
        SJProgressHUD.showError()
    }
    @IBAction func Info(_ sender: AnyObject) {
        SJProgressHUD.showInfo()
    }
    @IBAction func OnlyText(_ sender: AnyObject) {
        SJProgressHUD.showOnlyText("这是打酱油的!!这是打酱油的!!这是打酱油的!!这是打酱油的!!这是打酱油的!!这是打酱油的!!")
    }
    @IBAction func statusBar(_ sender: AnyObject) {
        SJProgressHUD.showStatusBarWithText()
    }
    @IBAction func dismiss(_ sender: AnyObject) {
        SJProgressHUD.dismiss()
    }


}

