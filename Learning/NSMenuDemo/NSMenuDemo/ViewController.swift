//
//  ViewController.swift
//  NSMenuDemo
//
//  Created by 戴植锐 on 2018/3/7.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    // 鼠标右键点击的菜单
    @IBOutlet var rightClickMenu: NSMenu!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.menu = self.rightClickMenu
    }
    @IBAction func rightClickedMenuAction(_ sender: NSMenuItem) {
        print(sender.tag)
    }
    

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    // 弹出式菜单
    @IBOutlet var myMenu: NSMenu!
    @IBAction func popButtonClicked(_ sender: NSButton) {
        var point = sender.frame.origin
        point.x = point.x + sender.frame.size.width
        self.myMenu.popUp(positioning: nil, at: point, in: self.view)
    }
    @IBAction func popMenuClicked(_ sender: NSMenuItem) {
        print(sender.tag)
    }
    
    // Dock 图标菜单
    @IBOutlet var dockMenu: NSMenu!
    
}

