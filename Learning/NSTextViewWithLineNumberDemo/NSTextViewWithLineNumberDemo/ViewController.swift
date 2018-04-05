//
//  ViewController.swift
//  NSTextViewWithLineNumberDemo
//
//  Created by 戴植锐 on 2018/3/17.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var textView: NSTextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textView.lnv_setUpLineNumberView()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

