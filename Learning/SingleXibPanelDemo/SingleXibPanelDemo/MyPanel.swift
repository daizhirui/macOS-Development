//
//  MyPanel.swift
//  SingleXibPanelDemo
//
//  Created by 戴植锐 on 2018/3/7.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class MyPanel: NSPanel {
    
    static let kCancelCode = 0
    static let kOkCode = 1
    
    var datas = [NSDictionary]()
    @IBOutlet weak var tableView: NSTableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.updateData()
    }
    
    func updateData() {
        self.datas = [
            ["name":"john", "address":"USA"],
            ["name":"mary", "address":"China"],
            ["name":"park", "address":"Japan"],
            ["name":"Daba", "address":"Russia"],
        ]
    }
    
    @IBAction func okButtonAction(_ sender: NSButton) {
        self.parent?.endSheet(self, returnCode: NSApplication.ModalResponse(rawValue: MyPanel.kOkCode))
    }
    
    @IBAction func cancelButtonAction(_ sender: NSButton) {
        self.parent?.endSheet(self, returnCode: NSApplication.ModalResponse(MyPanel.kCancelCode))
    }
}

extension MyPanel: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.datas.count
    }
}

extension MyPanel: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let data = self.datas[row]
        // 表格列的标识
        let key = (tableColumn?.identifier)!
        // 单元格数据
        let value = data[key]
        // 根据表格列的标识，创建单元视图
        let view = tableView.makeView(withIdentifier: key, owner: self)
        let subviews = view?.subviews
        if (subviews?.count)! <= 0 {
            return nil
        }
        
        if key.rawValue == "name" || key.rawValue == "address" {
            let textField = subviews?[0] as! NSTextField
            if value != nil {
                textField.stringValue = value as! String
            }
        }
        return view
    }
}
