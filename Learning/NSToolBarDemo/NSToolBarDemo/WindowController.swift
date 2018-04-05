//
//  WindowController.swift
//  NSToolBarDemo
//
//  Created by 戴植锐 on 2018/3/7.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
    
    @IBOutlet weak var openToolbarItem: NSToolbarItem!
    
    @IBAction func openToolbarItemAction(_ sender: NSToolbarItem) {
        print(sender.tag)
        let openDlg = NSOpenPanel()
        openDlg.canChooseFiles = true
        openDlg.canChooseDirectories = false
        openDlg.allowsMultipleSelection = false
        openDlg.allowedFileTypes = ["txt"]
        
        openDlg.begin(completionHandler: {[weak self] result in
            if (result.rawValue == NSApplication.ModalResponse.OK.rawValue) {
                let fileURLs = openDlg.urls
                for url: URL in fileURLs {
                    guard let text = try? NSString.init(contentsOf: url, encoding: String.Encoding.utf8.rawValue)
                        else {
                            return
                    }
                    print(text)
                }
            }
        })
    }
    // 禁用某个 Toolbar Item
    override func validateToolbarItem(_ item: NSToolbarItem) -> Bool {
        if item.label == "Open" {
            return true
        }
        return true
    }
    
}
