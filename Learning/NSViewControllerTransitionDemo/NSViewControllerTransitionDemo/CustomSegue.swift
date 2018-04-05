//
//  CustomSegue.swift
//  NSViewControllerTransitionDemo
//
//  Created by 戴植锐 on 2018/3/9.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class CustomSegue: NSStoryboardSegue {
    override func perform() {
        let sourceViewController = self.sourceController as! NSViewController
        let destinationViewController = self.destinationController as! NSViewController
        let animator = PresentCustomAnimator()
        sourceViewController.presentViewController(destinationViewController, animator: animator)
    }
}
