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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        var images = Array<UIImage>()
        
        for i in 1...31 {
           
          let patch =  NSBundle.mainBundle().pathForResource("load_\(i)@2x.png", ofType: nil, inDirectory: nil)
            let image = UIImage(contentsOfFile: patch!)
            images.append(image!)
        }
        showLoadingWithImages(images)
    
        
    }
}

