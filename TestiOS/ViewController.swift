//
//  ViewController.swift
//  TestiOS
//
//  Created by CP3 on 2017/9/25.
//  Copyright © 2017年 CP3. All rights reserved.
//

import UIKit
import Bricking

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        title = "Test"
    }
    
    @IBAction func clicked(_ sender: Any) {
        let ctrlr = SecondCtrlr()
        navigationController?.pushViewController(ctrlr, animated: true)
    }
}

class SecondCtrlr: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        title = "Second"
        
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.red
        
        
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "zhaowei"
        
        
        view.asv(imageView, label)
        (imageView.size(30)-label).togetherCenterHorizontally().top(100)
        

        
        
        
        /*
        let view1 = UIView()
        view1.backgroundColor = UIColor.black
        view1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        
        let view2 = UIView()
        view2.backgroundColor = UIColor.red
        
        let view3 = UIView()
        view3.backgroundColor = UIColor.green
        
        let view4 = UIView()
        view4.backgroundColor = UIColor.blue
        
        view.asv(view1, view2, view3, view4)
        view.layout(
            self.topLayoutGuide,
            10,
            |view1| ~ 50,
            30,
            |view2| ~ 50,
            |view3| ~ 50,
            40,
            |view4|,
            self.bottomLayoutGuide
        )*/
    }

    
    @objc func tap() {
        
    }
}

