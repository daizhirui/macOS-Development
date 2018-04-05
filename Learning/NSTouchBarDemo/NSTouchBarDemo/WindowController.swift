//
//  WindowController.swift
//  NSTouchBarDemo
//
//  Created by 戴植锐 on 2018/3/6.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
    
    @IBAction func touchBarBuildButtonAction(_ sender: NSButton) {
        print("clicked Button")
    }
    
    @IBAction func touchBarSegmentAction(_ sender: NSSegmentedControl) {
        print("clicked segment index \(sender.selectedSegment)")
    }
    
    @IBAction func touchBarSliderAction(_ sender: NSSlider) {
        print("slider value \(sender.intValue)")
    }
    
}
