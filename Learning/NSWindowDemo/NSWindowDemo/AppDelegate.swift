//
//  AppDelegate.swift
//  HelloWorld
//
//  Created by 戴植锐 on 2018/2/28.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    // default window
    @IBOutlet weak var window: NSWindow!
    // modal window
    @IBOutlet weak var modalWindow: NSWindow!
    // buttons
    @IBOutlet weak var showModalWindow: NSButton!
    @IBOutlet weak var showModalSessionWindow: NSButton!
    @IBOutlet weak var createAWindow: NSButton!
    var myButton: NSButton!
    @IBOutlet weak var moveWindowButton: NSButton!
    
    // modalSession
    var sessionCode: NSApplication.ModalSession?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        NotificationCenter.default.addObserver(self,
            selector: #selector(self.windowClose(_:)),
            name: NSWindow.willCloseNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(self,
            selector: #selector(self.calculateRegisterButtonPosition(_:)),
            name: NSWindow.didResizeNotification, object: nil)
        
        // replace contentView with custom NSView or NSViewController
        // let vc = NSViewController()
        // self.window.contentView = vc.view
        
        // macOS 10.10 and later, we can create a NSViewController instance and replace the default NSViewController
        // self.window.contentViewController = vc
        
        self.createButton()
        self.setWindowTitleImage()
        self.addButtonToTitleBar()
        
        // 设置窗口的背景颜色
        self.window.backgroundColor = NSColor.green
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    // create a button by code
    func createButton() {
        let btnFrame = CGRect(x: 10, y: 10, width: 120, height: 18)
        self.myButton = NSButton(frame: btnFrame)
        self.myButton.title = "ASTRO'S BUTTON"
        self.window.contentView?.addSubview(myButton)
    }
    
    // 设置 Window 的 image 和 title
    func setWindowTitleImage() {
        self.window.representedURL = URL(string: "WindowTitle")
        self.window.title = "My Window"
        let image = NSImage(named: NSImage.Name(rawValue: "AppIcon.png"))
        self.window.standardWindowButton(.documentIconButton)?.image = image
    }
    
    // 窗口关闭通知处理函数
    @objc func windowClose(_ aNotification: Notification){
        
        // To close Modal Session Window
        if let sessionCode = sessionCode {
            NSApplication.shared.endModalSession(sessionCode)
            self.sessionCode = nil
        }
        
        if let window = aNotification.object as? NSWindow {
            // To close Modal Window
            if self.modalWindow == window {
                NSApplication.shared.stopModal()
            }
            /*
            if window == self.window! {
                NSApp.terminate(self)
            }
            */
        }
    }
    
    // 关闭最后一个窗口时终止应用
    /*
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }*/
    
    // 模态窗口
    @IBAction func showModalWindow(_ sender: NSButton) {
        NSApplication.shared.runModal(for: self.modalWindow)
        self.modalWindow.center()
    }
    
    // 模态会话窗口
    @IBAction func showSessionWindow(_ sender: NSButton) {
        sessionCode = NSApplication.shared.beginModalSession(for: self.modalWindow)
    }
    
    // create a window by coding
    // WARNING: THERE IS A BUG TO REOPEN THE WINDOW!
    @IBOutlet weak var myWindow: NSWindow!
    //var myWindow: NSWindow!
    func createWindow() {
        //let frame = CGRect(x: 0, y: 0, width: 400, height: 280)
        //let style: NSWindow.StyleMask = [NSWindow.StyleMask.titled,NSWindow.StyleMask.closable,NSWindow.StyleMask.resizable]
        // create the window
        //self.myWindow = NSWindow(contentRect: frame, styleMask: style, backing: .buffered, defer: false)
        //self.myWindow.title = "New Create Window"
        // show the window
        self.myWindow.makeKeyAndOrderFront(self)
        // place the window center
        self.myWindow.center()
    }
    @IBAction func createAWindowAction(_ sender: NSButton) {
        self.createWindow()
    }
    
    // window title 区域增加视图
    var registerButton: NSButton!
    func addButtonToTitleBar() {
        let titleView = self.window.standardWindowButton(.closeButton)?.superview
        let x = (self.window.contentView?.frame.size.width)! - 100
        let frame = CGRect(x: x, y: -1, width: 80, height: 24)
        registerButton = NSButton()
        self.registerButton.frame = frame
        self.registerButton.title = "Register"
        self.registerButton.bezelStyle = NSButton.BezelStyle.roundRect
        titleView?.addSubview(self.registerButton)
    }
    
    @objc func calculateRegisterButtonPosition(_ aNotification: Notification) {
        let x = (self.window.contentView?.frame.size.width)! - 100
        let point = NSPoint(x: x, y: -1)
        self.registerButton.setFrameOrigin(point)
    }
    
    @IBAction func moveWindowRight(_ sender: NSButton) {
        //self.window?.isRestorable = false
        let x = self.window.frame.origin.x + 100
        let y = self.window.frame.origin.y
        // let width = self.window.frame.size.width
        // let height = self.window.frame.size.height
        // let rect = CGRect(x: x, y: y, width: width, height: height)
        // method 1
        // self.window?.setFrame(rect, display: true)
        // method 2
        self.window?.setFrameOrigin(NSPoint(x: x, y: y))
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        self.window.makeKeyAndOrderFront(self)
        return true
    }
    
    
    
    
    
    
    
}

