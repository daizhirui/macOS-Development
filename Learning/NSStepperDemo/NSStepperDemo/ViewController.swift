//
//  ViewController.swift
//  NSStepperDemo
//
//  Created by 戴植锐 on 2018/3/4.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var stepperTextField: NSTextField!
    @IBOutlet weak var stepper: NSStepper!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func stepperAction(_ sender: NSStepper) {
        let theValue = sender.intValue
        self.stepperTextField.intValue = theValue
    }
    
    override func controlTextDidChange(_ obj: Notification) {
        let textField = obj.object as! NSTextField
        self.stepper.intValue = textField.intValue
    }
    
}

