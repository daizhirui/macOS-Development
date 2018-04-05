//
//  AppDelegate.swift
//  NSScrollViewDemo
//
//  Created by 戴植锐 on 2018/3/1.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    var scrollView: NSScrollView!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        registerNotification()
        self.createScrollView()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.resizeWindowAction(_:)), name: NSWindow.didResizeNotification, object: nil)
    }
    
    func createScrollView() {
        let width = self.window.frame.size.width / 2
        let height = self.window.frame.size.height
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        //let scrollView = NSScrollView(frame: frame)
        self.scrollView = NSScrollView(frame: frame)
        let image = NSImage(named: NSImage.Name("screen.png"))
        let imageViewFrame = CGRect(x: 0, y: 0, width: (image?.size.width)!, height: (image?.size.height)!)
        let imageView = NSImageView(frame: imageViewFrame)
        
        imageView.image = image
        
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = true
        scrollView.documentView = imageView
        
        self.window.contentView?.addSubview(scrollView)
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    @objc func resizeWindowAction(_ aNotification: Notification) {
        let size = NSSize(width: self.window.frame.size.width / 2, height: self.window.frame.size.height)
        self.scrollView.setFrameSize(size)
    }
    
    func scrollByY(by deltaY: Int) {
        var newScrollOrigin: NSPoint
        let contentView: NSClipView = self.scrollView.contentView
        
        let x = contentView.bounds.origin.x
        var y: CGFloat
        
        if self.window.contentView!.isFlipped {
            y = contentView.bounds.origin.y - CGFloat(deltaY)
            
            if y < self.scrollView.contentView.frame.height {
                y = self.scrollView.contentView.frame.height
            } else if y > (self.scrollView.documentView?.frame.height)! {
                y = (self.scrollView.documentView?.frame.height)!
            }
            
        } else {
            y = contentView.bounds.origin.y + CGFloat(deltaY)
            
            if y < 0 {
                y = 0
            } else if y > (self.scrollView.documentView?.frame.size.height)! - contentView.frame.size.height {
                y = (self.scrollView.documentView?.frame.size.height)! - contentView.frame.size.height
            }
        }
        
        newScrollOrigin = NSPoint(x: x, y: y)
        contentView.scroll(to: newScrollOrigin)
    }
    @IBAction func scrollUpAction(_ sender: NSButton) {
        scrollByY(by: 10)
    }
    
    @IBAction func scrollDownAction(_ sender: NSButton) {
        scrollByY(by: -10)
    }
    
    @IBOutlet weak var scrollTextView: NSScrollView!
    @IBAction func scrollLeftAction(_ sender: NSButton) {
        var frame = self.scrollTextView.bounds
        frame.origin.x -= 10
        self.scrollTextView.bounds = frame
    }
}

