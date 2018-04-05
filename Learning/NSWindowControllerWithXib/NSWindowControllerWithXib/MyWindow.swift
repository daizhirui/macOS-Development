//
//  MyWindow.swift
//  NSWindowControllerWithXib
//
//  Created by 戴植锐 on 2018/3/8.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class MyWindow: NSWindow {
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)
    }
    override func orderFront(_ sender: Any?) {
        super.orderFront(sender)
    }
    override func orderOut(_ sender: Any?) {
        super.orderOut(sender)
    }
    override func makeKeyAndOrderFront(_ sender: Any?) {
        super.makeKeyAndOrderFront(sender)
    }
    override func makeKey() {
        super.makeKey()
    }
}
