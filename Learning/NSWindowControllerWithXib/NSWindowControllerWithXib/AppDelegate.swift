//
//  AppDelegate.swift
//  NSWindowControllerWithXib
//
//  Created by 戴植锐 on 2018/3/8.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    lazy var myWindowController: NSWindowController = {
       let windowVC = NSWindowController()
        return windowVC
    }()
    lazy var myWindow: MyWindow = {
       let frame = CGRect(x: 0, y: 0, width: 400, height: 280)
        let style: NSWindow.StyleMask = [NSWindow.StyleMask.titled, NSWindow.StyleMask.closable, NSWindow.StyleMask.resizable]
        let window = MyWindow(contentRect: frame, styleMask: style, backing: .buffered, defer: false)
        window.windowController = self.myWindowController
        self.myWindowController.window = window
        window.title = "New Create Window"
        return window
    }()
    @IBAction func showWindowAction(_ sender: NSButton) {
        self.myWindow.makeKeyAndOrderFront(self)
        self.myWindow.center()
    }
    
}

