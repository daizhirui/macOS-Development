//
//  WindowBorderless.swift
//  NSVisualEffectDemo
//
//  Created by 戴植锐 on 2018/3/1.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class WindowBorderless: NSWindow {
    override var canBecomeKey: Bool {
        return true
    }
    
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)
        self.isMovableByWindowBackground = true
    }
}
