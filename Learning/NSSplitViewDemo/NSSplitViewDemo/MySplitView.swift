//
//  MySplitView.swift
//  NSSplitViewDemo
//
//  Created by 戴植锐 on 2018/3/4.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class MySplitView: NSSplitView {
    override var dividerColor: NSColor {
        return NSColor.blue
    }
    
    override func drawDivider(in rect: NSRect) {
        let dividerRect = rect.insetBy(dx: -1, dy: -1)
        let path = NSBezierPath(rect: dividerRect)
        NSColor.orange.setStroke()
        path.stroke()
    }
}
