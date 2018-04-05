//
//  LoginWindowController.swift
//  NSVisualEffectDemo
//
//  Created by 戴植锐 on 2018/3/1.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class LoginWindowController: NSWindowController, NSWindowDelegate {
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    func windowWillClose(_ notification: Notification) {
        self.contentViewController = nil
        self.window = nil
    }
}
