//
//  ViewController.swift
//  NSProgressIndicatorDemo
//
//  Created by 戴植锐 on 2018/3/4.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var hProgressIndicator: NSProgressIndicator!
    @IBOutlet weak var sProgressIndicator: NSProgressIndicator!
    @IBOutlet weak var hIndeterProgressIndicator: NSProgressIndicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hProgressIndicator.doubleValue = 0
        self.hIndeterProgressIndicator.isHidden = true
        self.createProgressIndicator()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func startAction(_ sender: NSButton) {
        self.hProgressIndicator.startAnimation(self)
        self.hIndeterProgressIndicator.isHidden = false
        self.hIndeterProgressIndicator.startAnimation(self)
    }
    
    @IBAction func stopAction(_ sender: NSButton) {
        self.hProgressIndicator.stopAnimation(self)
        self.hIndeterProgressIndicator.isHidden = true
        self.hIndeterProgressIndicator.stopAnimation(self)
    }
    
    @IBAction func stepperAction(_ sender: NSStepper) {
        let doubleValue = sender.doubleValue
        self.hProgressIndicator.doubleValue = doubleValue
        self.sProgressIndicator.doubleValue = doubleValue
    }
    
    func createProgressIndicator() {
        let progressIndicator = NSProgressIndicator()
        progressIndicator.frame = NSRect(x: 50, y: 50, width: 40, height: 40)
        progressIndicator.style = .spinning
        // progressIndicator.isIndeterminate = false
        self.view.addSubview(progressIndicator)
        progressIndicator.startAnimation(self)
    }
    
}

