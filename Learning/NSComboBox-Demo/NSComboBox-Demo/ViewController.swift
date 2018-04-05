//
//  ViewController.swift
//  NSComboBox-Demo
//
//  Created by 戴植锐 on 2018/3/3.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSComboBoxDelegate, NSComboBoxDataSource {

    @IBOutlet weak var staticDataComboBoc: NSComboBox!
    @IBOutlet weak var dynamicDataComboBox: NSComboBox!
    @IBOutlet weak var dataSourceComboBox: NSComboBox!
    
    var data: [String] = ["China", "Germany", "Japan"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dynamicComboBoxConfig()
        self.dataSourceComboBoxConfig()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func selectionAction(_ sender: NSComboBox) {
        // 选项编号
        let selectedIndex = sender.indexOfSelectedItem
        // 选项内容
        let selectedContent = sender.stringValue
        print("selectedIndex: \(selectedIndex) selectedContent: \(selectedContent)")
    }
    
    func dynamicComboBoxConfig() {
        let items = ["1", "2", "3"]
        // 删除默认的初始数据
        self.dynamicDataComboBox.removeAllItems()
        // 增加数据 items
        self.dynamicDataComboBox.addItems(withObjectValues: items)
        // 设置第一行数据为当前选中的数据
        self.dynamicDataComboBox.selectItem(at: 0)
    }
    
    func dataSourceComboBoxConfig() {
        self.dataSourceComboBox.usesDataSource = true
        self.dataSourceComboBox.dataSource = self
        self.dataSourceComboBox.delegate = self
        self.dataSourceComboBox.selectItem(at: 0)
    }
    
    func numberOfItems(in comboBox: NSComboBox) -> Int {
        return self.data.count
    }
    
    func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
        return self.data[index]
    }
    
    func comboBoxSelectionDidChange(_ notification: Notification) {
        let comboBox = notification.object as! NSComboBox
        let selectedIndex = comboBox.indexOfSelectedItem
        let selectedContent = comboBox.stringValue
        print("dataSourceComboBox selectedIndex = \(selectedIndex) selectedContent = \(selectedContent)")
    }
    
    @IBAction func selectionChanged(_ sender: NSComboBox) {
        let selectedIndex = sender.indexOfSelectedItem
        let selectedContent = sender.stringValue
        print("dataSourceComboBox selectedIndex: \(selectedIndex) selectedContent: \(selectedContent)")
    }
    
    
}

