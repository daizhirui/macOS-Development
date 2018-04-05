//
//  ViewController.swift
//  NSTabViewDemo
//
//  Created by 戴植锐 on 2018/3/6.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var tabView: NSTabView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func addTabButtonAction(_ sender: NSButton) {
        let tabViewItem = NSTabViewItem(identifier: "Untitled")
        tabViewItem.label = "Untitled"
        let view = NSView(frame: NSZeroRect)
        tabViewItem.view = view
        self.tabView.addTabViewItem(tabViewItem)
    }
    
}

extension ViewController: NSTabViewDelegate {
    func tabView(_ tabView: NSTabView, didSelect tabViewItem: NSTabViewItem?) {
        print("tabView title: \(String(describing: tabViewItem?.label)) identifier: \(String(describing: tabViewItem?.identifier))")
    }
    
}
