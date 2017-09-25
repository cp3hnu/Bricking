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
        // Do any additional setup after loading the view, typically from a nib.
        let headerView: UIView = {
            let portraitImgView = UIImageView()
            portraitImgView.layer.cornerRadius = 4
            portraitImgView.layer.masksToBounds = true
            portraitImgView.backgroundColor = UIColor.red
            
            let nameLabel = UILabel()
            let idLabel = UILabel()
            let indicator = UIImageView()
            indicator.setContentHuggingPriority(UILayoutPriorityDefaultLow + 1, for: .horizontal)
            let headerView = UIView()
            headerView.asv(portraitImgView, nameLabel, idLabel, indicator)
//            headerView.layout(
//                nameLabel,
//                5,
//                phCenterY,
//                5,
//                idLabel
//            )
            headerView.laCenterY == nameLabel.laBottom + 5
            idLabel.laTop == headerView.laCenterY + 5
            |-15-portraitImgView.top(15).bottom(15).size(65)-nameLabel-indicator-15-|
            indicator.centerVertically()
            alignLeftAndRight(nameLabel, idLabel)
            
            nameLabel.text = "大宝"
            idLabel.text = "12123"
            return headerView
        }()
        
        view.asv(headerView)
        |headerView.top(64)|
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

