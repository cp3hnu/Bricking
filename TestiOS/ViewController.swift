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
        let sView = UIView()
        sView.backgroundColor = UIColor.white
        view.asv(sView)
        view.layout(
            topLayoutGuide,
            15,
            |sView| ~ 100
        )
    }
}

