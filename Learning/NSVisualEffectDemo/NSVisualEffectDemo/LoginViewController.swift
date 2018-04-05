//
//  LoginViewController.swift
//  NSVisualEffectDemo
//
//  Created by 戴植锐 on 2018/3/1.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class LoginViewController: NSViewController {
    
    lazy var effectView: NSVisualEffectView = {
        let effectView = NSVisualEffectView()
        effectView.wantsLayer = true
        effectView.material = .light
        effectView.state = .active
        effectView.blendingMode = .withinWindow
        return effectView
    }() // 立即执行此闭包
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.red.cgColor
        // 添加 effectView 到父视图的最底层
        // effectView.frame = view.bounds
        // view.addSubview(effectView, positioned: .below, relativeTo: view.subviews[0])
    }
    
    @IBAction func closeButtonAction(_ sender: NSButton) {
        self.view.window?.close()
    }
    
    @IBAction func loginButtonAction(_ sender: NSButton) {
        self.view.window?.close()
        NotificationCenter.default.post(name: Notification.Name.loginOK, object: nil)
    }
}

extension Notification.Name {
    static let loginOK = Notification.Name("loginOK")
}
