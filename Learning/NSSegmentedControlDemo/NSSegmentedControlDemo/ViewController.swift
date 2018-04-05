//
//  ViewController.swift
//  NSSegmentedControlDemo
//
//  Created by 戴植锐 on 2018/3/3.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func segmentedControlAction(_ sender: NSSegmentedControl) {
        let tag = sender.selectedSegment
        Swift.print("selection index = \(tag)")
    }
    
}

