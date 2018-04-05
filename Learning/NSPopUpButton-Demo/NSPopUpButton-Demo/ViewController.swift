//
//  ViewController.swift
//  NSPopUpButton-Demo
//
//  Created by 戴植锐 on 2018/3/3.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var popUpButton: NSPopUpButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func dynamicDataConfig() {
        let items = ["1", "2", "3"]
        self.popUpButton.removeAllItems()
        self.popUpButton.addItems(withTitles: items)
        self.popUpButton.selectItem(at: 0)
    }
    
    @IBAction func popUpButtonAction(_ sender: NSPopUpButton) {
        // all the items
        let items = sender.itemTitles
        // the selected index
        let index = sender.indexOfSelectedItem
        // the selected content
        let title1 = items[index]
        // or
        let title2 = (sender.selectedItem?.title)!
        print("index = \(index)")
        print("title1 = \(title1)")
        print("title2 = \(title2)")
    }
    

}

