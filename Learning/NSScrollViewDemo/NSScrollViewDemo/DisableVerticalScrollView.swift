//
//  DisableVerticalScrollView.swift
//  NSScrollViewDemo
//
//  Created by 戴植锐 on 2018/3/2.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class DisableVerticalScrollView: NSScrollView {
    override func scrollWheel(with event: NSEvent) {
        let f = abs(event.deltaY)
        if event.deltaX == 0.0 && f >= 0.01 {
            return
        }
        else if event.deltaX == 0.0 && f == 0.0 {
            return
        }
        else {
            super.scrollWheel(with: event)
        }
    }
}
