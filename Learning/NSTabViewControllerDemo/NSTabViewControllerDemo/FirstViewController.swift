//
//  FirstViewController.swift
//  NSTabViewControllerDemo
//
//  Created by 戴植锐 on 2018/3/9.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class FirstViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.blue.cgColor
    }
    
}
