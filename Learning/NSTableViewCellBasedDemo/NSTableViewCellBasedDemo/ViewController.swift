//
//  ViewController.swift
//  NSTableViewDemo
//
//  Created by 戴植锐 on 2018/3/7.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!
    var datas = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableStyleConfig()
        self.updateData()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func tableStyleConfig() {
        // 表格网线设置：虚线水平网格线，实线竖直网格线
        self.tableView.gridStyleMask = [NSTableView.GridLineStyle.dashedHorizontalGridLineMask, NSTableView.GridLineStyle.solidVerticalGridLineMask]
        // 表格背景
        self.tableView.backgroundColor = NSColor.blue
        // 背景颜色交替
        self.tableView.usesAlternatingRowBackgroundColors = true
        // 表格行选中样式
        self.tableView.selectionHighlightStyle = .sourceList
    }
    
    func updateData() {
        self.datas = [
            ["name":"john","address":"USA","gender":"male","married":(1)],
            ["name":"mary","address":"China","gender":"female","married":(0)],
            ["name":"park","address":"Japan","gender":"male","married":(0)],
            ["name":"Daba","address":"Russia","gender":"female","married":(1)],
        ]
    }

}

extension ViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.datas.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        let data = self.datas[row]
        // 表格列的标识
        let key = tableColumn?.identifier
        // 单元格数据
        let value = data[key!]
        return value
    }
    
    func tableView(_ tableView: NSTableView, setObjectValue object: Any?, for tableColumn: NSTableColumn?, row: Int) {
        let data = self.datas[row]
        let key = tableColumn?.identifier
        let editData = NSMutableDictionary.init(dictionary: data)
        editData[key!] = object
        self.datas[row] = editData
    }
}

