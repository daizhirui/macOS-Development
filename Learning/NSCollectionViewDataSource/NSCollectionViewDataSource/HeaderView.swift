//
//  HeaderView.swift
//  NSCollectionViewDataSource
//
//  Created by 戴植锐 on 2018/3/5.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class HeaderView: NSView {
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        NSColor.green.setFill()
        dirtyRect.fill()
        // Drawing code here.
    }
}
