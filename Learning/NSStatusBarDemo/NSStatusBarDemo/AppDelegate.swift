//
//  AppDelegate.swift
//  NSStatusBarDemo
//
//  Created by 戴植锐 on 2018/3/7.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusItem: NSStatusItem? = nil
    @IBOutlet weak var shareMenu: NSMenu!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        self.createStatusBarForPopover()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        let statusBar = NSStatusBar.system
        // 应用退出时删除 item
        statusBar.removeStatusItem(statusItem!)
    }

    func createStatusBar() {
        // 获取系统单例 NSStatusBar 对象
        let statusBar = NSStatusBar.system
        // 创建固定宽度的 NSStatusItem
        let item = statusBar.statusItem(withLength: NSStatusItem.squareLength)
        item.button?.target = self
        // 点击状态栏时的动作
        item.button?.action = #selector(AppDelegate.itemAction(_:))
        // 点击状态栏时弹出的菜单
        item.menu = self.shareMenu
        item.button?.image = NSImage(named: NSImage.Name(rawValue: "blue"))
        self.statusItem = item
    }
    
    func createStatusBarForPopover() {
        // 获取系统单例 NSStatusBar 对象
        let statusBar = NSStatusBar.system
        // 创建固定宽度的 NSStatusItem
        let item = statusBar.statusItem(withLength: NSStatusItem.squareLength)
        item.button?.target = self
        // 点击状态栏时的动作
        item.button?.action = #selector(AppDelegate.itemPopoverAction(_:))
        item.button?.image = NSImage(named: NSImage.Name(rawValue: "blue"))
        
        self.statusItem = item
    }

    @IBAction func itemAction(_ sender: AnyObject) {
        // 激活应用到前台（如果应用窗口处于非活动状态）
        NSRunningApplication.current.activate(options: [NSApplication.ActivationOptions.activateIgnoringOtherApps])
        let window = NSApp.windows[0]
        window.orderFront(self)
    }
    
    var isShow = false
    lazy var popover: NSPopover = {
        let popoverTemp = NSPopover()
        popoverTemp.contentViewController = AppViewController()
        return popoverTemp
    }()
    @IBAction func itemPopoverAction(_ sender: NSStatusBarButton) {
        if !self.isShow {
            self.isShow = true
            self.popover.show(relativeTo: NSZeroRect, of: sender, preferredEdge: .minY)
        }
        else {
            self.popover.close()
            self.isShow = false
        }
    }
}

