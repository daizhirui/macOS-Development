//
//  TabViewController.swift
//  NSTabViewControllerXibDemo
//
//  Created by 戴植锐 on 2018/3/9.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class TabViewController: NSTabViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let firstViewController = FirstViewController()
        firstViewController.title = "FirstTab"
        let secondViewController = SecondViewController()
        secondViewController.title = "SecondTab"
        self.addChildViewController(firstViewController)
        self.addChildViewController(secondViewController)
    }
    
}
