//
//  AppDelegate.swift
//  NSWindowArchitecture
//
//  Created by 戴植锐 on 2018/3/8.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    lazy var windowController: AppMainWindowController = {
        let windowVC = AppMainWindowController()
        return windowVC
    }()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.windowController.showWindow(self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

