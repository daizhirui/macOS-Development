//
//  AppDelegate.swift
//  NSButtonDemo
//
//  Created by 戴植锐 on 2018/3/3.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var checkButtonGroup: NSButton!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        self.createButton()
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func createButton() {
        let frame = CGRect(x: 0, y: 0, width: 80, height: 24)
        let btn = NSButton(frame: frame)
        btn.bezelStyle = NSButton.BezelStyle.roundRect
        btn.title = "CodeButton"
        btn.target = self
        btn.action = #selector(buttonClicked(_:))
        self.window.contentView?.addSubview(btn)
    }
    
    @objc func buttonClicked(_ sender: NSButton) {
        NSLog("the button is clicked!")
    }
    
    @IBAction func checkButtonAction(_ sender: NSButton) {
        let state = sender.state
        switch state {
        case .on:
            NSLog("checkButton State: On")
        case .off:
            NSLog("checkButton State: Off")
        case .mixed:
            NSLog("checkButton State: Mixed")
        default:
            NSLog("Unknown")
        }
    }
    
    @IBOutlet weak var maleRadioButton: NSButton!
    @IBOutlet weak var femaleRadioButton: NSButton!
    @IBAction func radioButtonAction(_ sender: NSButton) {
        let tag = sender.tag
        Swift.print("tag = \(tag)")
        if tag == 0 {
            
        }
        if tag == 1 {
            
        }
    }
    
    
}

