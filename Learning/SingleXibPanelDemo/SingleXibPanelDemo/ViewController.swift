//
//  ViewController.swift
//  SingleXibPanelDemo
//
//  Created by 戴植锐 on 2018/3/7.
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
    
    var topLevelArray: NSArray?
    lazy var myPanel: MyPanel? = {
        var panel: MyPanel?
        let nib = NSNib.init(nibNamed: NSNib.Name(rawValue: "MyPanel"), bundle: Bundle.main)
        if let success = nib?.instantiate(withOwner: self, topLevelObjects: &topLevelArray) {
            if success {
                for obj in self.topLevelArray! {
                    if obj is MyPanel {
                        panel = obj as? MyPanel
                        break
                    }
                }
            }
        }
        return panel
    }()

    @IBAction func showPanelAction(_ sender: NSButton) {
        self.myPanel?.parent = self.view.window
        self.view.window?.beginSheet(self.myPanel!, completionHandler: { returnCode in
            if returnCode.rawValue == MyPanel.kOkCode {
                print("returnCode \(returnCode), OK")
            }
            if returnCode.rawValue == MyPanel.kCancelCode {
                print("returnCode \(returnCode), Cancel")
            }
        })
    }
    
}

