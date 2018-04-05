//
//  WindowController.swift
//  NSSplitViewControllerDoubleClickCollapse
//
//  Created by 戴植锐 on 2018/3/10.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

let kOpenCloseViewNotification = "OpenCloseViewNotification"

extension Notification.Name {
    //定义消息通知名称
    static let onOpenCloseView  = Notification.Name("on-open-close-view")
}

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

    @IBAction func openCloseAction(_ sender: NSToolbarItem) {
        NotificationCenter.default.post(name: Notification.Name.onOpenCloseView, object: nil)
    }
}
