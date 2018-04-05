//
//  AppDelegate.swift
//  NSVisualEffectDemo
//
//  Created by 戴植锐 on 2018/3/1.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    
    
    lazy var mainWindowController: MainWindowController? = {
        let sb = NSStoryboard.init(name: NSStoryboard.Name("Main"), bundle: nil)
        let wvc = sb.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "MainWindowController")) as? MainWindowController
        return wvc
    }()
    
    lazy var loginWindowController: LoginWindowController? = {
        let sb = NSStoryboard.init(name: NSStoryboard.Name("Main"), bundle: nil)
        let wvc = sb.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "LoginWindowController")) as? LoginWindowController
        return wvc
    }()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        loginWindowController?.showWindow(self)
        registerNotification()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        mainWindowController = nil
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.onLoginOK(_:)), name: NSNotification.Name.loginOK, object: nil)
    }
    
    @objc func onLoginOK(_ aNotification: Notification) {
        mainWindowController?.showWindow(self)
    }
    
}

