//
//  AppMainWindowController.swift
//  NSWindowArchitecture
//
//  Created by 戴植锐 on 2018/3/8.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class AppMainWindowController: NSWindowController {
    
    lazy var viewController: AppViewController = {
        let vc = AppViewController()
        return vc
    }()
    
    override func windowDidLoad() {
        super.windowDidLoad()
        self.contentViewController = self.viewController
    }
    // 返回 window 的xib文件名
    override var windowNibName: NSNib.Name? {
        return NSNib.Name(rawValue: "AppMainWindowController")
    }
}
