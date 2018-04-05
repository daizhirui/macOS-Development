//
//  AppDelegate.swift
//  NSMenuDemo
//
//  Created by 戴植锐 on 2018/3/7.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        // 使用代码创建菜单
        self.menuConfig()
    }
    
    func menuConfig() {
        // 1. 创建顶级根菜单对象
        let customMenu = NSMenu(title: "MainMenu")
        // 2. 创建第一个主菜单，也就是应用程序菜单
        let firstLevelMenuItem = NSMenuItem()
        let firstLevelMenu = NSMenu()
        // 配置菜单的 2 级菜单
        firstLevelMenuItem.submenu = firstLevelMenu
        // 创建 3 个子菜单
        let aboutMenuItem = NSMenuItem(title: "About", action: #selector(NSApplication.orderFrontStandardAboutPanel(_:)), keyEquivalent: "A")
        let preferenceMenuItem = NSMenuItem(title: "Preference...", action: nil, keyEquivalent: "P")
        let quitMenuItem = NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "Q")
        quitMenuItem.keyEquivalentModifierMask = NSEvent.ModifierFlags.command
        // 将子菜单添加到上级菜单
        firstLevelMenu.addItem(aboutMenuItem)
        firstLevelMenu.addItem(preferenceMenuItem)
        firstLevelMenu.addItem(quitMenuItem)
        // 3. 创建第 2 个一级菜单
        let secondLevelMenuItem = NSMenuItem()
        let secondLevelMenu = NSMenu(title: "File")
        secondLevelMenuItem.submenu = secondLevelMenu
        // 创建子菜单，配置 action 事件
        let openMenuItem = NSMenuItem(title: "Open", action: #selector(AppDelegate.menuClicked(_:)), keyEquivalent: "0")
        // 配置组合键
        openMenuItem.keyEquivalentModifierMask = NSEvent.ModifierFlags.shift
        // 将子菜单添加到上级菜单
        secondLevelMenu.addItem(openMenuItem)
        // 增加一级菜单到顶级菜单对象
        customMenu.addItem(firstLevelMenuItem)
        customMenu.addItem(secondLevelMenuItem)
        // 配置应用的主菜单
        NSApp.mainMenu = customMenu
    }
    @IBAction func menuClicked(_ sender: NSMenuItem) {
        print(sender.title)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBOutlet weak var dockMenu: NSMenu!
    func applicationDockMenu(_ sender: NSApplication) -> NSMenu? {
        return self.dockMenu
    }
    @IBAction func dockMenuAction(_ sender: NSMenuItem) {
        print(sender.title)
    }
    
}

