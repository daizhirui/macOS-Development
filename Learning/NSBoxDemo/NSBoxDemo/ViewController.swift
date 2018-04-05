//
//  ViewController.swift
//  NSBoxDemo
//
//  Created by 戴植锐 on 2018/3/4.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let boxFrame = CGRect(x: 200, y: 140, width: 160, height: 100)
        let box = NSBox(frame: boxFrame)
        box.boxType = .primary
        let margin = NSSize(width: 20, height: 20)
        box.contentViewMargins = margin
        box.title = "Box"
        
        let textFieldFrame = CGRect(x: 10, y: 10, width: 80, height: 20)
        let textField = NSTextField(frame: textFieldFrame)
        box.contentView?.addSubview(textField)
        
        self.view.addSubview(box)
        
        let frame = CGRect(x: 15, y: 250, width: 250, height: 1)
        let horizontalSeparator = NSBox(frame: frame)
        horizontalSeparator.boxType = .separator
        self.view.addSubview(horizontalSeparator)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

