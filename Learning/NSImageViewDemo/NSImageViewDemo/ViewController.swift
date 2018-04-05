//
//  ViewController.swift
//  NSImageViewDemo
//
//  Created by 戴植锐 on 2018/3/4.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var imageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func roundedButtonAction(_ sender: NSButton) {
        self.imageView.wantsLayer = true
        self.imageView.layer?.masksToBounds = true
        self.imageView.layer?.cornerRadius = 20
        self.imageView.layer?.borderWidth = 2
        self.imageView.layer?.borderColor = NSColor.green.cgColor
    }
    
}

