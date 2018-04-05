//
//  AppDelegate.swift
//  ViewDemo
//
//  Created by 戴植锐 on 2018/2/28.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var registerButton: NSButton!
    @IBOutlet weak var changeSizeButton: NSButton!
    @IBOutlet weak var customView: CustomView!
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(self.redrawCustomViewText(_:)),
            name: NSWindow.didResizeNotification, object: nil)
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(self.recieveFrameChangeNotification(_:)),
            name: NSView.frameDidChangeNotification, object: customView)
        
        print("registerButton: \(self.registerButton)")
        print("changeSizeButton: \(self.changeSizeButton)")
        
        self.customView.postsFrameChangedNotifications = true
        self.customView.postsBoundsChangedNotifications = true
        
        self.customView.drawViewShape()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func changeViewSize(_ sender: NSButton) {
        self.window.setContentSize(
            NSSize(width: self.window.frame.size.width + 10,
            height: self.window.frame.size.height + 10) )
        
        if let targetView = self.window.contentView?.viewWithTag(self.registerButton.tag) {
            print("find a Button !")
            print("\(targetView)")
        } else {
            print("not find the registerButton !")
        }
    }
    @IBAction func drawCustomViewText(_ sender: NSButton) {
        self.customView.drawViewShape()
    }
    
    @objc func redrawCustomViewText(_ aNotification: Notification) {
        self.customView.drawViewShape()
        print("Window Size is changed!")
    }
    
    @IBAction func saveImage(_ sender: NSButton) {
        self.customView.saveScrollViewAsImage()
    }
    
    @objc func recieveFrameChangeNotification(_ aNotification: Notification) {
        self.customView.drawViewShape()
        print("CustomView Frame is changed!")
    }
    
    
}

