//
//  ViewController.swift
//  NSPopoverDemo
//
//  Created by 戴植锐 on 2018/3/6.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    lazy var sharePopover: NSPopover = {
        let popover = NSPopover()
        let controller = self.storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("Share")) as! NSViewController
        popover.contentViewController = controller
        popover.behavior = .transient
        return popover
    }()
    
    lazy var feedbackPopover: NSPopover = {
       let popover = NSPopover()
        let controller = self.storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("Feedback")) as! NSViewController
        popover.contentViewController = controller
        popover.behavior = .semitransient
        return popover
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func sharePopoverAction(_ sender: NSButton) {
        self.sharePopover.show(relativeTo: sender.bounds, of: sender, preferredEdge: .maxY)
    }
    
    @IBAction func feedbackPopoverAction(_ sender: NSButton) {
        self.feedbackPopover.show(relativeTo: sender.bounds, of: sender, preferredEdge: .minX)
    }
    
    
    
}

