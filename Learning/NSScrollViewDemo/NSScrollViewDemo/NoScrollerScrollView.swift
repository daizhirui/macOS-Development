//
//  NoScrollerScrollView.swift
//  NSScrollViewDemo
//
//  Created by 戴植锐 on 2018/3/2.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class NoScrollerScrollView: NSScrollView {
    
    override func tile() {
        super.tile()
        var hFrame = self.horizontalScroller?.frame
        hFrame?.size.height = 0
        if let hFrame = hFrame {
            self.horizontalScroller?.frame = hFrame
        }
        
        var vFrame = self.verticalScroller?.frame
        vFrame?.size.width = 0
        if let vFrame = vFrame {
            self.verticalScroller?.frame = vFrame
        }
    }
}
