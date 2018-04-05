//
//  PresentViewController.swift
//  NSViewControllerTransitionDemo
//
//  Created by 戴植锐 on 2018/3/9.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class PresentViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    // 关闭切换后显示的 ViewController
    @IBAction func dismissAction(_ sender: NSButton) {
        self.dismiss(self)
    }
}
